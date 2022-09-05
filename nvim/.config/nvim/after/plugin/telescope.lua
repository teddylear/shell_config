local map = vim.api.nvim_set_keymap

map("n", "<leader>lg", "", {
    noremap = true,
    callback = require("telescope.builtin").live_grep,
    desc = "Telescope live grep",
})

map("n", "<leader>cw", "", {
    noremap = true,
    callback = function()
        return require("telescope.builtin").grep_string({
            search = vim.fn.expand("<cword>"),
        })
    end,
    desc = "Telescope grep current word under cursor",
})

map("n", "<leader>pf", "", {
    noremap = true,
    callback = require("telescope.builtin").find_files,
    desc = "Telescope find files",
})

map("n", "<leader>pg", "", {
    noremap = true,
    callback = require("telescope.builtin").git_branches,
    desc = "Telescope change git branch",
})

-- TODO: How does this work?
-- map(
-- "n",
-- "<leader>vh",
-- "",
-- { noremap = true, callback = require("telescope.builtin").help_tags }
-- )

-- TODO: When would I use this?
-- map(
-- "n",
-- "<C-p>",
-- "",
-- { noremap = true, callback = require("telescope.builtin").git_files }
-- )
