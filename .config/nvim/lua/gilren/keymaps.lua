local M = {}

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

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
