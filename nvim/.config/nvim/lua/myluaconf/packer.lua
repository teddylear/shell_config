local packer = nil

local function packer_verify()
    local install_path = vim.fn.stdpath("data")
        .. "/site/pack/packer/start/packer.nvim"

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({
            "git",
            "clone",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.api.nvim_command("packadd packer.nvim")
    end
end

local function packer_startup()
    if packer == nil then
        packer = require("packer")
        packer.init()
    end

    local use = packer.use
    packer.reset()

    -- TODO: list configuration under each plugin with dependencies
    -- packer
    use("wbthomason/packer.nvim")

    -- colorschemes
    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")
    use("eddyekofo94/gruvbox-flat.nvim")
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            local catppuccin = require("catppuccin")

            -- configure it
            catppuccin.setup()
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            vim.cmd[[colorscheme catppuccin]]
            vim.cmd("hi! Normal ctermbg=NONE guibg=NONE")
        end,
    })

    -- syntax highlighting
    use("sheerun/vim-polyglot")
    use("rodjek/vim-puppet")
    use("chr4/nginx.vim")
    use("hashivim/vim-terraform")

    -- smart comments
    use("preservim/nerdcommenter")

    -- floating menus
    use("voldikss/vim-floaterm")

    -- TODO: have to play with keybindings and get this working
    -- harpoon!
    use("ThePrimeagen/harpoon")

    -- adds glyphcons to various vim plugins
    use("ryanoasis/vim-devicons")

    -- luastatus line
    use("nvim-lualine/lualine.nvim")

    -- git integration for vim
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")

    -- Vim Tmux Integration
    use("christoomey/vim-tmux-navigator")

    -- Telescope stuffs
    use("nvim-telescope/telescope.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- Closing brackets and such
    use("jiangmiao/auto-pairs")

    -- Neovim lsp plugins
    use("neovim/nvim-lspconfig")
    use("lspcontainers/lspcontainers.nvim")
    use("tjdevries/nlua.nvim")
    use("tjdevries/lsp_extensions.nvim")
    use("onsails/lspkind-nvim")
    use("j-hui/fidget.nvim")

    -- Neovim Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/playground")

    -- autocomplete
    use("hrsh7th/nvim-cmp")
    -- Uncomment for tabnine
    -- use({
    -- "tzachar/cmp-tabnine",
    -- run = "./install.sh",
    -- requires = "hrsh7th/nvim-cmp",
    -- })
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("L3MON4D3/LuaSnip")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    -- TODO: Get this working later
    -- use 'andersevenrud/compe-tmux'

    use("folke/todo-comments.nvim")
    use("sudormrfbin/cheatsheet.nvim")
    use("MunifTanjim/nui.nvim")
    use("rcarriga/nvim-notify")

    use("norcalli/nvim-colorizer.lua")

    -- make `jk` mapping work faster
    use({
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    })

    use("tpope/vim-abolish")

    -- checking if refactoring plugin is local, if so use that
    local Path = require("plenary.path")
    if Path:new(os.getenv("HOME"), "code", "refactoring.nvim"):is_dir() then
        use("~/code/refactoring.nvim")
    else
        use("ThePrimeagen/refactoring.nvim")
    end
end

local function init()
    packer_verify()
    packer_startup()
end

return {
    init = init,
}
