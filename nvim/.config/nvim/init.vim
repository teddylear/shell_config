set termguicolors

call plug#begin("~/.config/nvim/plugged")
" Plugin Section
" color scheme plugin
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" smart comments
Plug 'preservim/nerdcommenter'

" Floating menus
Plug 'voldikss/vim-floaterm'

" teriminal navigator
" TODO have to figure out the best way of doing this
" Still can't get this working in current workflow
Plug 'ThePrimeagen/harpoon'

" adds glyphcons to various vim plugins
Plug 'ryanoasis/vim-devicons'

" luastatus line
Plug 'hoob3rt/lualine.nvim'

" git integration for vim
Plug 'tpope/vim-fugitive'

" Vim Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" Telescope stuffs
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Closing brackets and such
Plug 'jiangmiao/auto-pairs'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'lspcontainers/lspcontainers.nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'

" Neovim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" autocomplete
Plug 'hrsh7th/nvim-compe'

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

Plug 'folke/todo-comments.nvim'

call plug#end()

syntax on
filetype plugin indent on

" changing leader key for any jump to be easier
let mapleader=" "

" Calling my lua config
lua require("myluaconf")

" Shows Git history for the current buffer
" TODO update this to be easier
command! FileHistory execute ":BCommits"

" loads latest configuration
command! Reload execute "source $MYVIMRC"

" Opens up nvim config
command! Config execute ":e $MYVIMRC"

" setting clipboard so that copy pasting works
if has("mac")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

"set mouse wheel to work
set mouse=a

" Python spacing
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

"" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

" Settings so it doesn't automatically autocomplete
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Setting so that fuzzy is part of complete
" TODO can I still use this without fzf plugin
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Create default mappings for smart comments
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Harpoon to open a buffer
" TODO move these two commands to lua
nmap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
tnoremap jk <C-\><C-n>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup THE_KENSTER
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

fun! NewNote()
    read ~/.config/nvim/templateFiles/new_note.md
    call cursor( line('.')-1, 1)
    delete
endfun

let g:python3_host_prog=$HOME . '/.pyenv/shims/python'
