local function init()
    local map = vim.api.nvim_set_keymap

    local options = { noremap = true }

    -- TODO: Move all refactoring setup to centralized place
    require("refactoring").setup({
        prompt_func_return_type = {
            go = true,
        },
        prompt_func_param_type = {
            go = true,
        },
    })

    -- vim-fugitive commands
    map(
        "n",
        "<leader>gi",
        "<CMD>Git<CR>",
        { noremap = true, desc = "Open vim-fugitive git status window" }
   )
    map(
        "n",
        "<leader>df",
        "<CMD>Gdiff<CR>",
        {
            noremap = true,
            desc = "Open vim-fugitive git diff for current file"
        }
    )

    map("n", "<leader>co", "<CMD>copen<CR>", options)

    -- lsp configuration configuration
    map(
        "n",
        "<leader>gd",
        "",
        { noremap = true, callback = vim.lsp.buf.definition }
    )

    map(
        "n",
        "<leader>re",
        "",
        { noremap = true, callback = vim.lsp.buf.rename }
    )

    -- TODO: have to find out how this works, don"t have an example of this
    -- map(
    -- "n",
    -- "<leader>gi",
    -- "<CMD>lua vim.lsp.buf.implementation()<CR>",
    -- options
    -- )
    map(
        "n",
        "<leader>gfh",
        "",
        { noremap = true, callback = vim.lsp.buf.signature_help }
    )
    map(
        "n",
        "<leader>gr",
        "",
        { noremap = true, callback = vim.lsp.buf.references }
    )
    map(
        "n",
        "<leader>gs",
        "<CMD>Git push origin --force-with-lease<CR>",
        options
    )
    map("n", "<leader>gp", "<CMD>Git pull origin<CR>", options)
    map("n", "<leader>gc", "", {
        noremap = true,
        callback = require("myluaconf.functions").GitCommit,
    })

    -- Telescope keymaps
    map(
        "n",
        "<leader>lg",
        "",
        { noremap = true, callback = require("telescope.builtin").live_grep }
    )

    map("n", "<leader>cw", "", {
        noremap = true,
        callback = function()
            return require("telescope.builtin").grep_string({
                search = vim.fn.expand("<cword>"),
            })
        end,
    })

    map(
        "n",
        "<leader>pb",
        "",
        { noremap = true, callback = require("telescope.builtin").buffers }
    )

    map(
        "n",
        "<leader>vh",
        "",
        { noremap = true, callback = require("telescope.builtin").help_tags }
    )

    map(
        "n",
        "<C-p>",
        "",
        { noremap = true, callback = require("telescope.builtin").git_files }
    )

    map(
        "n",
        "<leader>pf",
        "",
        { noremap = true, callback = require("telescope.builtin").find_files }
    )

    map("n", "<leader>pg", "", {
        noremap = true,
        callback = require("telescope.builtin").git_branches,
    })

    -- refactoring
    map("n", "<leader>rr", "", {
        noremap = true,
        callback = require("myluaconf.telescope").refactors,
    })
    map("v", "<leader>rr", "", {
        noremap = true,
        callback = require("myluaconf.telescope").refactors,
    })

    map("n", "<leader>pc", "", {
        noremap = true,
        callback = require("myluaconf.telescope").colorscheme,
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
            desc = "Refactoring Extract function"
        }
    )

    map(
        "v",
        "<Leader>ev",
        [[<Esc><Cmd>lua require("refactoring").refactor("Extract Variable")<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    -- TODO: Inline variable remap
    map("n", "<Leader>db", "", {
        noremap = true,
        silent = true,
        callback = function()
            return require("refactoring").debug.printf({ below = true })
        end,
    })

    map("n", "<Leader>dc", "", {
        noremap = true,
        silent = true,
        callback = require("refactoring").debug.cleanup,
    })

    map(
        "n",
        "<Leader>dv",
        [[<Esc><Cmd>lua require("refactoring").debug.print_var({})<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    map(
        "v",
        "<Leader>dv",
        [[<Esc><Cmd>lua require("refactoring").debug.print_var({})<CR>]],
        { noremap = true, silent = true, expr = false }
    )

    -- Floaterm commands
    map(
        "n",
        "<leader>bt",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 btm<CR>",
        options
    )
    map(
        "n",
        "<leader>ld",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 lazydocker<CR>",
        options
    )
    map(
        "n",
        "<leader>tt",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9<CR>",
        options
    )

    map(
        "n",
        "<leader>nn",
        "",
        { noremap = true, callback = require("myluaconf.functions").NewNote }
    )

    -- TODO: add these commands to cheatsheet
    map("t", "jk", "<C-\\><C-n>",
        {
            noremap = true,
            desc = "Terminal mode back to normal mode"
        }
    )

    -- harpoon commands
    map(
        "n",
        "<leader>a",
        "",
        { noremap = true, callback = require("harpoon.mark").add_file }
    )
    map(
        "n",
        "<C-e>",
        "",
        { noremap = true, callback = require("harpoon.ui").toggle_quick_menu }
    )
    -- TODO: Make mini function for this?
    map("n", "<C-i>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(1)
        end,
    })
    map("n", "<C-t>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(2)
        end,
    })
    map("n", "<C-n>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(3)
        end,
    })
    map("n", "<C-s>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(4)
        end,
    })

    map("n", "<leader>gb", "<CMD>GBrowse<CR>", options)

    -- center When going next or previous in search, or when merging with
    -- previous line
    map("n", "n", "nzzzv", options)
    map("n", "N", "Nzzzv", options)
    map("n", "J", "mzJ`z", options)

    -- Setting undo breakpoints
    map("i", ",", ",<c-g>u", { noremap = true, desc = "Set undo breakpoint" })
    map("i", ".", ".<c-g>u", options)
    map("i", "!", "!<c-g>u", options)
    map("i", "?", "?<c-g>u", options)

    map("n", "<leader>hp", "", {
        noremap = true,
        callback = function()
            return require("harpoon.term").gotoTerminal(1)
        end,
    })

    map("n", "<leader>to", "", {
        noremap = true,
        callback = require("myluaconf.functions").OpenTermSplit,
    })

    map(
        "n",
        "<leader>tf",
        "<Plug>PlenaryTestFile",
        { noremap = false, silent = false }
    )

    map("n", "<leader>sc", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").ScreenShare,
    })

    map("n", "<leader>mt", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").RunMakeCmd,
    })

    map("n", "<leader>ms", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").SetMakeCmd,
    })

    map("n", "<leader>ch", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.telescope").keymaps,
    })
end

return {
    init = init,
}
