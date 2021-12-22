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
    position = "30%",
    size = {
        width = 40,
        height = 2,
    },
    relative = "editor",
    border = {
      highlight = "MyHighlightGroup",
      style = "single",
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
      print("Input closed!")
    end,
    on_submit = function(commit_message)
      vim.cmd("Git commit -m \"" .. commit_message .. "\"")
    end,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

M.setup()

return M
