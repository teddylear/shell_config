require('lualine').setup {
    options = {
        theme = 'gruvbox',
        separator = '|',
        icons_enabled = true,
        extensions = { 'fzf' },
        -- This sets relative path
        path = 1
    },
    lualine_c = {
        {'filename'}
    },
}
