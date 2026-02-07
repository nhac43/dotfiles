-- init.lua
local is_vscode = vim.g.vscode ~= nil

-- =========================
-- Core: VSCodeでも安全なもの
-- =========================

-- Basic Settings（ここは共通でOK）
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.cmd("syntax on")
vim.g.mapleader = " "

-- Keymaps（編集系だけに寄せる：VSCodeでもOKなもの）
vim.keymap.set("n", "<Esc><Esc>", ":nohl<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<C-l>", "<Cmd>tabnext<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", "<Cmd>tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>quit<CR>", { silent = true })

-- Memo function（VSCodeでも動くはず）
vim.keymap.set("n", "<Leader>m", function()
  local title = vim.fn.input("Title (default: memo): ")
  local ext = vim.fn.input("File extension (default: md): ")
  title = (title == "") and "memo" or title
  ext = (ext == "") and "md" or ext
  local filename = os.date("%Y%m%d_%H%M%S") .. "_" .. title .. "." .. ext
  vim.cmd("tabnew " .. filename)
end)

-- Paste mode toggle（VSCodeでもOK）
local paste_mode = false
vim.keymap.set("n", "<Leader>l", function()
  paste_mode = not paste_mode
  vim.opt.paste = paste_mode
  print(paste_mode and ":set paste" or ":set nopaste")
end)

-- indentLine は VSCodeでは基本いらないので、設定もVSCodeではしない
if not is_vscode then
  vim.g.indentLine_concealcursor = "nc"
end

if is_vscode then
  -- find_files 相当
  vim.keymap.set("n", "<Leader>ff",
    "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")

  -- live_grep 相当
  vim.keymap.set("n", "<Leader>fg",
    "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>")

  -- buffers 相当
  vim.keymap.set("n", "<Leader>fb",
    "<Cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>")

  -- help_tags 相当（コマンドパレット）
  vim.keymap.set("n", "<Leader>fh",
    "<Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>")
  
  -- ===== Fold (z系) =====

  -- toggle fold
  vim.keymap.set("n", "za",
    "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")

  -- close fold
  vim.keymap.set("n", "zc",
    "<Cmd>call VSCodeNotify('editor.fold')<CR>")

  -- open fold
  vim.keymap.set("n", "zo",
    "<Cmd>call VSCodeNotify('editor.unfold')<CR>")

  -- fold all
  vim.keymap.set("n", "zM",
    "<Cmd>call VSCodeNotify('editor.foldAll')<CR>")

  -- unfold all
  vim.keymap.set("n", "zR",
    "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>")
    
end

-- =========================
-- VSCode / Standalone 分岐
-- =========================
if is_vscode then
  -- VSCodeではここで止める：重い plugin/config を読み込まない
  return
end

-- =========================
-- Standalone only: フルNeovim
-- =========================

-- Python host（VSCodeでも害は少ないが、不要ならvscode側で外してもOK）
vim.g.python3_host_prog = os.getenv("HOME") .. "/nvims/python/venv/bin/python"
vim.g.python_host_prog  = os.getenv("HOME") .. "/nvims/python/venv/bin/python"

-- nvim-tree のため（VSCodeでは不要なのでフル側だけ）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugin Manager
require("config.lazy")

-- Telescope
require("telescope_custom_function")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Plugin configs
require("lsp_config")
require("nvim_cmp_config")
require("keymaps")
require("treesitter")
require("mydap")
require("nvim_tree_config")
require("clipboard_function")
require("codecompanion_config")

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
vim.g.UltiSnipsEditSplit = "vertical"
vim.g.ultisnips_python_style = "google"

-- Colorscheme（VSCodeでは意味薄いのでフル側だけ）
local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not ok then
  vim.cmd("colorscheme industry")
end
vim.opt.background = "dark"

