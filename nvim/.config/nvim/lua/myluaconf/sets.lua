local homedir = os.getenv("HOME")

vim.g.mapleader = " " -- settings leader key to space

vim.o.syntax = "on"
vim.o.softtabstop = 4
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.scrolloff = 8
vim.o.backup = false

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false

-- Settings so it doesn't automatically autocomplete
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

vim.opt.autoindent = true
vim.opt.updatetime = 50
vim.opt.winbar = "%=%f"
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
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

if jit.os == "Linux" then
    vim.cmd('let g:netrw_browsex_viewer = "xdg-open"')
end

-- Add spaces after comment delimiters by default
vim.cmd("let g:NERDSpaceDelims = 1")

-- local python3_host_prog_path = homedir .. "/.pyenv/shims/python"
vim.cmd([[let g:python3_host_prog=$HOME . '/.pyenv/shims/python']])

local function transparentBackground()
    local highlight_groups = {
        "Normal",
        "SignColumn",
        "NormalNC",
    }

    for _, group in ipairs(highlight_groups) do
        vim.cmd(string.format("hi! %s ctermbg=NONE guibg=NONE", group))
    end
end

local function trimWhiteSpace()
    vim.cmd("keeppatterns %s/\\s\\+$//e")
    vim.cmd("call winrestview(winsaveview())")
end

local my_augroup = vim.api.nvim_create_augroup("THE_KENSTER", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { callback = trimWhiteSpace, group = my_augroup }
)

vim.api.nvim_create_autocmd(
    "ColorScheme",
    { callback = transparentBackground, group = my_augroup }
)
