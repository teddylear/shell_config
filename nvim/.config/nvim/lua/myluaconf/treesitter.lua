require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "python",
        "go",
        "lua",
        "yaml",
        "json",
        "bash",
        "dockerfile",
    },
    highlight = {
        enable = true
    },
}
