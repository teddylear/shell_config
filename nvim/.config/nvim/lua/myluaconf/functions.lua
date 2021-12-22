local M = {}

M.trimWhiteSpace = function()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.cmd("call winrestview(winsaveview())")
end

M.setup = function()
  -- Remove whitespace
  vim.cmd("augroup THE_KENSTER")
  vim.cmd("autocmd!")
  vim.cmd("autocmd BufWritePre * :lua require('myluaconf.functions').trimWhiteSpace()")
  vim.cmd("augroup END")
end

M.NewNote = function()
  vim.cmd("read ~/.config/nvim/templateFiles/new_note.md")
  vim.cmd("call cursor( line('.')-1, 1)")
  vim.cmd("delete")
end

M.GitCommit = function()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local input = Input({
    position = "50%",
    size = {
        width = 70,
        height = 10,
    },
    relative = "win",
    border = {
      highlight = "GitCommit",
      style = "rounded",
      text = {
          top = "Enter commit message",
          top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function()
      print("Commit cancelled!")
    end,
    on_submit = function(commit_message)
      if commit_message == "" then
        print("You have to enter a commit message silly")
      else
        vim.cmd("Git commit -m \"" .. commit_message .. "\"")
      end

    end,
  })
  input:mount()
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.setup()

return M
