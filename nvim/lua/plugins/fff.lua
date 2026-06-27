vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

-- If this doesn't work you can also
-- packadd fff.nvim | lua require("fff.download").download_or_build_binary()
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then vim.cmd.packadd('fff.nvim') end
            require('fff.download').download_or_build_binary()
        end
    end,
})

-- the plugin will automatically lazy load
vim.g.fff = {
    lazy_sync = true,       -- start syncing only when the picker is open
    debug = {
        enabled = false,    -- disable debug to prevent E5560 errors during vimgrep
        show_scores = true, -- keep scores in picker UI
    },
    notify = false,         -- disable all notifications to prevent E5560 errors
}

vim.keymap.set(
    'n',
    'ff',
    function() require('fff').find_files() end,
    { desc = 'FFFind files' }
)

-- Custom fff command that ignores .ignore files
vim.keymap.set(
    'n',
    'FF',
    function()
        -- Try to call fff with ignore disabled
        require('fff').find_files({
            ignore = true,
            respect_gitignore = true,
        })
    end,
    { desc = 'FFFind all files (ignore .ignore)' }
)
