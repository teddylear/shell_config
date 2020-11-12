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

  " git integration for vim
  Plug 'tpope/vim-fugitive'

  " Vim Tmux Integration
  Plug 'christoomey/vim-tmux-navigator'

  " fuzzy search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Closing brackets and such
  Plug 'jiangmiao/auto-pairs'

  " statusline for vim
  Plug 'vim-airline/vim-airline'

  " autocomplete plugin
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }

  " Linting plugin
  Plug 'dense-analysis/ale'

  " Provides semantic highlighting for Python in Neovim
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

  " TODO this needs a comment
  Plug 'wincent/ferret'

  " allows users to find definitions for functions
  Plug 'pechorin/any-jump.vim'

  call plug#end()

" Everything after this line will be the config section

" Find files with fzf
nmap <leader>p :Files<CR>

" Shows Git history for the current buffer
command! FileHistory execute ":BCommits"

" changing leader key for any jump to be easier
" TODO change this to be spacebar instead
nnoremap <SPACE> <Nop>
let mapleader=" "

" loads latest configuration
" TODO move to lightline to avoid issues
command! Reload execute "source $MYVIMRC"

" Opens up nvim config
command! Config execute ":e $MYVIMRC"


" using termguicolors if present
if (has("termguicolors"))
 set termguicolors
endif


" Setting colorscheme to be onedark
colorscheme onedark
" Setting background to be dark
set background=dark

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

"Enabling Airline plugin
let g:airline#extensions#tabline#enabled = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" rename variable in current file
nmap <leader>rr <Plug>(coc-rename)

" rename variable in current project
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ALE Linters
let g:ale_linters = {
      \   'python': ['pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

