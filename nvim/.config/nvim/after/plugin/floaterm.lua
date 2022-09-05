local map = vim.api.nvim_set_keymap

map(
    "n",
    "<leader>bt",
    "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 btm<CR>",
    {
        noremap = true,
        desc = "Open btm in floating window for system stats",
    }
)

map(
    "n",
    "<leader>ld",
    "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 lazydocker<CR>",
    {
        noremap = true,
        desc = "Open lazy docker in floating window for docker info",
    }
)

map(
    "n",
    "<leader>tt",
    "<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9<CR>",
    {
        noremap = true,
        desc = "Open new floating terminal window",
    }
)
