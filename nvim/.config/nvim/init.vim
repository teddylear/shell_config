set termguicolors

call plug#begin("~/.config/nvim/plugged")
" Plugin Section
" color scheme plugin
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" teriminal navigator
" TODO have to figure out the best way of doing this
" Still can't get this working in current workflow
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
Plug 'nvim-telescope/telescope-fzy-native.nvim'

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

Plug 'folke/todo-comments.nvim'

call plug#end()

syntax on
filetype plugin indent on

" Calling my lua config
lua require("myluaconf")

" Shows Git history for the current buffer
" TODO update this to be easier
command! FileHistory execute ":BCommits"

" changing leader key for any jump to be easier
let mapleader=" "

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


"" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

" Settings so it doesn't automatically autocomplete
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Setting so that fuzzy is part of complete
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Harpoon to open a buffer
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

" Setting up treesitter configuration
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" setting up lsp servers
" requires adding server by running 'pip install python-language-server'
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.jedi_language_server.setup{ on_attach=require'completion'.on_attach }

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
