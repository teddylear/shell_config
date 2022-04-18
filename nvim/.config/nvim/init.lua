require("myluaconf.packer").init()
require("myluaconf.todo_comments")
require("myluaconf.telescope")
require("myluaconf.lualine")
require("myluaconf.luasnip")
require("myluaconf.cmp")
require("myluaconf.treesitter")
require("myluaconf.lspconfig")
require("myluaconf.sets")
require("myluaconf.functions")
require("myluaconf.keymaps").init()

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
