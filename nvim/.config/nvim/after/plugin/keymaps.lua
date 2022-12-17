local map = vim.api.nvim_set_keymap

map("n", "<leader>co", "<CMD>copen<CR>", {
    noremap = true,
    desc = "Open quick fix list",
})

-- Cnext and Cprev shortcuts from prime
map("n", "<leader>j", "<CMD>cnext<CR>zz", {
    noremap = true,
    desc = "Cnext shortcut and center",
})

map("n", "<leader>k", "<CMD>cprev<CR>zz", {
    noremap = true,
    desc = "Cprev shortcut and center",
})

map("t", "jk", "<C-\\><C-n>", {
    noremap = true,
    desc = "Terminal mode back to normal mode",
})

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

-- another keymap from prime, pastes whats in register, but not clearing what's in register
map("x", "<leader>pr", '"_dP', {
    noremap = true,
    silent = true,
    desc = "replace word under cursor with what's in register, but keep what's in register in place",
})

map("n", "<leader>f", "", {
    noremap = true,
    silent = true,
    callback = vim.lsp.buf.format,
    desc = "format from lsp",
})

-- from prime, start find and replace on current word
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
    noremap = true,
    silent = true,
    desc = "start find and replace on current word",
})
