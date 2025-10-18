local presets = require("markview.presets")
local heading_preset = presets.headings.slanted

heading_preset.org_indent = true

require("markview").setup({
	experimental = {
		check_rtp_message = false,
	},
	preview = {
		enable = false,
	},
	markdown = {
		headings = heading_preset,
		tables = presets.tables.single,
		horizontal_rules = presets.thin,
	},
})
