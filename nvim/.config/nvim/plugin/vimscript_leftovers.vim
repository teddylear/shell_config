command! Reload execute "source $MYVIMRC"
command! Config execute ":e $MYVIMRC"

highlight normal guibg=none

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
