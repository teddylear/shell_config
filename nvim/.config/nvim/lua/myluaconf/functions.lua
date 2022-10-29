local function newNote()
    vim.cmd("read ~/.config/nvim/templateFiles/new_note.md")
    vim.cmd("call cursor( line('.')-1, 1)")
    vim.cmd("delete")
end

local function init()
    local map = vim.api.nvim_set_keymap

    map("n", "<leader>nn", "", {
        noremap = true,
        callback = newNote,
        desc = "Set new note/ticket format into current file",
    })
end

return {
    init = init,
}
