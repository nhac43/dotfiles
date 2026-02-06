-- ========================================================
-- Nvim tree settings
-- ========================================================
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- ========================================================
-- Python virtualenv path
-- ========================================================
-- Install Python to "/nvims/python/venv/bin/python"
-- And "pip install pynvim"

-- DO NOT MOVE FOLLOWING PYTHON SETTINGS FROM THIS LOCATION
vim.g.python3_host_prog = os.getenv("HOME") .. "/nvims/python/venv/bin/python"
vim.g.python_host_prog = os.getenv("HOME") .. "/nvims/python/venv/bin/python"

-- ========================================================
-- Basic Settings
-- ========================================================
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
vim.opt.termguicolors = true -- set t_Co=256 の代わり

vim.cmd("syntax on")

vim.g.mapleader = " "

-- indentLine
vim.g.indentLine_concealcursor = "nc"

-- ========================================================
-- Keymaps
-- ========================================================
vim.keymap.set("n", "<Esc><Esc>", ":nohl<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<C-l>", "gt")
vim.keymap.set("n", "<C-h>", "gT")
vim.keymap.set("n", "<C-k>", ":q<CR>")

-- Memo function (replaced with Lua version below)
vim.keymap.set("n", "<Leader>m", function()
  local title = vim.fn.input("Title (default: memo): ")
  local ext = vim.fn.input("File extension (default: md): ")
  title = (title == "") and "memo" or title
  ext = (ext == "") and "md" or ext
  local filename = os.date("%Y%m%d_%H%M%S") .. "_" .. title .. "." .. ext
  vim.cmd("tabnew " .. filename)
end)

-- Paste mode toggle
local paste_mode = false
vim.keymap.set("n", "<Leader>l", function()
  paste_mode = not paste_mode
  if paste_mode then
    vim.opt.paste = true
    print(":set paste")
  else
    vim.opt.paste = false
    print(":set nopaste")
  end
end)

-- ========================================================
-- Plugin Manager (vim-plug → lazy.nvimなどに変更推奨)
-- ========================================================
require("config.lazy")

-- ========================================================
-- Telescope
-- ========================================================
require("telescope_custom_function")
-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- ========================================================
-- Plugin configs
-- ========================================================
require("lsp_config")
require("nvim_cmp_config")
require("keymaps")
require("treesitter")
require("mydap")
require("nvim_tree_config")
require("clipboard_function")
require("codecompanion_config")
-- require("copilot_chat_config")

-- ========================================================
-- UltiSnips
-- ========================================================
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-z>"
vim.g.UltiSnipsEditSplit = "vertical"
vim.g.ultisnips_python_style = "google"

-- ========================================================
-- Colorscheme
-- ========================================================
-- Gruvbox が読み込まれていればそれを使い、なければ fallback
local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not ok then
  vim.cmd("colorscheme industry")
end

vim.opt.background = "dark"
