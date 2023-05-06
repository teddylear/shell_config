local map = vim.api.nvim_set_keymap

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

-- TODO: Make mini function for this? Like a for loop

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

local function open_terminal_first_tab()
    vim.cmd("tabnew")
    require("harpoon.term").gotoTerminal(1)
    vim.cmd("tabmove 0")
end

map("n", "<leader>hp", "", {
    noremap = true,
    callback = open_terminal_first_tab,
    desc = "Open new harpoon terminal in new tab and move to first tab position",
})
