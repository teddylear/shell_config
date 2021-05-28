-- TODO determine if I need both of these for python
require'lspconfig'.pyls.setup{
    on_attach=require'completion'.on_attach
}

require'lspconfig'.jedi_language_server.setup{
on_attach=require'completion'.on_attach
}

-- This comes with the latest go distribution
require'lspconfig'.gopls.setup{
    on_attach=require'completion'.on_attach
}

-- See installation instructions on github for terraform-ls
require'lspconfig'.terraformls.setup{
    on_attach=require'completion'.on_attach
}

-- See installation instructions on github for terraform-ls
require'lspconfig'.vimls.setup{
    on_attach=require'completion'.on_attach
}

-- TODO add lua lsp
