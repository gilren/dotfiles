return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			dim = { enabled = true },
			gitbrowse = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
				style = "fancy",
			},
			rename = { enabled = true },
			toggle = { enabled = true },
			scratch = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	}
}
