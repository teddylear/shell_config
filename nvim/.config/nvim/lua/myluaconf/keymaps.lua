local function init()
    local map = vim.api.nvim_set_keymap


    map("n", "<leader>co", "<CMD>copen<CR>", {
        noremap = true,
        desc = "Open quick fix list",
    })

    -- lsp configuration configuration
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

    map("n", "<leader>gr", "", {
        noremap = true,
        callback = vim.lsp.buf.references,
        desc = "vim lsp get references",
    })

    map("n", "<leader>gc", "", {
        noremap = true,
        callback = require("myluaconf.functions").GitCommit,
        desc = "Git commit custom function",
    })

    -- Telescope keymaps
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


    -- Floaterm commands
    map(
        "n",
        "<leader>bt",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 btm<CR>",
        {
            noremap = true,
            desc = "Open btm in floating window for system stats",
        }
    )
    map(
        "n",
        "<leader>ld",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 lazydocker<CR>",
        {
            noremap = true,
            desc = "Open lazy docker in floating window for docker info",
        }
    )
    map(
        "n",
        "<leader>tt",
        "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9<CR>",
        {
            noremap = true,
            desc = "Open new floating terminal window",
        }
    )

    map("n", "<leader>nn", "", {
        noremap = true,
        callback = require("myluaconf.functions").NewNote,
        desc = "Set new note/ticket format into current file",
    })

    -- TODO: add these commands to cheatsheet
    map("t", "jk", "<C-\\><C-n>", {
        noremap = true,
        desc = "Terminal mode back to normal mode",
    })

    -- harpoon commands
    map("n", "<leader>a", "", {
        noremap = true,
        callback = require("harpoon.mark").add_file,
        desc = "Add file to harpoon plugin list",
    })

    map("n", "<C-e>", "", {
        noremap = true,
        callback = require("harpoon.ui").toggle_quick_menu,
        desc = "Toggle Harpoon quick menu",
    })

    -- TODO: Make mini function for this?
    map("n", "<C-i>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(1)
        end,
        desc = "Open harpoon file 1",
    })
    map("n", "<C-t>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(2)
        end,
        desc = "Open harpoon file 2",
    })
    map("n", "<C-n>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(3)
        end,
        desc = "Open harpoon file 3",
    })
    map("n", "<C-s>", "", {
        noremap = true,
        callback = function()
            return require("harpoon.ui").nav_file(4)
        end,
        desc = "Open harpoon file 4",
    })

    map(
        "n",
        "<leader>gb",
        "<CMD>GBrowse<CR>",
        { noremap = true, desc = "Open file in github in current browser" }
    )

    -- center When going next or previous in search, or when merging with
    -- previous line
    map(
        "n",
        "n",
        "nzzzv",
        { noremap = true, desc = "Center when going next in search" }
    )
    map(
        "n",
        "N",
        "Nzzzv",
        { noremap = true, desc = "Center when going previous in search" }
    )
    map(
        "n",
        "J",
        "mzJ`z",
        { noremap = true, desc = "Center when merging pervious line" }
    )

    -- Setting undo breakpoints
    map("i", ",", ",<c-g>u", { noremap = true, desc = "Set undo breakpoint" })
    map("i", ".", ".<c-g>u", { noremap = true, desc = "Set undo breakpoint" })
    map("i", "!", "!<c-g>u", { noremap = true, desc = "Set undo breakpoint" })
    map("i", "?", "?<c-g>u", { noremap = true, desc = "Set undo breakpoint" })

    map("n", "<leader>hp", "", {
        noremap = true,
        callback = function()
            return require("harpoon.term").gotoTerminal(1)
        end,
        desc = "Open harpoon terminal in current buffer",
    })

    map("n", "<leader>to", "", {
        noremap = true,
        callback = require("myluaconf.functions").OpenTermSplit,
        desc = "Open harpoon terminal in split buffer below",
    })

    map("n", "<leader>tf", "<Plug>PlenaryTestFile", {
        noremap = false,
        silent = false,
        desc = "Plenary Test current file",
    })

    map("n", "<leader>sc", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").ScreenShare,
        desc = "Enter screen share mode in alacritty",
    })

    map("n", "<leader>mt", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").RunMakeCmd,
        desc = "Run set make command in background",
    })

    map("n", "<leader>ms", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.functions").SetMakeCmd,
        desc = "Set make command that can be run in background",
    })

    map("n", "<leader>ch", "", {
        noremap = true,
        silent = false,
        callback = require("myluaconf.telescope").keymaps,
        desc = "Telescope open custom keymap descriptions",
    })

    -- Setting Prime's keymaps for moving visual block up & down
    map("v", "J", ":m '>+1<CR>gv=gv", {
        noremap = true,
        silent = true,
        desc = "In Visual mode move block down",
    })

    map("v", "K", ":m '<-2<CR>gv=gv", {
        noremap = true,
        silent = true,
        desc = "In Visual mode move block up",
    })

end

return {
    init = init,
}
