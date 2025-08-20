local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- find_files をラップして独自マッピングを追加
local function find_files_with_nvim_tree()
  telescope.find_files({
    attach_mappings = function(prompt_bufnr, map)
      local function focus_in_nvim_tree()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.schedule(function()
          local api = require("nvim-tree.api")
          api.tree.open()
          api.tree.find_file(entry.path)
        end)
        return true
      end

      -- 挿入モード
      map('i', '<C-i>', focus_in_nvim_tree)
      -- ノーマルモード
      map('n', '<C-i>', focus_in_nvim_tree)

      return true
    end
  })
end

vim.keymap.set('n', '<leader>ff', find_files_with_nvim_tree, { desc = "Telescope find_files + nvim-tree focus" })
