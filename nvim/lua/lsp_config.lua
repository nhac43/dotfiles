require("mason").setup()
-- require("mason-lspconfig").setup({
-- 	ensure_installed = {
-- 		"ruff_lsp",
-- 		"pyright",
-- 		-- "lua_ls",
-- 	},
-- })

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
-- local on_attach = function(client, bufnr)
--   if client.name == 'ruff' then
--     -- Disable hover in favor of Pyright
--     client.server_capabilities.hoverProvider = false
--   end
-- end

require('lspconfig').ruff.setup {
  -- on_attach = on_attach,
}
require('lspconfig').pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
}

-- Not used
-- require("lspconfig").lua_ls.setup({})
-- require("lspconfig").rust_analyzer.setup({
--   settings = {
--     ["rust-analyzer"] = {
--       check = {
--         command = "clippy",
--       },
--     },
--   },
-- })

-- local null_ls = require("null-ls")
-- null_ls.setup({
-- 	sources = {
-- 		-- null_ls.builtins.formatting.ruff, -- python formatter
-- 		-- null_ls.builtins.diagnostics.ruff, -- python linter
-- 		-- null_ls.builtins.formatting.stylua, -- lua formatter
-- 		-- null_ls.builtins.diagnostics.luacheck, -- lua linter
--         -- null_ls.builtins.formatting.rustfmt, -- Rust formatter
-- 	},
-- })
