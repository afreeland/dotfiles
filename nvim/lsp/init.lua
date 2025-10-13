-- LSP Server configurations
-- This file can be used to configure additional LSP servers

-- Example: TypeScript/JavaScript LSP
--[[
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  callback = function()
    vim.lsp.start({
      name = 'tsserver',
      cmd = { 'typescript-language-server', '--stdio' },
      root_dir = vim.fs.dirname(vim.fs.find({ 'package.json', 'tsconfig.json' }, { upward = true })[1]),
    })
  end,
})
--]]

-- Example: Python LSP
--[[
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.lsp.start({
      name = 'pyright',
      cmd = { 'pyright-langserver', '--stdio' },
      root_dir = vim.fs.dirname(vim.fs.find({ 'pyproject.toml', 'setup.py', 'requirements.txt' }, { upward = true })[1]),
    })
  end,
})
--]]

-- Example: Rust LSP
--[[
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.lsp.start({
      name = 'rust_analyzer',
      cmd = { 'rust-analyzer' },
      root_dir = vim.fs.dirname(vim.fs.find({ 'Cargo.toml' }, { upward = true })[1]),
    })
  end,
})
--]]