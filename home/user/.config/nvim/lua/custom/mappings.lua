local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>dus"] = {
        function ()
          local widgets = require('dap.ui.widgets');
          local sidebar = widgets.sidebar(widgets.scopes);
          sidebar.open();
        end,
        "Open debugging sidebar"
    }
  }
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "Update crates"
    }
  }
}

M.cmake = {
  n = {
    ["<leader>cb"] = {
      "<cmd>CMakeBuild<cr>",
      "Trigger cmake build"
    },
    ["<leader>cr"] = {
      "<cmd>CMakeRun<cr>",
      "Trigger cmake build and run"
    },
    ["<leader>cc"] = {
      "<cmd>CMakeClean<cr>",
      "Trigger cmake clean"
    }
  }
}

M.tabs = {
  n = {
  ["<leader>1"] = {
    "<cmd>tabn 1<cr>",
    "Go to tab 1"
  },
  ["<leader>2"] = {
    "<cmd>tabn 2<cr>",
    "Go to tab 2"
  },
  ["<leader>3"] = {
    "<cmd>tabn 3<cr>",
    "Go to tab 3"
  },
  ["<leader>4"] = {
    "<cmd>tabn 4<cr>",
    "Go to tab 4"
  },
  ["<leader>5"] = {
    "<cmd>tabn 5<cr>",
    "Go to tab 5"
  },
  ["<leader>6"] = {
    "<cmd>tabn 6<cr>",
    "Go to tab 6"
  },
  ["<leader>7"] = {
    "<cmd>tabn 7<cr>",
    "Go to tab 7"
  },
  ["<leader>8"] = {
    "<cmd>tabn 8<cr>",
    "Go to tab 8"
  },
  ["<leader>9"] = {
    "<cmd>tabn 9<cr>",
    "Go to tab 9"
  },
  ["<leader>-"] = {
    "<cmd>tabnext<cr>",
    "Got to next tab"
  },
  ["<leader>="] = {
    "<cmd>tabprevious<cr>",
    "Go to previous tab"
  },
  ["<leader><BS>"] = {
    "<cmd>tabclose<cr>",
    "Close current tab"
  },
  ["<leader><cr>"] ={
    "<cmd>tabnew<cr>",
    "Open new tab"
  },
}
}

return M
