require("nvchad.configs.lspconfig").defaults()

-- General config --
-- Diagnostics
vim.diagnostic.config {
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
}

-- LSP --
local servers = { "html", "cssls", "clangd", "rust", "typescript_language_server", "pylsp", "typos_lsp" }

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
