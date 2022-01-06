local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

luasnip.snippets["lua"] = {
    luasnip.parser.parse_snippet(
        "fn",
        "local function $1($0)\nend"
    ),
    luasnip.parser.parse_snippet(
        "ifs",
        "if $0 then\nend"
    ),
    luasnip.parser.parse_snippet(
        "ifel",
        "if $0 then\nelse\nend"
    ),
    luasnip.parser.parse_snippet(
        "prn",
        "print(\"$0\")"
    ),
    luasnip.parser.parse_snippet(
        "prni",
        "print(vim.inspect(\"$0\"))"
    )
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(
      0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
        end, { "i", "s" }),
   },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "treesitter" },
        { name = "luasnip" }
    },
})

lspkind.init()
