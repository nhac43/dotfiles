-- -- Ctrl+Shift+C でヤンク内容をクリップボードに送る例
-- vim.keymap.set('n', '<leader>cl', function()
--   -- デフォルトレジスタから内容を取得
--   local content = vim.fn.getreg('"')
--   -- Windows: clip.exe に渡す
--   if vim.fn.has("win32") == 1 then
--     local f = io.popen("clip", "w")
--     f:write(content)
--     f:close()
--   -- macOS: pbcopy
--   elseif vim.fn.has("mac") == 1 then
--     local f = io.popen("pbcopy", "w")
--     f:write(content)
--     f:close()
--   -- Linux: xclip
--   else
--     local f = io.popen("xclip -selection clipboard", "w")
--     f:write(content)
--     f:close()
--   end
--   vim.notify("Copied to system clipboard")
-- end, { noremap = true, silent = true })

-- OSC52でクリップボードに送る関数
local function copy_to_clipboard()
  -- ヤンクした最新の内容を取得（" と同じレジスタ）
  local content = vim.fn.getreg('"')
  -- OSC52シーケンスで送信
  local osc52 = "\x1b]52;c;" .. vim.fn.system('base64', content) .. "\x07"
  vim.api.nvim_chan_send(vim.v.stderr, osc52)
  print("Copied to clipboard via OSC52!")
end

-- <leader>cl にマッピング
vim.keymap.set("n", "<C-j>", copy_to_clipboard, { noremap = true, silent = true })
