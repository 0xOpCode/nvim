-- ==============================================================================
-- 🐙 GITSIGNS (GUTTER SIGNS, BLAME, HUNK PREVIEWS)
-- ==============================================================================

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Git Hunk" })

        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous Git Hunk" })

        -- Actions
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Git Hunk" })
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line Full" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Git Diff Against Index" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Git Hunk" })
      end,
    },
  },
}
