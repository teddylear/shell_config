local util = require("lspconfig/util")

-- Lua lsp settings form Blackglasses
--local runtime_path = vim.split(package.path, ';')
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "lua/myluaconf/*.lua")

local lua_settings = {
    runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
    },
    diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
    },
    workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
        enable = false,
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("lspconfig").pylsp.setup({
    capabilities = capabilities,
    cmd = require("lspcontainers").command("pylsp"),
})

-- TODO: Update to work locally
require("lspconfig").gopls.setup({
    capabilities = capabilities,
    -- cmd=require'lspcontainers'.command('gopls'),
})

require("lspconfig").terraformls.setup({
    capabilities = capabilities,
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
    cmd = require("lspcontainers").command("terraformls"),
})

require("lspconfig").bashls.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    cmd = require("lspcontainers").command("bashls"),
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
    capabilities = capabilities,
})

-- See installation instructions on github for vimls
require("lspconfig").vimls.setup({
    capabilities = capabilities,
})

require("lspconfig").jsonls.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    capabilities = capabilities,
    cmd = require("lspcontainers").command("jsonls"),
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
})

require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
    cmd = require("lspcontainers").command("sumneko_lua"),
    settings = lua_settings,
    -- on_new_config = function(new_config, new_root_dir)
    -- new_config.cmd = require("lspcontainers").command(
    -- "sumneko_lua",
    -- { root_dir = new_root_dir }
    -- )
    -- end,
})

-- Required for refactoring plugin dev
require("lspconfig").tsserver.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    cmd = require("lspcontainers").command("tsserver"),
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
})

-- TODO: have to confirm this is working
require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    -- settings = {
    -- ["rust-analyzer"] = {
    -- updates = {
    -- channel = "nightly"
    -- }
    -- }
    -- },
})

require("fidget").setup({})
