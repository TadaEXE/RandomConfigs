require("nvim-treesitter.configs").setup({
	indent = {
		enable = true,
		disable = { "gdscript" },
	},
})

local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		gdscript = { "gdformat" },
		-- css = { "prettier" },
		-- html = { "prettier" },
	},

	-- format_on_save = {
	--   -- These options will be passed to conform.format()
	--   timeout_ms = 500,
	--   lsp_fallback = true,
	-- },
}

return options
