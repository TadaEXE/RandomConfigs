require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- System --
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.del("n", "<tab>") -- Restores original jumplist behavior

-- Harpoon --
local harpoon = require "harpoon"
vim.keymap.set("n", "<leader>m", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-m>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "m", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-m>", function() harpoon:list():next() end)

-- DAP --
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "Add breakpoint at line" })
map("n", "<leader>ds", "<cmd> DapStepOver <cr>", { desc = "Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <cr>", { desc = "Step into" })
map("n", "<leader>do", "<cmd> DapStepOut <cr>", { desc = "Step out" })
map("n", "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Dap Hover" })
map("n", "<leader>dr", "<cmd> DapContinue <cr>", { desc = "Start or continue the debugger" })

-- Tabs --
map("n", "<leader>1", "<cmd>tabn 1<cr>", { desc = "Go to tab 1" })
map("n", "<leader>2", "<cmd>tabn 2<cr>", { desc = "Go to tab 2" })
map("n", "<leader>3", "<cmd>tabn 3<cr>", { desc = "Go to tab 3" })
map("n", "<leader><cr>", "<cmd>tabnew<cr>", { desc = "Open new tab" })
map("n", "<leader><bs>", "<cmd>tabclose<cr>", { desc = "Close current tab" })

-- Treesitter --
local tsbuiltin = require "telescope.builtin"
map("n", "<leader>b", function()
  tsbuiltin.buffers {
    sort_mru = true,
    -- ignore_current_buffer = true,
  }
end)
map("n", "<leader>o", tsbuiltin.oldfiles, {})
