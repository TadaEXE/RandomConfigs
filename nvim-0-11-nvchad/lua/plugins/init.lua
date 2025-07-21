return {
  {
    "Shatur/neovim-session-manager",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local Path = require "plenary.path"
      require("session_manager").setup {
        sessions_dir = Path:new(vim.fn.stdpath "data", "sessions"),
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
        autosave_last_session = true,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
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
      local dap = require "dap"
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
    -- opts = {
    --   bind = true,
    --   handler_opts = {
    --     border = "rounded"
    --   }
    -- },
    -- config = function(_, opts) require'lsp_signature'.setup(opts) end
    config = function()
      require "configs.lsp_signature"
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "zbirenbaum/nvterm" },
    event = "VeryLazy",
    config = function()
      require "configs.cmake-tools"
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
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lsp"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
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
        "javascript",
        "typescript",
        "rust",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "cursor",
      max_lines = 1,
    },
  },
  -- {
  --   "mason-org/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "clangd",
  --       "clang-format",
  --       "codelldb",
  --       "rust-analyzer",
  --       "css-lsp",
  --       "html-lsp",
  --       "lua-language-server",
  --       "stylua",
  --     },
  --   },
  -- },
}
