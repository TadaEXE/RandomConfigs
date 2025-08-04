-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

-- HACK: blink.cmp updates | Remove LuaSnip | Emoji and Dictionary Sources | Fix Jump Autosave Issue
-- https://youtu.be/JrgfpWap_Pg

-- completion plugin with support for LSPs and external sources that updates
-- on every keystroke with minimal overhead

-- https://www.lazyvim.org/extras/coding/blink
-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

local opts = function(_, opts)
	-- I noticed that telescope was extremeley slow and taking too long to open,
	-- assumed related to blink, so disabled blink and in fact it was related
	-- :lua print(vim.bo[0].filetype)
	-- So I'm disabling blink.cmp for Telescope
	opts.enabled = function()
		-- Get the current buffer's filetype
		local filetype = vim.bo[0].filetype
		-- Disable for Telescope buffers
		if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
			return false
		end
		return true
	end

	-- NOTE: The new way to enable LuaSnip
	-- Merge custom sources with the existing ones from lazyvim
	-- NOTE: by default lazyvim already includes the lazydev source, so not adding it here again
	opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
		default = { "lsp", "path", "buffer", "dictionary" },
		providers = {
			lsp = {
				name = "lsp",
				enabled = true,
				module = "blink.cmp.sources.lsp",
				kind = "LSP",
				min_keyword_length = 2,
				-- When linking markdown notes, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no LSP
				-- suggestions
				--
				-- Enabled fallbacks as this seems to be working now
				-- Disabling fallbacks as my snippets wouldn't show up when editing
				-- lua files
				-- fallbacks = { "snippets", "buffer" },
				score_offset = 90, -- the higher the number, the higher the priority
			},
			path = {
				name = "Path",
				module = "blink.cmp.sources.path",
				score_offset = 25,
				-- When typing a path, I would get snippets and text in the
				-- suggestions, I want those to show only if there are no path
				-- suggestions
				fallbacks = { "snippets", "buffer" },
				-- min_keyword_length = 2,
				opts = {
					trailing_slash = false,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			buffer = {
				name = "Buffer",
				enabled = true,
				max_items = 3,
				module = "blink.cmp.sources.buffer",
				min_keyword_length = 2,
				score_offset = 15, -- the higher the number, the higher the priority
			},
		},
	})

	opts.cmdline = {
		enabled = true,
	}

	opts.completion = {
		-- accept = {
		--   auto_brackets = {
		--     enabled = true,
		--     default_brackets = { ";", "" },
		--     override_brackets_for_filetypes = {
		--       markdown = { ";", "" },
		--     },
		--   },
		-- },
		--   keyword = {
		--     -- 'prefix' will fuzzy match on the text before the cursor
		--     -- 'full' will fuzzy match on the text before *and* after the cursor
		--     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
		--     range = "full",
		--   },
		menu = {
			border = "single",
		},
		documentation = {
			auto_show = true,
			window = {
				border = "single",
			},
		},
	}

	-- opts.fuzzy = {
	--   -- Disabling this matches the behavior of fzf
	--   use_typo_resistance = false,
	--   -- Frecency tracks the most recently/frequently used items and boosts the score of the item
	--   use_frecency = true,
	--   -- Proximity bonus boosts the score of items matching nearby words
	--   use_proximity = false,
	-- }

	opts.snippets = {
		preset = "luasnip", -- Choose LuaSnip as the snippet engine
	}

	-- -- To specify the options for snippets
	-- opts.sources.providers.snippets.opts = {
	--   use_show_condition = true, -- Enable filtering of snippets dynamically
	--   show_autosnippets = true, -- Display autosnippets in the completion menu
	-- }

	-- The default preset used by lazyvim accepts completions with enter
	-- I don't like using enter because if on markdown and typing
	-- something, but you want to go to the line below, if you press enter,
	-- the completion will be accepted
	-- https://cmp.saghen.dev/configuration/keymap.html#default
	opts.keymap = {
		preset = "default",
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },

		["<S-k>"] = { "scroll_documentation_up", "fallback" },
		["<S-j>"] = { "scroll_documentation_down", "fallback" },

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
	}
end

return opts
