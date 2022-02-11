local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.s
local rep = require("luasnip.extras").rep

-- TODO: Move luasnips to it's own file
-- Settings from teej
local types = require("luasnip.util.types")
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
})

ls.snippets["lua"] = {
    ls.parser.parse_snippet("fn", "local function $1($2)\n    $0\nend"),
    ls.parser.parse_snippet("cfn", "function $1:$2($3)\n    $0\nend"),
    ls.parser.parse_snippet("ifs", "if $1 then\n    $0\nend"),
    ls.parser.parse_snippet("ifel", "if $1 then\n    $2\nelse $3\n    $0\nend"),
    s("prn", fmt('print("{}:", {})', { i(1), rep(1) })),
    s("prni", fmt('print("{}:", vim.inspect({}))', { i(1), rep(1) })),
}

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- shorcut to source my lss file again, which will reload my snippets
-- TODO: Have to fix this to do the right thing
vim.keymap.set(
    "n",
    "<leader>r",
    "<cmd>source ~/.config/nvim/lua/myluaconf/cmp.lua<CR>"
)
