-- Add fyler plugin
vim.pack.add({ 'https://github.com/A7Lavinraj/fyler.nvim.git' })

-- Add required dependency for icons
vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })

-- Add nvim-web-devicons for better icons
vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })

-- Setup fyler immediately
require('fyler').setup({
    close_on_select = true,
    confirm_simple = false,
    default_explorer = false,
    git_status = {
        enabled = true,
        symbols = {
            Untracked = "?",
            Added = "+",
            Modified = "*",
            Deleted = "x",
            Renamed = ">",
            Copied = "~",
            Conflict = "!",
            Ignored = "#",
        },
    },
    icon_provider = "nvim_web_devicons",
    indentscope = {
        enabled = true,
        group = "FylerIndentMarker",
        marker = "│",
    },
    mappings = {
        ["q"] = "CloseView",
        ["<CR>"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["|"] = "SelectVSplit",
        ["-"] = "SelectSplit",
        ["^"] = "GotoParent",
        ["="] = "GotoCwd",
        ["."] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
    },
    track_current_buffer = true,
    win = {
        border = "single",
        kind = "replace",
    },
})

-- Keybindings
vim.keymap.set('n', '<leader>fe', function() require('fyler').open() end, { desc = 'Open Fyler Explorer' })
vim.keymap.set('n', '<leader>fE', function() require('fyler').open({ kind = 'split_left' }) end, { desc = 'Open Fyler Explorer (Split Left)' })