require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		-- "lua_ls",
	},
})

require("lspconfig").pyright.setup({})
require("lspconfig").lua_ls.setup({})
require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black, -- python formatter
		null_ls.builtins.formatting.isort, -- python import sort
		null_ls.builtins.diagnostics.flake8, -- python linter
		-- null_ls.builtins.formatting.stylua, -- lua formatter
		-- null_ls.builtins.diagnostics.luacheck, -- lua linter
        null_ls.builtins.formatting.rustfmt, -- Rust formatter
	},
})
