vim.api.nvim_create_user_command('Restart', function()
    vim.cmd('source ~/.config/nvim/init.lua')
end, {})


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable then
            vim.lsp.buf.format()
        else
            vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
        end
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
vim.keymap.set('n', '<leader>o', function()
  vim.lsp.buf.code_action({
    context = { only = { 'source.organizeImports' } },
    apply = true,
  })
end, { noremap = true, silent = true, buffer = 0, desc = "Organize Imports" })

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
