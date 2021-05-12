" lualine configuration
lua << EOF
require('lualine').setup {
    options = {
        theme = 'dracula',
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
EOF
