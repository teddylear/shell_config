local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    pickers = {
        live_grep = {
            additional_args = function(opts)
                -- TODO: Remove everything from gitignore?
                return { "--hidden", "-g", "!.git" }
            end,
        },
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "-g",
                "!.git",
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")

local function perform_refactor(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

local function refactors()
    require("telescope.pickers").new({}, {
        prompt_title = "refactors",
        finder = require("telescope.finders").new_table({
            results = require("refactoring").get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", perform_refactor)
            map("n", "<CR>", perform_refactor)
            return true
        end,
    }):find()
end

local function set_colorscheme(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    vim.cmd(string.format("colorscheme %s", content.value))
end

local function colorscheme()
    require("telescope.pickers").new({}, {
        prompt_title = "Colorscheme",
        finder = require("telescope.finders").new_table({
            "kanagawa",
            "tokyonight",
            -- "gruvbox-flat",
            "catppuccin",
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", set_colorscheme)
            map("n", "<CR>", set_colorscheme)
            return true
        end,
    }):find()
end

local Path = require("plenary.path")
local homedir = os.getenv("HOME")

local function iam_actions()
    local iam_file_path = Path:new(
        homedir,
        "code",
        "aws-iam-actions-list",
        "all-actions.txt"
    )

    if not iam_file_path:exists() then
        error("No aws-iam-actions-list file found :(")
    end
    local iam_actions_map = iam_file_path:readlines()

    require("telescope.pickers").new({}, {
        prompt_title = "Iam actions",
        finder = require("telescope.finders").new_table(iam_actions_map),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, _)
            return true
        end,
    }):find()
end

local function get_keymaps_with_desc()
    local keymap_with_desc = {}
    local modes = { "n", "v", "i", "t" }
    for _, mode in ipairs(modes) do
        for _, keymap in ipairs(vim.api.nvim_get_keymap(mode)) do
            if keymap.desc ~= nil then
                table.insert(
                    keymap_with_desc,
                    string.format(
                        "mode: '%s' | keymap: '%s' | desc: '%s' | cmd: '%s'",
                        keymap.mode,
                        keymap.lhs,
                        keymap.desc,
                        keymap.rhs
                    )
                )
            end
        end
    end

    return keymap_with_desc
end

local function display_keymap(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    print(content[1])
end

local function keymaps()
    require("telescope.pickers").new({}, {
        prompt_title = "Custom Keymaps",
        finder = require("telescope.finders").new_table({
            results = get_keymaps_with_desc(),
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", display_keymap)
            map("n", "<CR>", display_keymap)
            return true
        end,
    }):find()
end

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

map("n", "<leader>ch", "", {
    noremap = true,
    silent = false,
    callback = keymaps,
    desc = "Telescope open custom keymap descriptions",
})

map("n", "<leader>rr", "", {
    noremap = true,
    callback = refactors,
    desc = "Select Refactoring operation to run",
})

map("n", "<leader>pc", "", {
    noremap = true,
    callback = colorscheme,
    desc = "Telescope pick and set colorscheme",
})

map("n", "<leader>iam", "", {
    noremap = true,
    callback = iam_actions,
    desc = "List iam actions from aws",
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
