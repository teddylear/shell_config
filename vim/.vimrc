set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"Color schemes
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'joshdick/onedark.vim'

"Make it look like a real IDE
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Autocomplete
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'Shougo/deoplete.nvim'

" Comments
Plugin 'tpope/vim-commentary'

" Search LSP signals
Plugin 'liuchengxu/vista.vim'

" Closing brackets, etc
Plugin 'jiangmiao/auto-pairs'

" ALE Linting
Plugin 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype plugin indent on
syntax on

"indent
set tabstop=4
set shiftwidth=4
set expandtab

set number
set autoindent

" remap ecs to jk
inoremap jk <ESC>
inoremap JK <ESC>

" setting clipboard
set clipboard=unnamed

"colorscheme
syntax on
colorscheme onedark

"Airine Configuration
let g:airline#extensions#tabline#enabled = 1

"NERDTree config
nnoremap nerd :NERDTree
let NERDTreeDirArrows=0

"ignore whitespace at the end of files
if &diff
    " diff mode
    set diffopt+=iwhite
endif

"set mouse wheel to work
set mouse=a

"set vertical line
:set colorcolumn=80
highlight ColorColumn ctermbg=1

set nowrap
set encoding=utf-8

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Python spacing
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

" ALE Linters
let g:ale_linters = {
      \   'python': ['pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

" Show the nearest method/function in the statusline
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

