require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- System --
map("n", ";", ":", { desc = "System enter command mode" })
map("i", "jk", "<ESC>", { desc = "System go normal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "System save current buffer to file" })
vim.keymap.del("n", "<tab>") -- Restores original jumplist behavior
map("i", "<C-f>", "<C-[>diwi", { desc = "System delete word forward (opposite of <C-w>)" })

-- Harpoon --
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>m", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "m", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "m", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-m>", function() harpoon:list():next() end)

-- DAP --
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", { desc = "DAP Add breakpoint at line" })
map("n", "<leader>ds", "<cmd> DapStepOver <cr>", { desc = "DAP Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <cr>", { desc = "DAP Step into" })
map("n", "<leader>do", "<cmd> DapStepOut <cr>", { desc = "DAP Step out" })
map("n", "<leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "Dap Hover" })
map("n", "<leader>dr", "<cmd> DapContinue <cr>", { desc = "DAP Start or continue the debugger" })

-- Tabs --
map("n", "<leader>1", "<cmd>tabn 1<cr>", { desc = "Tabs Go to tab 1" })
map("n", "<leader>2", "<cmd>tabn 2<cr>", { desc = "Tabs Go to tab 2" })
map("n", "<leader>3", "<cmd>tabn 3<cr>", { desc = "Tabs Go to tab 3" })
map("n", "<leader><cr>", "<cmd>tabnew<cr>", { desc = "Tabs Open new tab" })
map("n", "<leader><bs>", "<cmd>tabclose<cr>", { desc = "Tabs Close current tab" })

-- Telescope --
local tsbuiltin = require("telescope.builtin")
map("n", "<leader>b", function()
	tsbuiltin.buffers({
		initial_mode = "normal",
		sort_lastused = true,
		shorten_path = true,
	})
end, { desc = "Telescope Open buffer view" })
map("n", "<leader>o", tsbuiltin.oldfiles, { desc = "Telescope Open old files" })

-- Git --
map("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", { desc = "Git Blame" })
map("n", "<leader>gcb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Git Toggle blame for current line" })
