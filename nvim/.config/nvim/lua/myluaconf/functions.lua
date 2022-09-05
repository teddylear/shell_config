-- TODO: Fix how this file is organized
local M = {}

local map = vim.api.nvim_set_keymap

M.NewNote = function()
    vim.cmd("read ~/.config/nvim/templateFiles/new_note.md")
    vim.cmd("call cursor( line('.')-1, 1)")
    vim.cmd("delete")
end

map("n", "<leader>nn", "", {
    noremap = true,
    callback = M.NewNote,
    desc = "Set new note/ticket format into current file",
})

-- TODO: make refresh func that reloads files for after formatting / branch switching
-- ideally put in under <leader>rf or something similar

return M
