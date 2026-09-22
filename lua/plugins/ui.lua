-- ==============================================================================
-- 🎨 UI AESTHETICS, THEME, STATUSLINE & BUFFERLINE
-- ==============================================================================

return {
  -- 1. OLED High-Contrast Cyberpunk Theme
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        theme = {
          variant = "default",
          highlights = {
            Normal = { bg = "#000000" },
            NormalNC = { bg = "#000000" },
            SignColumn = { bg = "#000000" },
            CursorLine = { bg = "#101018" },
            StatusLine = { bg = "#08080c" },
            FloatBorder = { fg = "#00ff44", bg = "#000000" },
            NormalFloat = { bg = "#000000" },
          },
        },
      })
      vim.cmd("colorscheme cyberdream")
    end,
  },

  -- 2. Sleek Mini Icons (Fast & lightweight)
  {
    "echasnovski/mini.icons",
    lazy = false,
    version = false,
    opts = {},
  },

  -- 3. Top Browser-like Buffer Tabs (Bufferline)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "snacks_layout_box",
            text = "📁 Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },

  -- 4. Bottom Modern Glowing Statusline (Lualine)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      options = {
        theme = "cyberdream",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", icon = "⚡" } },
        lualine_b = { { "branch", icon = "" }, "diff" },
        lualine_c = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          { "filename", file_status = true, path = 1 },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", icon = "📍" } },
      },
    },
  },

  -- 5. Interactive Keymap Assistant (Which-Key v3)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = {
        border = "rounded",
      },
      spec = {
        { "<leader>f", group = "🔍 Find / Search" },
        { "<leader>b", group = "📑 Buffers" },
        { "<leader>s", group = "🪟 Window Splits" },
        { "<leader>c", group = "💡 Code / LSP" },
        { "<leader>g", group = "🐙 Git Tools" },
        { "<leader>t", group = "💻 Terminal" },
        { "<leader>n", group = "🔔 Notifications / Logs" },
      },
    },
  },
}
