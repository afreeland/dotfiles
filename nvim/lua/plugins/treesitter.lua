vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter.git" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git" })

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'go', 'lua', 'python', 'javascript', 'typescript' },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",    -- Select function with braces
                ["if"] = "@function.inner",    -- Select function contents
                ["ac"] = "@class.outer",       -- Select class/struct with braces
                ["ic"] = "@class.inner",       -- Select class/struct contents
                ["aa"] = "@parameter.outer",   -- Select argument with comma
                ["ia"] = "@parameter.inner",   -- Select just the argument
                ["ab"] = "@block.outer",       -- Select block with braces
                ["ib"] = "@block.inner",       -- Select block contents
                ["al"] = "@loop.outer",        -- Select entire loop
                ["il"] = "@loop.inner",        -- Loop body
                ["ai"] = "@conditional.outer", -- If statement with braces
                ["ii"] = "@conditional.inner", -- If body
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- Adds to jumplist
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]a"] = "@parameter.inner", -- Next function argument
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        },
    },
})
