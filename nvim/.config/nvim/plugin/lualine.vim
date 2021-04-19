" lualine configuration
lua << EOF
require('lualine').setup {
    options = {
        theme = 'tokyonight',
        separator = '|',
        icons_enabled = true,
        extensions = { 'fzf' }
    },
    lualine_c = {
        {'filename', full_path = true}
    },
}
EOF
