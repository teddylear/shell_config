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


-- Telescope keymaps
vim.api.nvim_set_keymap(
    "n",
    "<leader>pw",
    ":lua require('telescope.builtin').grep_string { search = vim.fn.expand(\"<cword>\") }<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>pb",
    ":lua require('telescope.builtin').buffers()<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>vh",
    ":lua require('telescope.builtin').help_tags()<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<C-p>",
    ":lua require('telescope.builtin').git_files()<CR>",
    { noremap = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>pf",
    ":lua require('telescope.builtin').find_files()<CR>",
    { noremap = true })
