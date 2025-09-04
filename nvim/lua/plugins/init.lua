return {
  -- UI
  { "vim-airline/vim-airline" },
  { "Yggdroot/indentLine" },
  {
    "rhysd/accelerated-jk",
    config = function()
      -- デフォルトで j/k を置き換える
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "cohama/lexima.vim" },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
      vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
    end,
  },

  -- LSP + Mason
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "onsails/lspkind.nvim" },
  { "nvimtools/none-ls.nvim" },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "sirver/ultisnips" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- Colorschemes
  { "tomasr/molokai" },
  { "w0ng/vim-hybrid" },
  { "cocopon/iceberg.vim" },
  { "morhetz/gruvbox" },

  -- GPT5で生成
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Hunk操作
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true })
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
        end
      })
    end,
  },

  -- Neogit
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
      require("neogit").setup({
        integrations = { diffview = true },
        disable_commit_confirmation = true,
      })
      vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { noremap = true, silent = true })
    end,
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { noremap = true, silent = true })
    end,
  },

  -- Optional / コメントアウト中のプラグイン
  -- { "tpope/vim-fugitive" },
  -- { "neoclide/coc.nvim", branch = "release" },
  -- { "heavenshell/vim-pydocstring", build = "make install", ft = "python" },
  -- { "puremourning/vimspector" },
  -- { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  -- { "junegunn/fzf.vim" },
}

