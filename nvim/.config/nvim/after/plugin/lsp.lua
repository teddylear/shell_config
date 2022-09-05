local map = vim.api.nvim_set_keymap

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


map("n", "<leader>gr", "", {
    noremap = true,
    callback = vim.lsp.buf.references,
    desc = "vim lsp get references",
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
