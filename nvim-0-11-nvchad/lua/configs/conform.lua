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
		cmake = { "gersemi" },
		-- css = { "prettier" },
		-- html = { "prettier" },
	},
}

return options
