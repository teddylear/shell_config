require("myluaconf.packer_setup").init()
require("myluaconf.todo_comments")
require("myluaconf.telescope")
require("myluaconf.lualine")
require("myluaconf.luasnip")
require("myluaconf.sets")
require("myluaconf.functions").init()
require("myluaconf.keymaps").init()

-- TODO: eventually move back to files
require("colorizer").setup()
require("treesitter-context").setup()

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
