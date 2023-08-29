require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "gopls",
        "tsserver",
        "terraformls",
        "bashls",
        "puppet",
        "ansiblels",
        "dockerls",
        -- "ruby_ls",
        "marksman",
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

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = lua_settings,
})

-- From below thread on this issue
-- https://github.com/neovim/nvim-lspconfig/issues/500
local path = util.path
local function get_python_path(workspace)
    local python_path
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        python_path = path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        print(string.format("In a venv! Using that for lsp: %s", python_path))
        return python_path
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if match ~= "" then
        local venv = vim.fn.trim(
            vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv")
        )
        python_path = path.join(venv, "bin", "python")
        print(
            string.format(
                "Found a Pipfile! Using that for lsp: %s",
                python_path
            )
        )
        return python_path
    end

    -- Fallback to system Python.
    print("No venv or Pipfile found, using system python")
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
    root_dir = util.root_pattern(".git", "Pipfile"),
    capabilities = capabilities,
    settings = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
            },
        },
    },
})

require("lspconfig").terraformls.setup({
    capabilities = capabilities,
    filetypes = { "hcl", "tf", "terraform", "tfvars" },
})

require("lspconfig").tsserver.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    -- cmd = require("lspcontainers").command("tsserver"),
    root_dir = util.root_pattern(".git"),
})

require("lspconfig").bashls.setup({
    before_init = function(params)
        params.processId = vim.NIL
    end,
    root_dir = util.root_pattern(".git"),
    capabilities = capabilities,
})

local default_lsp_configs = {
    "ansiblels",
    "gopls",
    "dockerls",
    "rust_analyzer",
    -- Waiting for upstream PR to get fixed
    -- "puppet",
    -- "ruby_ls",
    "marksman",
}

for _, lsp_name in ipairs(default_lsp_configs) do
    require("lspconfig")[lsp_name].setup({
        capabilities = capabilities,
    })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        update_in_insert = false,
    }
)

require("fidget").setup({
    text = {
        spinner = "bouncing_ball", -- animation shown when tasks are ongoing
    },
})

require("nvim-web-devicons").setup({})
require("trouble").setup({})

local map = vim.api.nvim_set_keymap

map("n", "<leader>tr", "<cmd>TroubleToggle<cr>", {
    silent = true,
    noremap = true,
    desc = "Open Trouble menu to show lsp diagnostics",
})

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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.lsp.buf.format({ async = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.cmd("setfiletype terraform")
    end,
})

-- TODO: Set something up with tflint maybe?

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
