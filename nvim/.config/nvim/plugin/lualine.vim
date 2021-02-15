" lualine configuration
lua << EOF
local lualine = require('lualine')
    lualine.options.theme = 'onedark'
    lualine.options.separator = '|'
    lualine.options.extensions = { 'fzf' }
    lualine.status()
EOF
