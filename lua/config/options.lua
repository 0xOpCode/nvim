-- ==============================================================================
-- CORE OPTIONS & SETTINGS (BYTEC STUDIO v2.0)
-- ==============================================================================

local opt = vim.opt

-- Line Numbers (Absolute numbering like VS Code)
opt.number = true
opt.relativenumber = false

-- Tabs & Indentation
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
opt.pumheight = 10
opt.showmode = false
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Mouse, Shift+Arrow Selection & Clipboard
opt.mouse = "a"
opt.keymodel = "startsel,stopsel"
opt.selectmode = "mouse,key"

local termux_set = vim.fn.executable("termux-clipboard-set") == 1 and "termux-clipboard-set"
  or (vim.fn.executable("/data/data/com.termux/files/usr/bin/termux-clipboard-set") == 1
    and "/data/data/com.termux/files/usr/bin/termux-clipboard-set")
  or nil
local termux_get = vim.fn.executable("termux-clipboard-get") == 1 and "termux-clipboard-get"
  or (vim.fn.executable("/data/data/com.termux/files/usr/bin/termux-clipboard-get") == 1
    and "/data/data/com.termux/files/usr/bin/termux-clipboard-get")
  or nil

if termux_set and termux_get then
  vim.g.clipboard = {
    name = "termux",
    copy = {
      ["+"] = termux_set,
      ["*"] = termux_set,
    },
    paste = {
      ["+"] = termux_get,
      ["*"] = termux_get,
    },
    cache_enabled = 0,
  }
end

opt.clipboard = "unnamedplus"

-- Cursor Line Wrapping
opt.whichwrap = "b,s,<,>,[,],h,l"

-- Search & Patterns
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Window Splits
opt.splitbelow = true
opt.splitright = true

-- Performance, Undo & Backups
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 200
opt.timeoutlen = 300

-- Completion popup behavior
opt.completeopt = { "menu", "menuone", "noselect" }

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Global C-style Indentation (p0 prevents indentation after function declarations)
opt.cinoptions = "g0,:0,N-s,(0,W4,m1,j1,{0,f0,t0,p0"

-- C & C++ Indentation & Format Rules
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
