call plug#begin("~/.config/nvim/plugged")
  " Plugin Section

  " color scheme plugin
  Plug 'dracula/vim', { 'name': 'dracula' }

  " tree explorer plugin for vim
  Plug 'preservim/nerdtree'

  " adds syntax for nerdtree on most common file extensions
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " nerdtree plugin for showing git status flags
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " adds glyphcons to various vim plugins
  Plug 'ryanoasis/vim-devicons'

  " Vim Tmux Integration
  Plug 'christoomey/vim-tmux-navigator'

  " fuzzy search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " Closing brackets and such
  Plug 'jiangmiao/auto-pairs'

  " statusline for vim
  Plug 'vim-airline/vim-airline'

call plug#end()
" Everything after this line will be the config section

" using termguicolors if present
if (has("termguicolors"))
 set termguicolors
endif

" Setting background to be dark
set background=dark

" Setting colorscheme to be dracula
colorscheme dracula

" Setting tabs to spaces
set expandtab

" Setting number of spaces when tab is pressed
set tabstop=2

" Setting number of spaces when indenting
set shiftwidth=2

" Automatically indent lines when going to new line
set autoindent

" setting line numbers
set number

" set no wrap text
set nowrap

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

" fuzzy search remapped to control P
nnoremap <C-p> :FZF<CR>

" Output of fuzzy search to go to new tab, vertical split or horizontal split
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"set mouse wheel to work
set mouse=a

" Python spacing
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

"Enabling Airline plugin
let g:airline#extensions#tabline#enabled = 1
