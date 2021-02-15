set termguicolors

call plug#begin("~/.config/nvim/plugged")
" Plugin Section
" color scheme plugin
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'

" teriminal navigator
Plug 'ThePrimeagen/harpoon'

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

syntax on
filetype plugin indent on

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
if has("mac")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif


" enabling syntax highlighting
syntax on


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

" Harpoon to open a buffer
nmap <leader>tu :call GotoBuffer(0)<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_KENSTER
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

