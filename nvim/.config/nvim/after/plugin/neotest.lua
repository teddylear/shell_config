local neotest = require("neotest")
require("neotest").setup({
    adapters = {
        require("neotest-rust"),
    },
    icons = {
        failed = "",
        passed = "",
        running = "R",
        unknown = "U",
        skipped = "S",
    }
})

local map = vim.api.nvim_set_keymap

-- TODO: Only load these for files we have neotests things for
map("n", "<leader>rt", "", {
    noremap = true,
    callback = function()
        return neotest.run.run({ suite = true})
    end,
    desc = "Run all tests via neotest",
})

map("n", "<leader>tp", "", {
    noremap = true,
    callback = neotest.output_panel.toggle,
    desc = "Run all tests in current file via neotest",
})
