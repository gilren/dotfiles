vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- Enable relative line numbers
opt.nu = true
opt.rnu = true

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

-- Enable mouse mode
opt.mouse = "a"

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

-- Always keep 8 lines above/below cursor unless at start/end of file
opt.scrolloff = 8

opt.guicursor = {
  "n-v-c:block",                                  -- Normal, visual, command-line: block cursor
  "i-ci-ve:ver25",                                -- Insert, command-line insert, visual-exclude: vertical bar cursor with 25% width
  "r-cr:hor20",                                   -- Replace, command-line replace: horizontal bar cursor with 20% height
  "o:hor50",                                      -- Operator-pending: horizontal bar cursor with 50% height
  "a:blinkwait700-blinkoff400-blinkon250",        -- All modes: blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block cursor with specific blinking settings
}
