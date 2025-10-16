require('config.env')
require('config.options')
require('config.keymap')
require('config.lsp')
require('config.autocmd')
require('plugins.tokyonight')
require('plugins.statusline') -- Provides a better statusline bar
require('plugins.plenary') -- Requirement for coverage 
require('plugins.treesitter') -- Better syntax highlighting, folding
require('plugins.fff') -- Freakishly fast fuzzy finder
require('plugins.dap') -- Debug Adapter Protocol for debugging/breakdpoints
require('plugins.dap-go') -- The Golang Adapter for DAP
require('config.dap-keymaps') -- Some useful maps debugging
require('plugins.fyler') -- File explorer :fe (float) :fE (sticky left pane)
require('plugins.vim-test') -- Quick testing :t (test nearest) :tf (test file) :te (toggle terminal)
require('plugins.coverage') -- Code coverage (requires plenary)
require('plugins.fugitive') -- Git functionality
require('plugins.blink') -- LSP Autocompletion (imports) 
