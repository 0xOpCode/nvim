-- ==============================================================================
-- ⚙️ CORE OPTIONS & SETTINGS (DAEMON OS OLED STACK)
-- ==============================================================================

local opt = vim.opt

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation (Modern standard: 2 spaces)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = false

-- UI & Aesthetics
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.pumheight = 10 -- Pop-up menu height
opt.showmode = false -- Lualine already displays mode
opt.wrap = false -- No line wrap by default
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8

-- Mouse & Clipboard
opt.mouse = "a" -- Full mouse support (click tabs, scroll, select text)
opt.clipboard = "unnamedplus" -- System clipboard sync (wl-clipboard on Wayland)

-- Search & Patterns
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Window Splits
opt.splitbelow = true
opt.splitright = true

-- Performance, Undo & Backups
opt.undofile = true -- Persistent undo history across file edits
opt.swapfile = false
opt.backup = false
opt.updatetime = 200 -- Fast update for diagnostics & gitsigns (200ms)
opt.timeoutlen = 300 -- Fast which-key popup trigger (300ms)

-- Completion popup behavior
opt.completeopt = { "menu", "menuone", "noselect" }

-- Disable unused providers to avoid warning logs
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
