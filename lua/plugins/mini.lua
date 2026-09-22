-- ==============================================================================
-- 🛠️ MINI.NVIM HELPERS (AUTO-PAIRS, SMART COMMENTS, SURROUND)
-- ==============================================================================

return {
  -- 1. Auto-pairs (Automatically closes quotes "", brackets (), {})
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- 2. Fast Commenting (gcc to comment line, gc in visual mode)
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
  },

  -- 3. Surround (Add/Delete/Replace surrounding tags/quotes)
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
}
