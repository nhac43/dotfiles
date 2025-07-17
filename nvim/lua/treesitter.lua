require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "json" }, -- 必要な言語を自動インストール
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

-- Pythonファイルで自動的にfoldを有効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldlevel = 99  -- 開いた状態にする（必要なら 0 に）
    vim.b.disable_autoindent = true
    vim.b.indentexpr = ""
  end,
})

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = { "json" },
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
  end
})

-- -- ファイルを開いたときに折り畳みを閉じる（任意）
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*.py",
--   callback = function()
--     vim.cmd("normal zM")
--   end,
-- })
