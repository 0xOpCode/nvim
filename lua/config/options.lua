-- ==============================================================================
-- ⚙️ CORE OPTIONS & SETTINGS (DAEMON OS OLED STACK)
-- ==============================================================================

local opt = vim.opt

-- Line Numbers (Standard absolute numbering like VS Code)
opt.number = true
opt.relativenumber = false

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

-- Global C-style Indentation (p0 prevents indentation after function declarations / parentheses)
opt.cinoptions = "g0,:0,N-s,(0,W4,m1,j1,{0,f0,t0,p0"

-- C & C++ Specific Indentation & Format Rules
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.smartindent = false
    vim.opt_local.cinoptions = "g0,:0,N-s,(0,W4,m1,j1,{0,f0,t0,p0"
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})
