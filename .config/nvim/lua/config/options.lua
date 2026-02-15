vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Set tabs to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Enable auto indenting and set it to spaces
opt.smartindent = true
opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
opt.breakindent = true

opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.swapfile = false

-- Enable ignorecase + smartcase for better searching
opt.ignorecase = true
opt.smartcase = true

-- Decrease updatetime to 250ms
opt.updatetime = 250

-- Enable persistent undo history
opt.undofile = true

-- Enable 24-bit color
opt.termguicolors = true

-- Enable access to System Clipboard
opt.clipboard = "unnamed,unnamedplus" -- use system clipboard as default register
