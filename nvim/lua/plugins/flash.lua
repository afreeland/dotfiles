vim.pack.add({ 'https://github.com/folke/flash.nvim' })

-- flash ships with NO default keymaps, so setup() + explicit binds are required
require('flash').setup({})

-- Jump anywhere on screen: type `s` then the label that appears next to your target
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>s', function() require('flash').jump() end, { desc = 'Flash jump' })

-- Select/expand treesitter nodes: `<leader>s` labels surrounding syntax nodes to jump/select.
-- (Kept off `S` so native `S`/`cc` still clears a line and lands the cursor at the right indent.)
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>S', function() require('flash').treesitter() end,
  { desc = 'Flash treesitter' })
