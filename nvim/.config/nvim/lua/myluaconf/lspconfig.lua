local util = require 'lspconfig/util'

-- Lua lsp settings form Blackglasses
local lua_settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      globals = { 'vim' },
    },
    workspace = {
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
    telemetry = {
      enable = false,
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'lspconfig'.pylsp.setup{
    capabilities = capabilities,
    cmd=require'lspcontainers'.command('pylsp'),
}

-- TODO: Update to work locally
require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    -- cmd=require'lspcontainers'.command('gopls'),
}

require'lspconfig'.terraformls.setup{
    capabilities = capabilities,
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
    cmd=require'lspcontainers'.command('terraformls'),
}

require'lspconfig'.bashls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = require'lspcontainers'.command('bashls'),
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
  capabilities = capabilities,
}

-- See installation instructions on github for vimls
require'lspconfig'.vimls.setup{
  capabilities = capabilities,
}

require'lspconfig'.jsonls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  capabilities = capabilities,
  cmd = require'lspcontainers'.command('jsonls'),
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}


require'lspconfig'.sumneko_lua.setup{
  capabilities = capabilities,
  cmd = require'lspcontainers'.command('sumneko_lua'),
  settings = lua_settings,
}

-- Required for refactoring plugin dev
require'lspconfig'.tsserver.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = require'lspcontainers'.command('tsserver'),
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
}

-- TODO: have to confirm this is working
require'lspconfig'.rust_analyzer.setup{
  capabilities = capabilities,
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
