return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"query",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			}
		}
	},
}
