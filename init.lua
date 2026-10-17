-- ==============================================================================
-- BYTEC STUDIO v2.0 - MODULAR NEOVIM IDE
-- ==============================================================================

-- Silence deprecation and transient LSP initialization noise
vim.deprecate = function() end

local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
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

require("config.options")
require("config.keymaps")
require("config.lazy")
