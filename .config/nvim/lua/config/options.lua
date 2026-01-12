-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd("let g:netrw_liststyle = 3")


local opt = vim.opt

opt.autoindent = true               -- copy indent from current line when starting new one
opt.termguicolors = true
opt.backspace = "indent,eol,start"  -- allow backspace on indent, end of line or insert mode start position
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.swapfile = false
