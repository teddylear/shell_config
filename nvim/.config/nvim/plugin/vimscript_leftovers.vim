command! Reload execute "source $MYVIMRC"
command! Config execute ":e $MYVIMRC"

highlight normal guibg=none

fun! NewNote()
    read ~/.config/nvim/templateFiles/new_note.md
    call cursor( line('.')-1, 1)
    delete
endfun
