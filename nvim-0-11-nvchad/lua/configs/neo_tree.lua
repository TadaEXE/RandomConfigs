require("neo-tree").setup({
	window = {
		mappings = {
			["<cr>"] = {
				"open_with_window_picker",
			},
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
	source_selector = {
		winbar = true,
		statusline = flase,
	},
})
