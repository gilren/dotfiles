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
			-- LSP installer plugins
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Integrate blink w/ LSP
			-- "hrsh7th/cmp-nvim-lsp",
			-- Progress indicator for LSP
			{ "j-hui/fidget.nvim" },
		},
		config = function()
			local map_lsp_keybinds = require("gilren.keymaps").map_lsp_keybinds
			-- List your LSP servers here.
			local servers = {
				bashls = {},
				biome = {},
				cssls = {},
				eslint = {
					autostart = false,
					cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
					settings = { format = false },
				},
				emmet_ls = {
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				},
				html = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
							},
							telemetry = { enabled = false },
						},
					},
				},
				marksman = {},
				oxlint = {
					root_markers = { ".oxlintrc.json" },
				},
				sqls = {},
				tailwindcss = {
					filetypes = { "typescriptreact", "javascriptreact", "html", "svelte", "astro" },
				},
				pyright = {},
				yamlls = {},
				svelte = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							check = { command = "clippy", features = "all" },
						},
					},
				},
			}

			local formatters = {
				prettierd = {},
				stylua = {},
			}

			-- "prettier",
			-- 		"stylua",
			-- 		"isort",
			-- 		"black",
			-- 		"pylint",
			-- 		"eslint_d",

			local ensure_installed = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

			require("mason-tool-installer").setup({
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
				debounce_hours = 12,
				ensure_installed = ensure_installed,
			})

			-- Explicitly enable executeCommand support
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace = capabilities.workspace or {}
			capabilities.workspace.executeCommand = {
				dynamicRegistration = true,
			}

			-- Merge blink only if available
			local ok, blink = pcall(require, "blink.cmp")
			if ok then
				capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
			end

			-- Setup LspAttach autocmd for keybindings (replaces on_attach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local bufname = vim.api.nvim_buf_get_name(bufnr)

					-- Detach from non-file buffers (diffview, fugitive, etc.)
					if bufname == "" or bufname:match("^diffview://") or bufname:match("^fugitive://") then
						vim.schedule(function()
							vim.lsp.buf_detach_client(bufnr, event.data.client_id)
						end)
						return
					end

					map_lsp_keybinds(bufnr)
				end,
			})

			-- Setup each LSP server using the new vim.lsp.config API
			for name, config in pairs(servers) do
				-- Configure the server
				vim.lsp.config(name, {
					cmd = config.cmd,
					capabilities = capabilities,
					filetypes = config.filetypes,
					settings = config.settings,
					root_dir = config.root_dir,
					root_markers = config.root_markers,
				})

				-- Enable the server (with autostart setting if specified)
				if config.autostart == false then
				-- Don't auto-enable servers with autostart = false
				-- Users can manually enable with :lua vim.lsp.enable(name)
				else
					vim.lsp.enable(name)
				end
			end

			-- Setup Mason for managing external LSP servers
			require("mason").setup({ ui = { border = "rounded" } })
			require("mason-lspconfig").setup()

			local severity = vim.diagnostic.severity

			vim.diagnostic.config({
				signs = {
					text = {
						[severity.ERROR] = " ",
						[severity.WARN] = " ",
						[severity.HINT] = "󰠠 ",
						[severity.INFO] = " ",
					},
				},
			})
		end,
	},
}
-- vim.lsp.inlay_hint.enable(true)
