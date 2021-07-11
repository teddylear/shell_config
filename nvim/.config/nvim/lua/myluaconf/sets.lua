local homedir = os.getenv "HOME"

vim.g.mapleader = " " -- settings leader key to space

vim.o.syntax = "on"
vim.o.softtabstop = 2
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.scrolloff = 8
vim.o.backup = false

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

-- Settings so it doesn't automatically autocomplete
vim.opt.completeopt = { "menuone",  "noinsert", "noselect" }

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { "80" }
vim.opt.signcolumn = "yes"
vim.opt.background = "dark"
vim.opt.incsearch = true
vim.opt.undofile = true

-- set mouse wheel to work
vim.opt.mouse = "a"

vim.opt.undodir = homedir .. "/.vim/undodir"

-- setting clipboard so that copy pasting works
if vim.fn.has("mac") then
  vim.opt.clipboard = "unnamed"
else
  vim.opt.clipboard = "unnamedplus"
end

vim.opt.guicursor = ""

-- vim.cmd("colorscheme gruvbox-flat")

-- Create default mappings for smart comments
vim.cmd("let g:NERDCreateDefaultMappings = 1")

-- Add spaces after comment delimiters by default
vim.cmd("let g:NERDSpaceDelims = 1")

-- local python3_host_prog_path = homedir .. "/.pyenv/shims/python"
vim.cmd[[let g:python3_host_prog=$HOME . '/.pyenv/shims/python']]
