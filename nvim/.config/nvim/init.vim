call plug#begin("~/.config/nvim/plugged")
" Plugin Section
" color scheme plugin
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" smart comments
Plug 'preservim/nerdcommenter'

" Floating menus
Plug 'voldikss/vim-floaterm'

" teriminal navigator
" TODO have to figure out the best way of doing this
" Still can't get this working in current workflow
Plug 'ThePrimeagen/harpoon'

" adds glyphcons to various vim plugins
Plug 'ryanoasis/vim-devicons'

" luastatus line
Plug 'hoob3rt/lualine.nvim'

" git integration for vim
Plug 'tpope/vim-fugitive'

" Vim Tmux Integration
Plug 'christoomey/vim-tmux-navigator'

" Telescope stuffs
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Closing brackets and such
Plug 'jiangmiao/auto-pairs'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'lspcontainers/lspcontainers.nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/vim-vsnip'

" Neovim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" autocomplete
Plug 'hrsh7th/nvim-compe'
Plug 'andersevenrud/compe-tmux'

" TODO fix annoying issues where comments carry over to next line in init.vim

" Better syntax highlighting for puppet
Plug 'rodjek/vim-puppet'

" Better syntax highlighting for nginx
Plug 'chr4/nginx.vim'

"Better syntax highlighting for terraform
Plug 'hashivim/vim-terraform'

Plug 'tjdevries/cyclist.vim'
Plug 'tpope/vim-dispatch'

Plug 'folke/todo-comments.nvim'

call plug#end()

" Calling my lua config
lua require("myluaconf")

" Python spacing
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4


" Harpoon to open a buffer
" TODO move these two commands to lua
nmap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
tnoremap jk <C-\><C-n>
