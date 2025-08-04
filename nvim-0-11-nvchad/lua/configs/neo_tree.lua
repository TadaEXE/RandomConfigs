require("neo-tree").setup({
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "document_symbols",
  },
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
    sources = {
      { source = "filesystem" },
      { source = "document_symbols" },
      { source = "git_status" },
      { source = "buffers" },
    }
	},
})
