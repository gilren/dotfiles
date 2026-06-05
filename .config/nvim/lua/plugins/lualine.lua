return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local harpoon_list = require("harpoon"):list()

			local function harpoon_component()
				local total_marks = harpoon_list:length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				-- Find current buffer's index in the harpoon list
				local bufname = vim.api.nvim_buf_get_name(0)
				local cwd = vim.loop.cwd()
				if cwd and bufname ~= "" then
					local relpath = bufname
					if bufname:sub(1, #cwd + 1) == cwd .. "/" then
						relpath = bufname:sub(#cwd + 2)
					end
					local _, idx = harpoon_list:get_by_value(relpath)
					if idx then
						current_mark = tostring(idx)
					end
				end

				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			local function path(self)
				if vim.bo.filetype == "oil" then
					local ok, oil = pcall(require, "oil")
					if ok then
						return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
					end
					return ""
				end
				return LazyVim.lualine.pretty_path()(self)
			end

			local icons = LazyVim.config.icons

			require("lualine").setup({
				options = {
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "█", right = "█" },
				},
				sections = {
					lualine_b = {
						{ "branch", icon = "" },
						harpoon_component,
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
						"diagnostics",
					},
					lualine_c = {
						{ path },
					},
					lualine_x = {
						"filetype",
						Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
					},
				},
			})
		end,
	},
}
