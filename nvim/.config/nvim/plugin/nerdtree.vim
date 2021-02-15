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
