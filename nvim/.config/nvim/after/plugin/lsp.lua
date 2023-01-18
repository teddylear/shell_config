require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
        "pyright",
        "gopls",
        "tsserver",
        "terraformls",
        "bashls",
        "puppet",
        "ansiblels",
        "dockerls",
    },
})

local util = require("lspconfig/util")

-- Lua lsp settings form Blackglasses
--local runtime_path = vim.split(package.path, ';')
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "lua/myluaconf/*.lua")

-- From Alt F4 dotfiles
local lua_settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = vim.split(package.path, ";"),
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- From below thread on this issue
-- https://github.com/neovim/nvim-lspconfig/issues/500
local path = util.path
local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if match ~= "" then
        local venv = vim.fn.trim(
            vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv")
        )
        return path.join(venv, "bin", "python")
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

require("lspconfig").pyright.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(
            client.config.root_dir
        )
    end,
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
    capabilities = capabilities,
})

-- TODO: Update to work locally
require("lspconfig").gopls.setup({
    capabilities = capabilities,
})

require("lspconfig").ansiblels.setup({
    capabilities = capabilities,
})

require("lspconfig").dockerls.setup({
    capabilities = capabilities,
})

require("lspconfig").terraformls.setup({
    capabilities = capabilities,
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
})

require("lspconfig").bashls.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
    capabilities = capabilities,
})

-- See installation instructions on github for vimls
-- require("lspconfig").vimls.setup({
-- capabilities = capabilities,
-- })

-- require("lspconfig").jsonls.setup({
-- before_init = function(params)
-- params.processId = vim.NIL
-- end,
-- capabilities = capabilities,
-- cmd = require("lspcontainers").command("jsonls"),
-- root_dir = util.root_pattern(".git", vim.fn.getcwd()),
-- })

require("lspconfig").sumneko_lua.setup({
    capabilities = capabilities,
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
    -- cmd = require("lspcontainers").command("tsserver"),
    root_dir = util.root_pattern(".git", vim.fn.getcwd()),
})

-- TODO: have to confirm this is working
require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
})

require("lspconfig").puppet.setup({
    capabilities = capabilities,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = false,
    }
)

require("fidget").setup({})
local map = vim.api.nvim_set_keymap

map("n", "<leader>gd", "", {
    noremap = true,
    callback = vim.lsp.buf.definition,
    desc = "vim lsp get definition under cursor",
})

map("n", "<leader>re", "", {
    noremap = true,
    callback = vim.lsp.buf.rename,
    desc = "vim lsp rename under cursor",
})

map("n", "<leader>gr", "", {
    noremap = true,
    callback = vim.lsp.buf.references,
    desc = "vim lsp get references",
})

-- TODO: have to find out how this works, don"t have an example of this
-- map(
-- "n",
-- "<leader>gi",
-- "<CMD>lua vim.lsp.buf.implementation()<CR>",
-- options
-- )
-- TODO: when would I use this?
-- map(
-- "n",
-- "<leader>gfh",
-- "",
-- { noremap = true, callback = vim.lsp.buf.signature_help }
-- )
