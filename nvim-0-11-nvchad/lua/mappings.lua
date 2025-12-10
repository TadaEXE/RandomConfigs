require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

local function feed(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)
end

local function replace_at(r, c1)
	vim.api.nvim_win_set_cursor(0, { r, c1 - 1 })
	feed("r<cr>")
end


-- System --
map("i", "jf", "<ESC>", { desc = "System go normal mode" })
map("i", "fj", "<ESC>", { desc = "System go normal mode" })
map({ "n" }, "<C-s>", "<cmd> w <cr>", { desc = "System save current buffer to file" })
map("i", "<C-f>", function()
	feed("<esc>")
	local _, col = unpack(vim.api.nvim_win_get_cursor(0))
	if col > 0 then
		feed("l")
	end
	feed("dwi")
end, { desc = "System delete word forward (opposite of <C-w>)" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "System Close current buffer", noremap = true })
map("n", "<M-l>", function()
	local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local col1 = col0 + 1
	-- Space under cursor that is preceded by \S ?
	if line:sub(col1, col1) == " " and col1 > 1 and not line:sub(col1 - 1, col1 - 1):match("%s") then
		replace_at(row, col1)
		return
	end
	-- Next match to the right on the same line:  \S\zs<space>
	local pat_right = "\\%>" .. col0 .. "c\\S\\zs "
	local right = vim.fn.searchpos(pat_right, "nW", row)
	if right[1] ~= 0 then
		replace_at(row, right[2])
		return
	end
end, { desc = "System Replace next not indenting space with a new line" })
map("n", "<M-h>", function()
	local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
	-- Previous match to the left on the same line
	local pat_left = "\\%<" .. col0 .. "c\\S\\zs "
	local left = vim.fn.searchpos(pat_left, "nbW", row)
	if left[1] ~= 0 then
		replace_at(row, left[2])
		return
	end
end, { desc = "System Replace previous non indenting space with new line" })
map("n", "<M-j>", function()
	local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local col1 = col0 + 1
	-- '{' under cursor
	if line:sub(col1, col1) == "{" then
		feed("li<cr><esc>")
		return
	end
	-- Previous '{' to the left on this line
	local pat_left = "\\%<" .. col1 .. "c{"
	local left = vim.fn.searchpos(pat_left, "nbW", row)
	if left[1] ~= 0 then
		vim.api.nvim_win_set_cursor(0, { row, left[2] })
		feed("i<cr><esc>")
		return
	end
end, { desc = "System insert newline infront of next {" })
map("n", "<M-k>", function()
	local row, col0 = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local col1 = col0 + 1
	-- '}' under cursor
	if line:sub(col1, col1) == "}" then
		feed("i<cr><esc>")
		return
	end
	-- Next '}' to the right on this line
	local pat_right = "\\%>" .. col0 .. "c}"
	local right = vim.fn.searchpos(pat_right, "nW", row)
	if right[1] ~= 0 then
		vim.api.nvim_win_set_cursor(0, { row, right[2] - 1 })
		feed("i<cr><esc>")
		return
	end
end, { desc = "System insert new line infront of next }" })

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
map("n", "<leader>+", "<cmd>tabnew<cr>", { desc = "Tabs Open new tab" })
map("n", "<leader>-", "<cmd>tabclose<cr>", { desc = "Tabs Close current tab" })

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
	"<cmd>Neotree reveal right<cr>",
	{ desc = "Neotree Reveal current file in file tree", noremap = true }
)

-- CMake-Tools --
map("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Run cmake build", noremap = true })
map("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Run cmake clean", noremap = true })
map("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run cmake run", noremap = true })
map("n", "<leader>csp", "<cmd>CMakeSelectBuildPreset<cr>", { desc = "CMake Select build preset", noremap = true })
map("n", "<leader>cst", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select build target", noremap = true })
map("n", "<leader>csl", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake Select launch target", noremap = true })
map(
	"n",
	"<leader>csc",
	"<cmd>CMakeSelectConfigurePreset<cr>",
	{ desc = "CMake Select configure preset", noremap = true }
)

-- Markview --
map("n", "<leader>mt", "<cmd>Markview Toggle<cr>", { desc = "Markview Toggle inplace markdown rendering" })
map("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Markview Toggle split view markdown rentering" })

--C/C++ Custom--
map("n", "<leader>kk", require("ctoggle").toggle, { desc = "C/C++ Toggle header/source" })
map("n", "<leader>kl", require("ctoggle").vsplit, { desc = "C/C++ Toggle header/source in vsplit" })
