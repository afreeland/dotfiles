vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter.git" })

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'go', 'lua', 'python', 'javascript', 'typescript' },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})
