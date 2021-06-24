local util = require 'lspconfig/util'

require'lspconfig'.pylsp.setup{
    on_attach=require'completion'.on_attach,
    cmd=require'lspcontainers'.command('pylsp'),
}

require'lspconfig'.gopls.setup{
    on_attach=require'completion'.on_attach,
    cmd=require'lspcontainers'.command('gopls'),
}

require'lspconfig'.terraformls.setup{
    on_attach=require'completion'.on_attach,
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
    cmd=require'lspcontainers'.command('terraformls'),
}

require'lspconfig'.bashls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = require'lspcontainers'.command('bashls'),
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
  on_attach=require'completion'.on_attach,
}

-- See installation instructions on github for vimls
require'lspconfig'.vimls.setup{
    on_attach=require'completion'.on_attach,
}

require'lspconfig'.jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  on_attach=require'completion'.on_attach,
  cmd = require'lspcontainers'.command('jsonls'),
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}

-- TODO have to confirm this is working
require'lspconfig'.rust_analyzer.setup{
    on_attach=require'completion'.on_attach,
    -- settings = {
        -- ["rust-analyzer"] = {
          -- updates = {
            -- channel = "nightly"
          -- }
        -- }
    -- },
}

local saga = require 'lspsaga'
saga.init_lsp_saga()

require'lspkind'.init()

-- TODO add lua lsp
