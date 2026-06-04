local M = {}

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false, desc = "Save current buffer" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false, desc = "Quit current buffer" })

keymap.set("n", "<leader>e", function()
	require("oil").toggle_float()
end, { desc = "Toggle Oil file explorer" })

-- Map Undotree
keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- Redo last change
keymap.set("n", "U", "<C-r>", { desc = "Redo last change" })


local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()

-- Harpoon keybinds --
keymap.set("n", "<leader>ho", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon quick menu" })

keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end, { desc = "Add current file to Harpoon" })

-- keymap.set("n", "<leader>hr", function()
-- 	require("harpoon.mark").rm_file()
-- end, { desc = "Remove current file from Harpoon" })

-- keymap.set("n", "<leader>hc", function()
-- 	require("harpoon.mark").clear_all()
-- end, { desc = "Clear all Harpoon marks" })

keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Navigate to Harpoon file 1" })

keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Navigate to Harpoon file 2" })

keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Navigate to Harpoon file 3" })

keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Navigate to Harpoon file 4" })

keymap.set("n", "<leader>5", function()
	harpoon:list():select(5)
end, { desc = "Navigate to Harpoon file 5" })

M.map_lsp_keybinds = function(buffer_number)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol", buffer = buffer_number })
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action", buffer = buffer_number })
	-- keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition", buffer = buffer_number })

	keymap.set(
		"n",
		"gr",
		require("snacks").picker.lsp_references,
		{ desc = "LSP: Go to references", buffer = buffer_number }
	)

	keymap.set(
		"n",
		"gi",
		require("snacks").picker.lsp_implementations,
		{ desc = "LSP: Go to implementations", buffer = buffer_number }
	)

	keymap.set(
		"n",
		"<leader>bs",
		require("snacks").picker.lsp_symbols,
		{ desc = "LSP: Document symbols", buffer = buffer_number }
	)
	keymap.set(
		"n",
		"<leader>ps",
		require("snacks").picker.lsp_workspace_symbols,
		{ desc = "LSP: Workspace symbols", buffer = buffer_number }
	)
end

return M
