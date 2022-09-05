local map = vim.api.nvim_set_keymap

map("n", "<leader>gc", "", {
    noremap = true,
    callback = require("myluaconf.functions").GitCommit,
    desc = "Git commit custom function",
})

map("n", "<leader>nn", "", {
    noremap = true,
    callback = require("myluaconf.functions").NewNote,
    desc = "Set new note/ticket format into current file",
})

map("n", "<leader>to", "", {
    noremap = true,
    callback = require("myluaconf.functions").OpenTermSplit,
    desc = "Open harpoon terminal in split buffer below",
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
