syntax on
filetype plugin indent on

call plug#begin("~/.config/nvim/plugged")
" Plugin Section
" color scheme plugin
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'

" tree explorer plugin for vim
Plug 'preservim/nerdtree'

" adds syntax for nerdtree on most common file extensions
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" nerdtree plugin for showing git status flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" adds glyphcons to various vim plugins
Plug 'ryanoasis/vim-devicons'

" luastatus line
Plug 'hoob3rt/lualine.nvim'

" git integration for vim
Plug 'tpope/vim-fugitive'

" Vim Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Telescope stuffs
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Closing brackets and such
Plug 'jiangmiao/auto-pairs'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Provides semantic highlighting for Python in Neovim
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" allows users to find definitions for functions
" Plug 'pechorin/any-jump.vim'

" TODO fix annoying issues where comments carry over to next line in init.vim
" adding game for improvement
Plug 'ThePrimeagen/vim-be-good'

" Better syntax highlighting for puppet
Plug 'rodjek/vim-puppet'

" Better syntax highlighting for nginx
Plug 'chr4/nginx.vim'

"Better syntax highlighting for terraform
Plug 'hashivim/vim-terraform'

Plug 'tjdevries/cyclist.vim'
Plug 'tpope/vim-dispatch'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

set guicursor=
" Everything after this line will be the config section

" Shows Git history for the current buffer
" TODO update this to be easier
command! FileHistory execute ":BCommits"

" changing leader key for any jump to be easier
let mapleader=" "

" loads latest configuration
command! Reload execute "source $MYVIMRC"

" Opens up nvim config
command! Config execute ":e $MYVIMRC"

set termguicolors
colorscheme onedark
set background=dark
set colorcolumn=80
highlight ColorColumn ctermbg=236
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4
set autoindent
set number relativenumber
set nowrap
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set cmdheight=2

" remap ecs to jk
inoremap jk <ESC>
inoremap JK <ESC>

" setting clipboard so that copy pasting works
set clipboard=unnamed

" enabling syntax highlighting
syntax on

" set 'nerd' to show :NERDTree command
nnoremap nerd :NERDTree

" This lines is needed to avoid error with NERDTree
let g:NERDTreePatternMatchHighlightColor = {}
let g:NERDTreeExtensionHighlightColor = {}

" show hidden files in nerdtree
let g:NERDTreeShowHidden = 1

" hide helper
let g:NERDTreeMinimalUI = 1

" ignore node_modules to increase load speed
let g:NERDTreeIgnore = ['^node_modules$']

" set to empty to use lightline
let g:NERDTreeStatusline = ''

" Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1

" Highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1

" Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree Git Plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Output of fuzzy search to go to new tab, vertical split or horizontal split
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Requires ripgrep
" https://github.com/BurntSushi/ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

" size of window
let g:fzf_layout = { 'window': { 'width': 1.00, 'height': 1.00 } }

" fuzzy search for lines in curent buffer
nmap // :BLines<CR>

" ripgrep in curreny directory
nmap ?? :Rg<CR>

"set mouse wheel to work
set mouse=a

" Python spacing
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

" TextEdit might fail if hidden is not set.
set hidden

"" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

" Settings so it doesn't automatically autocomplete
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Setting so that fuzzy is part of complete
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" setting up lsp servers
" requires adding server by running 'pip install python-language-server'
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }

" This comes with the latest go distribution
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }

" See installation instructions on github for terraform-ls
lua require'lspconfig'.terraformls.setup{ on_attach=require'completion'.on_attach }

" See installation instructions on github for terraform-ls
lua require'lspconfig'.vimls.setup{ on_attach=require'completion'.on_attach }

" lsp configuration configuration
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gfh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>

" lualine configuration
lua << EOF
local lualine = require('lualine')
lualine.status()
lualine.separator = '|'
lualine.extensions = { 'fzf' }
lualine.theme = 'onedark'
EOF

" copying prime's telescope configuration
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_KENSTER
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
