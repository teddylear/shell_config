require'nvim-treesitter.configs'.setup {
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
    },
    highlight = {
        enable = true
    },
}
