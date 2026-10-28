vim.api.nvim_create_user_command('Restart', function()
    vim.cmd('source ~/.config/nvim/init.lua')
end, { force = true })

-- Make JSON objects and arrays foldable without creating manual folds.
local function enable_json_folds()
    vim.wo.foldenable = true
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldlevel = 99
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'json',
    group = vim.api.nvim_create_augroup('json_folds', { clear = true }),
    callback = enable_json_folds,
})

-- Also handle re-sourcing the config while a JSON buffer is already open.
if vim.bo.filetype == 'json' then
    enable_json_folds()
end


-- Filetypes that this repo formats with Prettier (per its .prettierrc), NOT the
-- language server. vim.lsp.buf.format() would call vtsls/tsserver's built-in
-- formatter, which disagrees with Prettier and would lose the fight with the
-- repo's lint-staged pre-commit hook. So we shell out to the project-local
-- prettier binary instead, matching CI exactly.
local prettier_filetypes = {
    javascript = true,
    javascriptreact = true,
    typescript = true,
    typescriptreact = true,
    json = true,
    jsonc = true,
    css = true,
    scss = true,
    html = true,
    yaml = true,
    markdown = true,
}

-- Walk up from the file to find the nearest node_modules/.bin/prettier so we use
-- the version the repo pins (and CI uses), never a global prettier.
local function find_prettier(bufname)
    for dir in vim.fs.parents(bufname) do
        local candidate = dir .. '/node_modules/.bin/prettier'
        if vim.uv.fs_stat(candidate) then
            return candidate
        end
    end
    return nil
end

-- Format the buffer through prettier's stdin so we never touch disk or trigger a
-- reload; --stdin-filepath lets prettier resolve .prettierrc + the right parser.
local function prettier_format(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local prettier = find_prettier(bufname)
    if not prettier then
        return -- no local prettier (e.g. deps not installed); skip silently
    end

    local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n')
    local result = vim.system(
        { prettier, '--stdin-filepath', bufname },
        { stdin = input, text = true }
    ):wait()

    if result.code ~= 0 or not result.stdout or #result.stdout == 0 then
        if result.stderr and #result.stderr > 0 then
            vim.notify('prettier: ' .. result.stderr, vim.log.levels.WARN)
        end
        return
    end

    local formatted = result.stdout:gsub('\n$', '') -- drop trailing newline; nvim implies it
    local lines = vim.split(formatted, '\n', { plain = true })
    if table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n') == formatted then
        return -- already formatted; avoid a no-op change that dirties undo/view
    end
    local view = vim.fn.winsaveview()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.fn.winrestview(view)
end

-- Run ESLint's fixAll autofix synchronously (fixable rules + import sorting)
-- before Prettier, so Prettier always gets the last word on pure formatting.
-- Mirrors the Go source.organizeImports autocmd below, but forced sync so the
-- edits land before we format.
local function eslint_fix_sync(bufnr)
    local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'eslint' })
    if #clients == 0 then
        return
    end
    local client = clients[1]
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { 'source.fixAll.eslint' }, diagnostics = {} }

    local resp = client:request_sync('textDocument/codeAction', params, 2000, bufnr)
    if not (resp and resp.result) then
        return
    end
    for _, action in ipairs(resp.result) do
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end
        if action.command then
            local cmd = type(action.command) == 'table' and action.command or action
            client:request_sync('workspace/executeCommand', cmd, 2000, bufnr)
        end
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        if not vim.bo[args.buf].modifiable then
            vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
            return
        end
        if prettier_filetypes[vim.bo[args.buf].filetype] then
            eslint_fix_sync(args.buf)
            prettier_format(args.buf)
        else
            vim.lsp.buf.format()
        end
    end,
})

-- Refresh code lenses (test/govulncheck) so `grx` has something to run.
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    pattern = "*.go",
    callback = function()
        vim.lsp.codelens.refresh({ bufnr = 0 })
    end,
})

-- Auto-coverage on Go file open (VS Code-like behavior)
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.go",
    callback = function()
        -- Only run coverage if we're in a Go project
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/go.mod") == 1 then
            -- Run coverage for current package
            vim.defer_fn(function()
                vim.cmd('Coverage')
            end, 500)
        end
    end,
})

-- Auto-organize imports on Go file save (before formatting)
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        if vim.bo.modifiable then
            -- Organize imports before formatting
            vim.lsp.buf.code_action({
                context = { only = { 'source.organizeImports' } },
                apply = true, -- Auto-apply if only one action
            })
        end
    end,
})

-- Auto-coverage on Go file save (VS Code-like behavior)
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    callback = function()
        -- Only run coverage if we're in a Go project
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/go.mod") == 1 then
            -- Run coverage for current package
            vim.defer_fn(function()
                vim.cmd('Coverage')
            end, 500)
        end
    end,
})
