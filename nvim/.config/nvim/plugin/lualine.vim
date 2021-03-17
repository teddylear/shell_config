" lualine configuration
lua << EOF
require('lualine').setup {
    options = {
        theme = 'onedark',
        separator = '|',
        icons_enabled = true,
        extensions = { 'fzf' }
    },
    lualine_c = {
        {'filename', full_path = true}
    },
}
EOF
