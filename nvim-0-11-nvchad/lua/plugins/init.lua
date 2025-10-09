return {
	{
		dir = "~/Projects/winctrl.nvim",
		config = function()
      require("winctrl").setup()
		end,
    lazy = false,
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
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

				-- On windows you may have to uncomment this:
				-- detached = false,
			}
		end,
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
			},
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy", opts = { mode = "cursor", maxlines = 1 } },
	{
		"OXY2DEV/markview.nvim",
		priority = 1000,
		event = "BufRead *.md",

		-- For blink.cmp's completion
		-- source
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
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
