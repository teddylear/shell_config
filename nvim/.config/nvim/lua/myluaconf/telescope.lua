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
                -- TODO: remove git directory
                -- TODO: Remove everything from gitignore?
                return {"--hidden"}
            end
        },
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "-g",
                "!.git",
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")

local M = {}

local function refactor(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

M.refactors = function()
    require("telescope.pickers").new({}, {
        prompt_title = "refactors",
        finder = require("telescope.finders").new_table({
            results = require("refactoring").get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", refactor)
            map("n", "<CR>", refactor)
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
    vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")
end

M.colorscheme = function()
    require("telescope.pickers").new({}, {
        prompt_title = "Colorscheme",
        finder = require("telescope.finders").new_table({
             "kanagawa",
             "tokyonight",
             "gruvbox-flat",
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", set_colorscheme)
            map("n", "<CR>", set_colorscheme)
            return true
        end,
    }):find()
end

local function get_keymaps_with_desc()
    local keymap_with_desc = {}
    local modes = { "n", "v", "i", "t"}
    for _, mode in ipairs(modes) do
        for _, keymap in ipairs(vim.api.nvim_get_keymap(mode)) do
            if keymap.desc ~= nil then
                table.insert(keymap_with_desc, string.format(
                    "mode: '%s' | keymap: '%s' | cmd: '%s' | desc: '%s'",
                    keymap.mode,
                    keymap.lhs,
                    keymap.rhs,
                    keymap.desc)
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

M.keymaps = function()
    require("telescope.pickers").new({}, {
        prompt_title = "Custom Keymaps",
        finder = require("telescope.finders").new_table({
                results = get_keymaps_with_desc()
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(_, map)
            map("i", "<CR>", display_keymap)
            map("n", "<CR>", display_keymap)
            return true
        end,
    }):find()
end

return M
