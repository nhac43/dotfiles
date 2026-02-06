return {
  -- [UI]

  -- > Design
  { "vim-airline/vim-airline" },
  { "Yggdroot/indentLine" },

  -- > Colorschemes
  { "tomasr/molokai" },
  { "w0ng/vim-hybrid" },
  { "cocopon/iceberg.vim" },
  { "morhetz/gruvbox" },

  -- > File operations
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

  -- > Usability
  {
    "rhysd/accelerated-jk",
    config = function()
      -- デフォルトで j/k を置き換える
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },

  -- [Development]

  -- > Editing UX Enhancements
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "cohama/lexima.vim" },

  -- > Git
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
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
      require("neogit").setup({
        integrations = { diffview = true }, -- diffview連携を有効化
        disable_commit_confirmation = true,
      })
      vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { silent = true })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- 既存
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",  { silent = true })
      vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { silent = true })

      -- 追加：今のファイルだけのdiff/履歴
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { silent = true })
      vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>",   { silent = true })
    end,
  },


  -- > LSP
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "onsails/lspkind.nvim" },
  { "nvimtools/none-ls.nvim" },

  -- > Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "sirver/ultisnips" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },

  -- > Debugging
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },

  -- [AI Coding]

  -- > AI Chat
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
  },
  
  -- > AI Completion
  {
    'ggml-org/llama.vim',
  },

  -- [Dependencies]
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },



  -- Optional / コメントアウト中のプラグイン
  -- { "tpope/vim-fugitive" },
  -- { "neoclide/coc.nvim", branch = "release" },
  -- { "heavenshell/vim-pydocstring", build = "make install", ft = "python" },
  -- { "puremourning/vimspector" },
  -- { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  -- { "junegunn/fzf.vim" },
  -- Copilot
  -- { "github/copilot.vim" },
  -- { "nvim-lua/plenary.nvim" },
  -- { "CopilotC-Nvim/CopilotChat.nvim" },
}

