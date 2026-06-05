return {
	"malewicz1337/oil-git.nvim",
	dependencies = { "stevearc/oil.nvim" },
	config = function()
		local function hl_fg(name, fallback)
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
			if ok and hl and hl.fg then
				return "#" .. string.format("%06x", hl.fg)
			end
			return fallback
		end

		local function get_highlights()
			return {
				OilGitAdded = { fg = hl_fg("GitSignsAdd", "#a3be8c") },
				OilGitModifiedStaged = { fg = hl_fg("GitSignsChange", "#ebcb8b") },
				OilGitModifiedUnstaged = { fg = hl_fg("GitSignsChange", "#d9b263") },
				OilGitBranch = { fg = hl_fg("DiagnosticInfo", "#81a1c1") },
				OilGitRenamed = { fg = hl_fg("@text.reference", "#b48ead") },
				OilGitDeleted = { fg = hl_fg("GitSignsDelete", "#bf616a") },
				OilGitCopied = { fg = hl_fg("@text.reference", "#b48ead") },
				OilGitConflict = { fg = hl_fg("DiagnosticWarn", "#c9826b") },
				OilGitUntracked = { fg = hl_fg("DiagnosticInfo", "#81a1c1") },
				OilGitIgnored = { fg = hl_fg("Comment", "#60728a") },
			}
		end

		-- Initial setup: pass highlights through oil-git's own setup
		require("oil-git").setup({ highlights = get_highlights() })

		-- Re-apply on theme change (for your LazyReload hot-reload).
		-- We set highlight groups directly via nvim_set_hl instead of calling
		-- setup() again, because the plugin skips groups that already exist.
		-- Neovim auto-updates existing extmarks when the referenced group changes.
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("OilGitTheme", { clear = true }),
			callback = function()
				vim.defer_fn(function()
					for name, opts in pairs(get_highlights()) do
						vim.api.nvim_set_hl(0, name, opts)
					end
				end, 10)
			end,
		})

		-- Oil fires User OilActionsPost after any file create/delete/rename/move.
		-- The plugin only invalidates its git cache on BufWritePost, but oil
		-- touches files directly — no buffer write happens. The 500ms TTL cache
		-- stays warm and the new file stays invisible until next BufEnter.
		-- Invalidating here lets the plugin's TextChanged handler (which fires
		-- right after the buffer re-render) fetch fresh git status.
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function()
				require("oil-git.git").invalidate_cache()
			end,
		})
	end,
}
