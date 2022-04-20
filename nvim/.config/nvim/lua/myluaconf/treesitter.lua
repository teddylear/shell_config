vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = {"*.cue"},
        command = "set filetype=cue",
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cue = {
    install_info = {
        url = "https://github.com/eonpatapon/tree-sitter-cue",
        files = {"src/parser.c", "src/scanner.c"},
        branch = "main",
    },
    filetype = "cue",
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "python",
        "go",
        "lua",
        "yaml",
        "json",
        "bash",
        "rust",
        "dockerfile",
        "typescript",
        "ruby",
        "javascript",
        "query",
        "cpp",
        "markdown",
        "hcl",
        "cue"
    },
    highlight = {
        enable = true,
    },
})
