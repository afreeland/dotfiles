-- Essentials
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"

-- Search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- File saving
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"

-- UI
vim.o.showmode = false
vim.o.showcmd = true
vim.o.ruler = true
vim.o.laststatus = 2
vim.o.wrap = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Completion
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.completeopt = "menu,menuone,noselect"

-- Performance
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0

-- Colors
vim.o.termguicolors = true

-- OS
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "

-- Window Splitting
vim.o.splitright = true
vim.o.splitbelow = true

-- Dynamic window title showing current directory
vim.o.title = true
vim.o.titlestring = "nvim - %{fnamemodify(getcwd(), ':t')}"

-- Configure ripgrep for :grep command (respect .ignore files)
if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = 'rg --vimgrep --smart-case'
    vim.o.grepformat = '%f:%l:%c:%m'
end

