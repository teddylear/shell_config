local lspkind = require("lspkind")
lspkind.init()
local cmp = require("cmp")
local ls = require("luasnip")

-- local tabnine = require("cmp_tabnine.config")
-- tabnine:setup({
-- max_lines = 1000,
-- max_num_results = 20,
-- sort = true,
-- run_on_every_keystroke = true,
-- snippet_placeholder = "..",
-- })
--

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<tab>"] = cmp.config.disable,
        ["<C-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
        }),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        {
            name = "buffer",
            -- Wait for 5 words in buffer
            keyword_length = 5,
        },
        { name = "path" },
        { name = "luasnip" },
        { name = "crates" },
        -- { name = 'cmp_tabnine' },
    },
})
