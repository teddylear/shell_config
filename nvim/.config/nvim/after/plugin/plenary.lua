local map = vim.api.nvim_set_keymap

map("n", "<leader>tf", "<Plug>PlenaryTestFile", {
    noremap = false,
    silent = false,
    desc = "Plenary Test current file",
})
