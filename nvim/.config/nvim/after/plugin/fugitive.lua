local map = vim.api.nvim_set_keymap

map(
    "n",
    "<leader>gi",
    "<CMD>Git<CR>",
    { noremap = true, desc = "Open vim-fugitive git status window" }
)
map("n", "<leader>df", "<CMD>Gdiff<CR>", {
    noremap = true,
    desc = "Open vim-fugitive git diff for current file",
})

map("n", "<leader>gs", "<CMD>Git push origin --force-with-lease<CR>", {
    noremap = true,
    desc = "vim-fugitive git push --force-with-lease",
})

map("n", "<leader>gp", "<CMD>Git pull origin<CR>", {
    noremap = true,
    desc = "vim-fugitive git pull",
})

map(
    "n",
    "<leader>gh",
    "<CMD>GBrowse<CR>",
    { noremap = true, desc = "Open file in github in current browser" }
)
