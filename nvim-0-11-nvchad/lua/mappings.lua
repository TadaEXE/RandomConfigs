require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- System --
map("n", ";", ":", { desc = "System enter command mode" })
map("i", "jf", "<ESC>", { desc = "System go normal mode" })
map("i", "fj", "<ESC>", { desc = "System go normal mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "System save current buffer to file" })
vim.keymap.del("n", "<tab>") -- Restores original jumplist behavior
map("i", "<C-f>", "<C-[>ldwi", { desc = "System delete word forward (opposite of <C-w>)" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "System Close current buffer", noremap = true })

-- LSP --
map("n", "grk", function()
	vim.diagnostic.config({
		virtual_lines = {
			current_line = true,
		},
	})
	vim.diagnostic.show(nil, 0)
	vim.api.nvim_create_autocmd("CursorMoved", {
		buffer = 0,
		once = true,
		callback = function()
			vim.diagnostic.config({
				virtual_lines = false,
			})
		end,
	})
end, { desc = "LSP Show virtual diagnostics for current line once" })
map("n", "grd", vim.diagnostic.open_float, { desc = "LSP Open diagnostic float" })
map("n", "grh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled() or false)
  print("Inlay hints " .. (vim.lsp.inlay_hint.is_enabled() and "ON" or "OFF"))
end, { desc = "LSP Toggle inlay hints" })

-- Harpoon --
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>H", function()
	harpoon:list():add()
end, { desc = "Harpoon Add current buffer to list", noremap = true })
vim.keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Open quick menu", noremap = true })
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(1)
end, { desc = "Harpoon Open list item 1", noremap = true })
vim.keymap.set("n", "<leader>5", function()
	harpoon:list():select(2)
end, { desc = "Harpoon Open list item 2", noremap = true })
vim.keymap.set("n", "<leader>7", function()
	harpoon:list():select(3)
end, { desc = "Harpoon Open list item 3", noremap = true })
vim.keymap.set("n", "<leader>8", function()
	harpoon:list():select(4)
end, { desc = "Harpoon Open list item 4", noremap = true })

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

-- Neotree --
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Neotree Toggle file tree", noremap = true })
map(
	"n",
	"<leader>e",
	"<cmd>Neotree reveal left<cr>",
	{ desc = "Neotree Reveal current file in file tree", noremap = true }
)

-- Markview --
map("n", "<leader>mt", "<cmd>Markview Toggle<cr>", { desc = "Markview Toggle inplace markdown rendering" })
map("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Markview Toggle split view markdown rentering" })
