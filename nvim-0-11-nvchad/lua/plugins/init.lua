return {
	{
		"TadaEXE/winctrl.nvim",
	},
	{
		"kawre/leetcode.nvim",
		lazy = false,
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			-- include a picker of your choice, see picker section for more details
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			arg = "leetcode",
			storage = {
				home = "/home/tada/p/leetcode",
				cache = "/home/tada/p/leetcode",
			},
			injector = {
				["python3"] = {
					imports = function(default_imports)
						vim.list_extend(default_imports, { "from .leetcode import *" })
						return default_imports
					end,
					after = { "def test():", "    print('test')" },
				},
				["cpp"] = {
					imports = function()
						-- return a different list to omit default imports
						return { "#include <bits/stdc++.h>", "using namespace std;" }
					end,
					after = "int main() {}",
				},
			},
		},
	},
	{
		"wgsl-analyzer/wgsl-analyzer",
		lazy = false,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"Shatur/neovim-session-manager",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
				autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
				autosave_last_session = true,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = require("configs.conform"),
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.api.nvim_create_user_command("DapUi", function(cmd)
				dapui.toggle(cmd.args)
			end, {nargs='*'})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = function(_, _)
			vim.fn.sign_define("DapBreakpoint", { text = "󰯰", texthl = "", linehl = "", numhl = "" })
			local dap = require("dap")
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb", -- or if not in $PATH: "/absolute/path/to/codelldb"

				-- On windows you may have to uncomment this:
				-- detached = false,
			}
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		opts = {
			extra_groups = { "NormalFloat" },
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("configs.lsp_signature")
		end,
	},
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = { "zbirenbaum/nvterm" },
		event = "VeryLazy",
		config = function()
			require("configs.cmake-tools")
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function() end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		ft = "rust",
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		config = function()
			require("configs.cmp")
		end,
	},
	{
		"hrsh7th/cmp-path",
		lazy = false,
	},
	{
		"saecki/crates.nvim",
		dependencies = "hrsh7th/nvim-cmp",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- test new blink
	-- {
	-- 	import = "nvchad.blink.lazyspec",
	-- 	opts = function(_, _)
	-- 		require("configs.blink-cmp")
	-- 	end,
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"cpp",
				"c",
				"python",
				"markdown",
				"markdown_inline",
				"latex",
				"typst",
				"yaml",
				"toml",
				"json",
				"javascript",
				"typescript",
				"rust",
				"svelte",
				"gdscript",
				"godot_resource",
				"gdshader",
			},
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy", opts = { mode = "cursor", maxlines = 1 } },
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		config = function()
			require("configs.markview")
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				hint = "floating-letter",
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		config = function()
			require("configs.neo_tree")
		end,
		lazy = false, -- neo-tree will lazily load itself
	},
	-- Stuff from NvChad I don't need --
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
	},
	{
		"mbbill/undotree",
		lazy = false,
		-- opts = {
		-- 	window = {
		-- 		winblend = 40,
		-- 		border = "single", -- The string values are the same as those described in 'winborder'.
		-- 	},
		-- },
	},
	-- {
	-- 	"mason-org/mason.nvim",
	--    lazy = false,
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"clangd",
	-- 			"clang-format",
	-- 			"codelldb",
	-- 			"pyright",
	-- 			"rust-analyzer",
	-- 			"css-lsp",
	-- 			"typos-lsp",
	-- 			"html-lsp",
	-- 			"lua-language-server",
	-- 			"stylua",
	-- 		},
	-- 	},
	-- },
}
