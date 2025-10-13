-- Keybindings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'Show hover info' })

-- Symbol search (like VSCode Cmd+P then @)
vim.keymap.set('n', '<leader>2', vim.lsp.buf.document_symbol, { desc = 'Find symbols in file (@)' })
vim.keymap.set('n', '<leader>p', vim.lsp.buf.workspace_symbol, { desc = 'Find symbols in workspace' })





vim.keymap.set('n', '<leader>rn', function()
    if vim.bo.modifiable then
        vim.lsp.buf.rename()
    else
        vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    end
end, { desc = 'Rename symbol' })

vim.keymap.set('n', '<leader>ca', function()
    if vim.bo.modifiable then
        vim.lsp.buf.code_action()
    else
        vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    end
end, { desc = 'Code action' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = 'Previous diagnostic' })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '<leader>lf', function()
    if vim.bo.modifiable then
        vim.lsp.buf.format()
    else
        vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    end
end, { desc = 'Format buffer' })

vim.keymap.set('n', '<leader>oi', function()
    if vim.bo.modifiable then
        vim.lsp.buf.code_action({
            context = { only = { 'source.organizeImports' } },
            apply = true, -- Auto-apply if only one action
        })
    else
        vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    end
end, { desc = 'Organize imports' })

-- Window navigation (much more comfortable than Ctrl+w)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>th', ':tabprev<CR>', { desc = 'Previous tab' })

-- Window splitting
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>sc', ':close<CR>', { desc = 'Close window' })

-- Test running (using vim-test with neovim strategy)
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('TestNearest')
    -- Auto-run coverage after test (with delay to let test complete)
    vim.defer_fn(function()
        vim.cmd('Coverage')
    end, 2000)
end, { desc = 'Test: Run nearest test' })

vim.keymap.set('n', '<leader>tf', function()
    vim.cmd('TestFile')
    -- Auto-run coverage after test (with delay to let test complete)
    vim.defer_fn(function()
        vim.cmd('Coverage')
    end, 2000)
end, { desc = 'Test: Run current file' })

vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>', { desc = 'Test: Run test suite' })
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = 'Test: Run last test' })
vim.keymap.set('n', '<leader>tg', ':TestVisit<CR>', { desc = 'Test: Visit test file' })

-- Terminal toggle (for sticky test terminal)
vim.keymap.set('n', '<leader>te', function()
    -- Check if we're already in a terminal window
    if vim.bo.buftype == 'terminal' then
        vim.cmd('q') -- Close current terminal window
        return
    end
    
    -- Try to find existing terminal buffer
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if vim.bo[buf].buftype == 'terminal' and vim.api.nvim_buf_is_loaded(buf) then
            -- Check if terminal window is already visible
            local wins = vim.api.nvim_list_wins()
            for _, win in ipairs(wins) do
                if vim.api.nvim_win_get_buf(win) == buf then
                    vim.api.nvim_set_current_win(win)
                    return
                end
            end
            -- Terminal exists but not visible, show it
            vim.cmd('split | buffer ' .. buf)
            return
        end
    end
    
    -- No terminal found, create one
    vim.cmd('terminal')
end, { desc = 'Toggle test terminal' })

-- Exit terminal mode with Ctrl+o (avoids WezTerm conflict)
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Faster scrolling with Ctrl+e and Ctrl+y (2x speed)
vim.keymap.set('n', '<C-e>', '2<C-e>', { desc = 'Scroll down faster' })
vim.keymap.set('n', '<C-y>', '2<C-y>', { desc = 'Scroll up faster' })

