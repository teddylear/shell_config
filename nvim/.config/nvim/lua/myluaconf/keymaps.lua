local function init()
    local map = vim.api.nvim_set_keymap

    local options = { noremap = true }

    map('i', 'jk', '<ESC>', options)
    map('i', 'JK', '<ESC>', options)

    -- vim-fugitive commands
    map('n', '<space>git', '<CMD>Git<CR>', options)
    map('n', '<space>gid', '<CMD>Gdiff<CR>', options)

    -- lsp configuration configuration
    map("n", "<leader>gd", "<CMD>lua vim.lsp.buf.definition()<CR>", options)
    -- TODO have to find out how this works, don't have an example of this
    map('n', '<leader>gi', '<CMD>lua vim.lsp.buf.implementation()<CR>', options)
    map('n', '<leader>gfh', '<CMD>lua vim.lsp.buf.signature_help()<CR>', options)
    map('n', '<leader>gr', '<CMD>lua vim.lsp.buf.references()<CR>', options)

    -- Telescope keymaps
    map('n', '<leader>pw', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
    map('n', '<leader>pb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
    map('n', '<leader>vh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', options)
    map('n', '<C-p>', '<CMD>lua require("telescope.builtin").git_files()<CR>', options)
    map('n', '<leader>pf', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)

    map('n', '<leader>bt', '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 btm<CR>', options)
    map('n', '<leader>ld', '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 lazydocker<CR>', options)
    map('n', '<leader>tt', '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9<CR>', options)

    -- TODO: Have to experiment more with lspsaga commands and configuration
    map('n', '<leader>re', '<CMD>lua require("lspsaga.rename").rename()<CR>', options)

    map('n', '<leader>nn', '<CMD>lua require("myluaconf.functions").NewNote()<CR>', options)

    vim.cmd([[
      inoremap <silent><expr> <C-Space> compe#complete()
      inoremap <silent><expr> <CR>      compe#confirm('<CR>')
      inoremap <silent><expr> <C-e>     compe#close('<C-e>')
      inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
      inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
    ]])

end

return {
  init = init,
}
