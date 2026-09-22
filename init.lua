-- ==============================================================================
-- 🛡️ DAEMON OS — MODERN MODULAR NEOVIM IDE (2026 META STACK)
-- ==============================================================================

-- 0. Silence harmless deprecation and transient LSP initialization noise
vim.deprecate = function() end

local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
    -- Suppress nvim-lspconfig deprecation warning for Nvim 0.10
    if msg:find("nvim%-lspconfig support for Nvim 0.10") or msg:find("deprecated") then
      return
    end
    -- Suppress transient clangd AST building messages (-32602)
    if msg:find("trying to get AST for non%-added document") or msg:find("%-32602") then
      return
    end
  end
  return orig_notify(msg, level, opts)
end

-- 1. Load Core Editor Options
require("config.options")

-- 2. Load Core Keymaps & Leader
require("config.keymaps")

-- 3. Bootstrap & Launch Lazy.nvim Plugin Manager
require("config.lazy")
