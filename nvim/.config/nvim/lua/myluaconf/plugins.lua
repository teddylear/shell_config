local function lazy()
    local PLUGINS_LOCATION = vim.fn.expand("~/shell_config/nvim/plugins/")
    local lazypath = PLUGINS_LOCATION .. "/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)

    -- https://github.com/antonk52/dot-files/blob/master/nvim/init.lua
    local lazy_options = {
        root = PLUGINS_LOCATION,
        lockfile = vim.fn.expand("~/shell_config/nvim/.config/nvim/lua")
            .. "/lazy-lock.json",
        performance = {
            rtp = {
                disabled_plugins = {
                    "2html_plugin",
                    "getscript",
                    "getscriptPlugin",
                    "logipat",
                    "netrwFileHandlers",
                    "netrwSettings",
                    "rrhelper",
                    "tar",
                    "tarPlugin",
                    "tutor",
                    "tutor_mode_plugin",
                    "vimball",
                    "vimballPlugin",
                    "zip",
                    "zipPlugin",
                },
            },
        },
        ui = {
            icons = {
                cmd = "⌘",
                config = "🛠",
                event = "📅",
                ft = "📂",
                init = "⚙",
                keys = "🗝",
                plugin = "🔌",
                runtime = "💻",
                source = "📄",
                start = "🚀",
                task = "📌",
                lazy = "💤 ",
            },
        },
    }

    -- TODO: have to fix this later
    --
    -- local refactoring_plug_path = os.getenv("HOME") .. "/code/refactoring.nvim"
    -- local refactoring_plug_config
    -- if vim.fn.empty(vim.fn.glob(refactoring_plug_path)) > 0 then
    -- refactoring_plug_config = "ThePrimeagen/refactoring.nvim"
    -- else
    -- refactoring_plug_config = {
    -- "refactoring.nvim",
    -- dir = "~/code/refactoring.nvim"
    -- }
    -- end

    local refactoring_plug_config = "ThePrimeagen/refactoring.nvim"

    local plugins = {
        -- color schemes
        "folke/tokyonight.nvim",
        "rebelot/kanagawa.nvim",
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                local catppuccin = require("catppuccin")

                -- configure it
                catppuccin.setup()
                -- latte, frappe, macchiato, mocha
                vim.g.catppuccin_flavour = "mocha"
                vim.cmd([[colorscheme catppuccin]])

                -- disable all lsp highlighting because we want treesitter to
                -- do it. This comes from neovim docs
                for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
                    vim.api.nvim_set_hl(0, group, {})
                end
            end,
        },
        -- syntax highlighting
        "rodjek/vim-puppet",
        "chr4/nginx.vim",
        -- TODO: do I need this?
        -- "hashivim/vim-terraform",
        -- smart comments, so useful
        "preservim/nerdcommenter",
        -- floating menus
        "voldikss/vim-floaterm",
        -- The prime coconut oil experience
        "ThePrimeagen/harpoon",
        -- better icons
        "nvim-tree/nvim-web-devicons",
        -- statusline
        "nvim-lualine/lualine.nvim",
        -- git integration for vim
        "tpope/vim-fugitive",
        -- be able to open current file in github
        "tpope/vim-rhubarb",
        -- Vim Tmux Integration
        "christoomey/vim-tmux-navigator",
        -- Telescope stuffs
        "nvim-telescope/telescope.nvim",
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzy-native.nvim",
        -- Closing brackets and such
        "windwp/nvim-autopairs",
        -- Neovim lsp plugins
        "neovim/nvim-lspconfig",
        -- TODO: Do I need this?
        "tjdevries/nlua.nvim",
        -- TODO: Do I need this?
        "onsails/lspkind-nvim",
        -- shows lsp status in bottom right corner
        -- "j-hui/fidget.nvim",
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
        },
        -- Neovim Treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                local ts_update = require("nvim-treesitter.install").update({
                    with_sync = true,
                })
                ts_update()
            end,
        },
        -- helps with writing treesitter queries for current files
        "nvim-treesitter/playground",
        -- autocomplete
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        -- lua snippers
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        -- better highlighting for TODO, NOTE, etc
        "folke/todo-comments.nvim",
        -- Better floating window management for creating commits, new branches
        "MunifTanjim/nui.nvim",
        -- better notifications
        "rcarriga/nvim-notify",
        -- TODO: Do I need this?
        "norcalli/nvim-colorizer.lua",
        -- TODO: Do I even use this?
        "mbbill/undotree",
        -- make `jk` mapping work faster
        {
            "max397574/better-escape.nvim",
            config = function()
                require("better_escape").setup()
            end,
        },
        -- replace serveral varients of words at once
        "tpope/vim-abolish",
        -- shows context for current code (function name, if statements)
        "nvim-treesitter/nvim-treesitter-context",
        -- measure startup time
        "dstein64/vim-startuptime",
        -- install lsp servers
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        refactoring_plug_config,
        -- completely for fun plugin
        "eandrju/cellular-automaton.nvim",
        -- have output for lsp errors
        "folke/trouble.nvim",
        "laytan/cloak.nvim",
        -- more focused code editing
        "folke/zen-mode.nvim",
        -- TODO: have to play with this more
        -- "simrat39/rust-tools.nvim",
        -- way better way to manage crates
        "Saecki/crates.nvim",
        -- requirement for crates.nvim
        "jose-elias-alvarez/null-ls.nvim",
        -- neotest and it's deps
        "nvim-neotest/neotest",
        "antoinemadec/FixCursorHold.nvim",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
    }

    require("lazy").setup(plugins, lazy_options)
end

local function init()
    lazy()
end

return {
    init = init,
}
