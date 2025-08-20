-- Ctrl+Shift+C でヤンク内容をクリップボードに送る例
vim.keymap.set('n', '<leader>cl', function()
  -- デフォルトレジスタから内容を取得
  local content = vim.fn.getreg('"')
  -- Windows: clip.exe に渡す
  if vim.fn.has("win32") == 1 then
    local f = io.popen("clip", "w")
    f:write(content)
    f:close()
  -- macOS: pbcopy
  elseif vim.fn.has("mac") == 1 then
    local f = io.popen("pbcopy", "w")
    f:write(content)
    f:close()
  -- Linux: xclip
  else
    local f = io.popen("xclip -selection clipboard", "w")
    f:write(content)
    f:close()
  end
  vim.notify("Copied to system clipboard")
end, { noremap = true, silent = true })

