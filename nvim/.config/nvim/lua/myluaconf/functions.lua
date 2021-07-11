local M = {}

M.trimWhiteSpace = function()
  vim.cmd("keeppatterns %s/\\s\\+$//e")
  vim.cmd("call winrestview(winsaveview())")
end

M.setup = function()
  vim.cmd("augroup THE_KENSTER")
  vim.cmd("autocmd!")
  vim.cmd("autocmd BufWritePre * :lua require('myluaconf.functions').trimWhiteSpace()")
  vim.cmd("augroup END")
end

M.setup()

return M
