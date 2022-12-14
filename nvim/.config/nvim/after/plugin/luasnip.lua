local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local events = require("luasnip.util.events")
local i = ls.insert_node
local s = ls.s
local t = ls.text_node
local rep = require("luasnip.extras").rep
local Region = require("refactoring.region")

local Nodes = require("refactoring.treesitter.nodes")
local InlineNode = Nodes.InlineNode

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

ls.add_snippets("lua", {
    ls.parser.parse_snippet("fn", "local function $1($2)\n    $0\nend"),
    ls.parser.parse_snippet("cfn", "function $1:$2($3)\n    $0\nend"),
    ls.parser.parse_snippet("ifs", "if $1 then\n    $0\nend"),
    ls.parser.parse_snippet("ifel", "if $1 then\n    $2\nelse $3\n    $0\nend"),
    s("prn", fmt('print("{}:", {})', { i(1), rep(1) })),
    s("prni", fmt('print("{}:", vim.inspect({}))', { i(1), rep(1) })),
    s("hh", { t({ 'print("Hitting here!")' }) }),
})

ls.add_snippets("terraform", {
    ls.parser.parse_snippet("vs", 'variable "$0" {\n  type = string\n}'),
    ls.parser.parse_snippet("vn", 'variable "$0" {\n  type = number\n}'),
    ls.parser.parse_snippet("vb", 'variable "$0" {\n  type = bool\n}'),
    ls.parser.parse_snippet("rs", 'resource "$1" "$2" {\n\t$0\n}'),
    ls.parser.parse_snippet("ds", 'data "$1" "$2" {\n\t$0\n}'),
    ls.parser.parse_snippet("md", 'module "$1" {\n\tsource = "$0"\n}'),
})

--- Get whether or not import is present.
---@param bufnr number: flag to require parameter types for codegen
---@param filetype string: the filetype
---@param import_text string: table of InlineNodes to query against
---@param inline_nodes table: table of InlineNodes to query against
---@return boolean, table
local function check_for_import(bufnr, filetype, import_text, inline_nodes)
    local tsparser = vim.treesitter.get_parser(bufnr, filetype)
    local tstree = tsparser:parse()[1]
    local out = {}

    for _, statement in ipairs(inline_nodes) do
        local temp = statement(tstree:root(), bufnr, filetype)
        for _, node in ipairs(temp) do
            table.insert(out, node)
        end
    end

    local node_text
    local found_import = false
    for _, item in ipairs(out) do
        node_text = vim.treesitter.query.get_node_text(item, bufnr)
        if node_text == import_text then
            found_import = true
            break
        end
    end

    return found_import, out
end

local function add_fmt_import_if_not_found_golang()
    local bufnr = vim.api.nvim_get_current_buf()
    local inline_nodes = {
        InlineNode("(import_spec path: (interpreted_string_literal) @capture)"),
    }
    local import_text = '"fmt"'

    local found_import, out = check_for_import(
        bufnr,
        "go",
        import_text,
        inline_nodes
    )

    if not found_import then
        local node = out[1]
        local node_text = vim.treesitter.query.get_node_text(node, bufnr)
        local region = Region:from_node(node, bufnr)
        local lsp_text_edit = region:to_lsp_text_edit(
            import_text .. "\n\t" .. node_text
        )
        vim.lsp.util.apply_text_edits({ lsp_text_edit }, bufnr, "utf-16")
    end
end

ls.add_snippets("go", {
    s("ife", {
        t({ "if err != nil {", "\treturn " }),
        i(0),
        t({ "", "}" }),
    }),
    s("prn", fmt('fmt.Println(fmt.Sprintf("{}: %v", {}))', { i(1), rep(1) }), {
        callbacks = {
            [-1] = {
                -- TODO: Can I make this more direct?
                [events.enter] = function(_)
                    add_fmt_import_if_not_found_golang()
                end,
            },
        },
    }),
    s("hh", {
        t({ 'fmt.Println("Hitting here!")' }),
    }, {
        callbacks = {
            [-1] = {
                -- TODO: Can I make this more direct?
                [events.leave] = function(_)
                    add_fmt_import_if_not_found_golang()
                end,
            },
        },
    }),
})

ls.add_snippets("python", {
    s(
        "prn",
        fmt('print(f"^%: {^%}")', { i(1), rep(1) }, { delimiters = "^%" })
    ),
    s("hh", { t({ 'print("Hitting here!")' }) }),
    s("main", { t({ 'if __name__=="__main__":', '\tprint("Hello World!")' }) }),
    s("class", {
        t({ "class " }),
        i(0),
        t({ ":", "", "\tdef __init__(self):", '\t\tprint("Hello World!")' }),
    }),
})

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
-- vim.keymap.set(
-- "n",
-- "<leader>rls",
-- "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>"
-- )
