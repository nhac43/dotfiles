require("mason").setup()

-- Ruff LSP
vim.lsp.config("ruff", {
  -- もし hover を Pyright に任せたいなら:
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.hoverProvider = false
  -- end,
})

vim.lsp.enable("ruff")

-- Pyright
vim.lsp.config("pyright", {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
})

vim.lsp.enable("pyright")
