require("lualine").setup({
    options = {
        theme = "nord",
        icons_enabled = true,
        -- This sets relative path
        path = 1,
        globalstatus = true,
    },
    extensions = { "fzf", "fugitive" },
})
