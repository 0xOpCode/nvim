-- ==============================================================================
-- 🌲 TREESITTER SYNTAX HIGHLIGHTING & RAINBOW DELIMITERS
-- ==============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      -- Compatibility shim for both modern (config) and legacy (configs) module APIs
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then
        ts = require("nvim-treesitter.config")
        package.loaded["nvim-treesitter.configs"] = ts
      end
      ts.setup(opts)
    end,
  },

  -- Rainbow Matching Brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
}
