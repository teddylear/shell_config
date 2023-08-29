local neotest = require("neotest")

-- From below thread on this issue
-- https://github.com/neovim/nvim-lspconfig/issues/500
local util = require("lspconfig/util")
local path = util.path
local function get_python_path(workspace)
    local python_path
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        python_path = path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        return python_path
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if match ~= "" then
        local venv = vim.fn.trim(
            vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv")
        )
        python_path = path.join(venv, "bin", "python")
        return python_path
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

require("neotest").setup({
    adapters = {
        require("neotest-rust"),
        require("neotest-go"),
        require("neotest-python")({
            python = function()
                local root_dir = util.root_pattern(".git", "Pipfile")
                return get_python_path(root_dir)
            end,
        }),
    },
    icons = {
        failed = "",
        passed = "",
        running = "R",
        unknown = "U",
        skipped = "S",
    },
})

local map = vim.api.nvim_set_keymap

-- TODO: Only load these for files we have neotests things for?
map("n", "<leader>rt", "", {
    noremap = true,
    callback = function()
        return neotest.run.run()
    end,
    desc = "Run test closest to cursor via neotest",
})

map("n", "<leader>ta", "", {
    noremap = true,
    callback = function()
        return neotest.run.run({ suite = true })
    end,
    desc = "Run all tests in project via neotest",
})

map("n", "<leader>tf", "", {
    noremap = true,
    callback = function()
        return neotest.run.run(vim.fn.expand("%"))
    end,
    desc = "Run all tests current file via neotest",
})

map("n", "<leader>tp", "", {
    noremap = true,
    callback = neotest.output_panel.toggle,
    desc = "Toggle for showing neotest panel",
})

-- TODO: See if there's anything else I want to play with binding wise
