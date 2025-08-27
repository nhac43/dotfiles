return {
  -- UI
  { "vim-airline/vim-airline" },
  { "Yggdroot/indentLine" },
  { "airblade/vim-gitgutter" },
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
    -- tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" }
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

  -- CodeCompanion
  { "olimorris/codecompanion.nvim" },

  -- Colorschemes
  { "tomasr/molokai" },
  { "w0ng/vim-hybrid" },
  { "cocopon/iceberg.vim" },
  { "morhetz/gruvbox" },

  -- Copilot
  { "github/copilot.vim" },
  { "nvim-lua/plenary.nvim" },
  { "CopilotC-Nvim/CopilotChat.nvim" },

  -- Optional / コメントアウト中のプラグイン
  -- { "tpope/vim-fugitive" },
  -- { "neoclide/coc.nvim", branch = "release" },
  -- { "heavenshell/vim-pydocstring", build = "make install", ft = "python" },
  -- { "puremourning/vimspector" },
  -- { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  -- { "junegunn/fzf.vim" },
}

