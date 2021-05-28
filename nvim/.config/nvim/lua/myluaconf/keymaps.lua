vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_keymap("i", "JK", "<ESC>", { noremap = true })

vim.api.nvim_set_keymap("n", "<space>git", ":Git<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>gid", ":Gdiff<CR>", { noremap = true })

-- lsp configuration configuration
vim.api.nvim_set_keymap(
    "n",
    "<leader>gd",
    ":lua vim.lsp.buf.definition()<CR>",
    { noremap = true })
-- TODO have to find out how this works, don't have an example of this
vim.api.nvim_set_keymap(
    "n",
    "<leader>gi",
    ":lua vim.lsp.buf.implementation()<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>gfh",
    ":lua vim.lsp.buf.signature_help()<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>gr",
    ":lua vim.lsp.buf.references()<CR>",
    { noremap = true })
