local function init()
    local map = vim.api.nvim_set_keymap

    local options = { noremap = true }

    -- TODO: automate how these are loaded to cheatsheet
    map('i', 'jk', '<ESC>', options)
    map('i', 'JK', '<ESC>', options)

    -- vim-fugitive commands
    map('n', '<leader>gi', '<CMD>Git<CR>', options)
    map('n', '<leader>df', '<CMD>Gdiff<CR>', options)

    map('n', '<leader>co', '<CMD>Copen<CR>', options)


    -- lsp configuration configuration
    map(
        "n",
        "<leader>gd",
        "<CMD>lua vim.lsp.buf.definition()<CR>",
        options
    )
    -- TODO: have to find out how this works, don't have an example of this
    -- map(
        -- 'n',
        -- '<leader>gi',
        -- '<CMD>lua vim.lsp.buf.implementation()<CR>',
        -- options
    -- )
    map(
        'n',
        '<leader>gfh',
       '<CMD>lua vim.lsp.buf.signature_help()<CR>',
        options
    )
    map(
        'n',
        '<leader>gr',
        '<CMD>lua vim.lsp.buf.references()<CR>',
        options
    )
    map(
        'n',
        '<leader>gs',
        '<CMD>Git push origin<CR>',
        options
    )

    -- Telescope keymaps
    map(
        'n',
        '<leader>lg',
        '<CMD>lua require("telescope.builtin").live_grep()<CR>',
        options
    )

    map(
        'n',
        '<leader>cw',
        ':lua require("telescope.builtin").grep_string { search = vim.fn.expand("<cword>") }<CR>',
        options
    )

    map(
        'n',
        '<leader>pb',
        '<CMD>lua require("telescope.builtin").buffers()<CR>',
        options
    )

    map(
        'n',
        '<leader>vh',
        '<CMD>lua require("telescope.builtin").help_tags()<CR>',
        options
    )

    map(
        'n',
        '<C-p>',
        '<CMD>lua require("telescope.builtin").git_files()<CR>',
        options
    )

    map(
        'n',
        '<leader>pf',
        '<CMD>lua require("telescope.builtin").find_files({ find_command = {"rg", "--files", "--hidden", "-g", "!.git" }})<CR>',
        options
    )

    map(
        'n',
        '<leader>pg',
        '<CMD>lua require("telescope.builtin").git_branches()<CR>',
        options
    )

    -- refactoring
    map(
        'n',
        '<leader>rr',
        ':lua require("myluaconf.telescope").refactors()<CR>',
        options
    )
    map(
        'v',
        '<leader>rr',
        ':lua require("myluaconf.telescope").refactors()<CR>',
        options
    )

    map(
        "v",
        "<Leader>ef",
        [[<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        {noremap = true, silent = true, expr = false}
    )

    map(
        "v",
        "<Leader>ev",
        [[<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        {noremap = true, silent = true, expr = false}
    )

    -- TODO: Inline variable remap
    map(
        "n",
        "<Leader>db",
        [[<Cmd>lua require("refactoring").debug.printf({below = true})<CR>]],
        {noremap = true, silent = true, expr = false}
    )

    map(
        "n",
        "<Leader>dv",
        [[<Cmd>lua require("refactoring").debug.print_var({})<CR>]],
        {noremap = true, silent = true, expr = false}
    )

    -- Floaterm commands
    map(
        'n',
        '<leader>bt',
        '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 btm<CR>',
        options
    )
    map(
        'n',
        '<leader>ld',
        '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9 lazydocker<CR>',
        options
    )
    map(
        'n',
        '<leader>tt',
        '<CMD>FloatermNew --autoclose=1 --height=0.9 --width=0.9<CR>',
        options
    )

    map(
        'n',
        '<leader>nn',
        '<CMD>lua require("myluaconf.functions").NewNote()<CR>',
        options
    )

    -- TODO: add these commands to cheatsheet
    map('t', 'jk', '<C-\\><C-n>', options)

    -- harpoon commands
    map(
        'n',
        '<leader>a',
        '<CMD>lua require("harpoon.mark").add_file()<CR>',
        options
    )
    map(
        'n',
        '<C-e>',
        '<CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>',
        options
    )
    map('n','<C-i>', '<CMD>lua require("harpoon.ui").nav_file(1)<CR>', options)
    map('n','<C-t>', '<CMD>lua require("harpoon.ui").nav_file(2)<CR>', options)
    map('n','<C-n>', '<CMD>lua require("harpoon.ui").nav_file(3)<CR>', options)
    map('n','<C-s>', '<CMD>lua require("harpoon.ui").nav_file(4)<CR>', options)
    map('n','<leader>gb', '<CMD>GBrowse<CR>', options)


    -- Adding remaps for ThePrimeagen's latest video
    -- Y goes to end of line
    map('n','Y', 'y$', options)

    -- center When going next or previous in search, or when merging with
    -- previous line
    map('n','n', 'nzzzv', options)
    map('n','N', 'Nzzzv', options)
    map('n','J', 'mzJ`z', options)

    -- Setting undo breakpoints
    map('i',',', ',<c-g>u', options)
    map('i','.', '.<c-g>u', options)
    map('i','!', '!<c-g>u', options)
    map('i','?', '?<c-g>u', options)

    map(
        'n',
        '<leader>hp',
        ':lua require("harpoon.term").gotoTerminal(1)<CR>',
        options)

    map(
        "n",
        "<leader>t",
        "<Plug>PlenaryTestFile",
        { noremap = false, silent = false }
    )

    -- Most projects have make test, if not... they should
    map(
        "n",
        "<leader>mt",
        ":Make! test<CR>",
        { noremap = false, silent = false }
    )
end

return {
  init = init,
}
