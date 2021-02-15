" lualine configuration
lua << EOF
local lualine = require('lualine')
    lualine.options.theme = 'onedark'
    lualine.options.separator = '|'
    lualine.options.extensions = { 'fzf' }
    lualine.options.icons_enabled = true
    lualine.sections.lualine_c = {
        {
          'filename',
          shorten = false,
          full_path = true,
        }
    }
    lualine.status()
EOF
