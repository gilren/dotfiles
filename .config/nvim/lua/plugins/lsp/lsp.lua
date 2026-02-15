return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			"mason.nvim",
		},
		opts = {
			servers = {
				["*"] = {
          -- stylua: ignore
          keys = {
            { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition",       has = "definition" },
            { "gI",         false },
            { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>ss", false },
            { "<leader>sS", false },
            { "gai",        function() Snacks.picker.lsp_incoming_calls() end,   desc = "C[a]lls Incoming",      has = "callHierarchy/incomingCalls" },
            { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,   desc = "C[a]lls Outgoing",      has = "callHierarchy/outgoingCalls" },
          },
				},
			},
		},
	},
}
