-- empty setup using defaults
-- require("nvim-tree").setup()

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  -- view = {
  --   width = 30,
  -- },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },

  hijack_cursor = true,         -- カーソルが自動でツリー内に移動
  update_cwd = true,            -- カレントディレクトリを自動で更新
  -- view = {
  --   width = 35,                 -- 左ペインの幅
  --   side = "left",              -- 左側に固定
  --   preserve_window_proportions = true, -- エディタのウィンドウサイズを保つ
  -- },
  open_on_tab = true,           -- 新しいタブでも自動で開く
  sync_root_with_cwd = true,    -- nvim-tree のルートを cwd に同期
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})

-- vim.cmd [[
--   augroup NvimTreeAutoOpen
--     autocmd!
--     autocmd TabNew * NvimTreeOpen
--   augroup END
-- ]]
vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
