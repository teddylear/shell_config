vim.g.mapleader = " " -- settings leader key to space

vim.bo.expandtab = true

vim.o.softtabstop = 2
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.scrolloff = 8
vim.o.backup = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.cmdheight = 2
vim.opt.colorcolumn = { "80" }

-- Settings so it doesn't automatically autocomplete
vim.opt.completeopt = { "menuone",  "noinsert", "noselect" }

vim.cmd("colorscheme gruvbox-flat")
