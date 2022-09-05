require("lualine").setup({
    options = {
        theme = "nord",
        icons_enabled = true,
        -- This sets relative path
        globalstatus = true,
    },
    extensions = { "fzf", "fugitive" },
})

require("colorizer").setup()
