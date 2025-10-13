-- Add vim-test plugin
vim.pack.add({ "https://github.com/vim-test/vim-test.git" })

-- Configure vim-test to use neovim-sticky strategy
vim.g['test#strategy'] = 'neovim_sticky'
vim.g['test#go#runner'] = 'gotest'
vim.g['test#go#gotest#options'] = '-v -coverprofile=coverage.out'

-- Setup vim-test with neovim-sticky strategy
vim.cmd([[
  let g:test#strategy = 'neovim_sticky'
  let g:test#go#runner = 'gotest'
  let g:test#go#gotest#options = '-v -coverprofile=coverage.out'
]])