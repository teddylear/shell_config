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


" copying prime's telescope configuration
lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
