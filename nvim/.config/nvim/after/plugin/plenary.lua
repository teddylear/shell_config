local map = vim.api.nvim_set_keymap

map("n", "<leader>pt", "<Plug>PlenaryTestFile", {
    noremap = false,
    silent = false,
    desc = "Plenary Test current file",
})

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end

-- TODO: Do something with reload
