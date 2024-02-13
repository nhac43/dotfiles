require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		-- "lua_ls",
	},
})

require("lspconfig").pyright.setup({})
require("lspconfig").lua_ls.setup({})
