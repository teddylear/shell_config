local map = vim.api.nvim_set_keymap

-- TODO: Move all refactoring setup to centralized place
require("refactoring").setup({
    prompt_func_return_type = {
        go = true,
    },
    prompt_func_param_type = {
        go = true,
    },
})

-- TODO: What to do about these that include escapes??
map(
    "v",
    "<Leader>ef",
    [[<Esc><Cmd>lua require("refactoring").refactor("Extract Function")<CR>]],
    {
        noremap = true,
        silent = true,
        expr = false,
        desc = "Refactoring extract function",
    }
)

map(
    "v",
    "<Leader>ev",
    [[<Esc><Cmd>lua require("refactoring").refactor("Extract Variable")<CR>]],
    {
        noremap = true,
        silent = true,
        expr = false,
        desc = "Refactoring extract variable",
    }
)

-- TODO: Inline variable remap
map("n", "<Leader>db", "", {
    noremap = true,
    silent = true,
    callback = function()
        return require("refactoring").debug.printf({ below = true })
    end,
    desc = "Refactoring plugin debug print statement",
})

map("n", "<Leader>dc", "", {
    noremap = true,
    silent = true,
    callback = require("refactoring").debug.cleanup,
    desc = "Refactoring plugin debug cleanup print statements",
})

-- TODO: Can I use callback?
map("v", "<Leader>dv", ":lua require('refactoring').debug.print_var()<CR>", {
    noremap = true,
    silent = true,
    expr = false,
    desc = "Refactoring plugin debug print var",
})

-- TODO: Can I use callback?
-- TODO: Why did I have this?
map(
    "n",
    "<Leader>dn",
    ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
    {
        noremap = true,
        silent = true,
        expr = false,
        desc = "Refactoring plugin debug print var",
    }
)
