vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context.git" })
vim.cmd('packadd nvim-treesitter-context')

require('treesitter-context').setup()
