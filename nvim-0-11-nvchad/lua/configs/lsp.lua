require("nvchad.configs.lspconfig").defaults()

-- General config --
-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
})

-- LSP --
local servers = {
	"html",
	"cssls",
	"clangd",
	"rust",
	-- "typescript_language_server", -- <-- broken for now
	"pyright",
	"typos_lsp",
	"wgsl_analyzer",
  "svelteserver",
  "gdscript",
  "csharp_ls",
  "marksman",
}

vim.lsp.inlay_hint.enable(true)
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
