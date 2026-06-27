vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter.git" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require('nvim-treesitter').setup({
    ensure_installed = { 'go', 'lua', 'python', 'javascript', 'typescript', 'hurl' },
    indent = {
        enable = true,
    },
})

require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local move = require('nvim-treesitter-textobjects.move')
local select = require('nvim-treesitter-textobjects.select')

-- textobject selections
local sel_maps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["aa"] = "@parameter.outer",
    ["ia"] = "@parameter.inner",
    ["ab"] = "@block.outer",
    ["ib"] = "@block.inner",
    ["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
    ["ai"] = "@conditional.outer",
    ["ii"] = "@conditional.inner",
}
for lhs, query in pairs(sel_maps) do
    vim.keymap.set({ 'x', 'o' }, lhs, function()
        select.select_textobject(query, 'textobjects')
    end)
end

-- movement
vim.keymap.set('n', ']f', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set('n', ']c', function() move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set('n', ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
vim.keymap.set('n', ']F', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set('n', ']C', function() move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set('n', '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set('n', '[c', function() move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set('n', '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end)
vim.keymap.set('n', '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set('n', '[C', function() move.goto_previous_end('@class.outer', 'textobjects') end)
