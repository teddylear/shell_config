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
                vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
                vim.cmd([[colorscheme catppuccin]])
            end,
        },
        "rodjek/vim-puppet",
        "chr4/nginx.vim",
        "hashivim/vim-terraform",
        "preservim/nerdcommenter",
        -- floating menus
        "voldikss/vim-floaterm",
        "ThePrimeagen/harpoon",
        "nvim-tree/nvim-web-devicons",
        "nvim-lualine/lualine.nvim",
        -- git integration for vim
        "tpope/vim-fugitive",
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
        "tjdevries/nlua.nvim",
        "onsails/lspkind-nvim",
        "j-hui/fidget.nvim",
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
        "nvim-treesitter/playground",
        -- autocomplete
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "folke/todo-comments.nvim",
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "norcalli/nvim-colorizer.lua",
        "mbbill/undotree",
        -- make `jk` mapping work faster
        {
            "max397574/better-escape.nvim",
            config = function()
                require("better_escape").setup()
            end,
        },
        "tpope/vim-abolish",
        "nvim-treesitter/nvim-treesitter-context",
        "dstein64/vim-startuptime",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        refactoring_plug_config,
        "eandrju/cellular-automaton.nvim",
        "folke/trouble.nvim",
        "laytan/cloak.nvim",
        "folke/zen-mode.nvim",
        -- TODO: have to play with this more
        -- "simrat39/rust-tools.nvim",
        "Saecki/crates.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    }

    require("lazy").setup(plugins, lazy_options)
end

local function init()
    lazy()
end

return {
    init = init,
}
