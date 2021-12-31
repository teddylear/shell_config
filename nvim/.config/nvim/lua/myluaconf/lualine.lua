require("lualine").setup({
    options = {
        theme = "nord",
        separator = "|",
        icons_enabled = true,
        extensions = { "fzf", "fugitive" },
        -- This sets relative path
        path = 1,
    },
    lualine_c = {
        { "filename" },
    },
})
