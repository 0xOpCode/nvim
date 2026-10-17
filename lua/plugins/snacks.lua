-- ==============================================================================
-- SNACKS.NVIM (DASHBOARD, PICKERS, EXPLORER, TERMINAL, NOTIFIER)
-- ==============================================================================

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
   ██████╗ ██╗   ██╗████████╗███████╗ ██████╗    ███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗
   ██╔══██╗╚██╗ ██╔╝╚══██╔══╝██╔════╝██╔════╝    ██╔════╝╚══██╔══╝██║   ██║██╔═██╗██║██╔═══██╗
   ██████╔╝ ╚████╔╝    ██║   █████╗  ██║         ███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║
   ██╔══██╗  ╚██╔╝     ██║   ██╔══╝  ██║         ╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║
   ██████╔╝   ██║      ██║   ███████╗╚██████╗    ███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝
   ╚═════╝    ╚═╝      ╚═╝   ╚══════╝ ╚═════╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝
                          BYTEC STUDIO v2.0 - POCKET C & C++ IDE]],
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "t", desc = "Open Terminal", action = function() Snacks.terminal() end },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "recent_files", icon = " ", title = "Recent Files", padding = 1 },
          { section = "projects", icon = " ", title = "Projects", padding = 1 },
          { section = "startup" },
        },
      },
      explorer = { enabled = true },
      image = { enabled = false },
      indent = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        filter = function(notif)
          local msg = notif.msg or ""
          if msg:find("deprecated") or msg:find("%-32602") then
            return false
          end
          return true
        end,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      -- 1. File Explorer
      { "<leader>e", function() Snacks.explorer() end, desc = "Toggle File Explorer" },

      -- 2. Pickers & Search
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep (Search Text)" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Open Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Search Help Tags" },
      { "<leader>fc", function() Snacks.picker.command_history() end, desc = "Command History" },

      -- 3. Git Tools
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Open LazyGit Floating Window" },
      { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Current Line" },

      -- 4. Terminal Toggle
      { "<leader>tt", function() Snacks.terminal() end, mode = { "n", "t", "i" }, desc = "Toggle Terminal" },
      { "<C-\\>", function() Snacks.terminal() end, mode = { "n", "t", "i" }, desc = "Toggle Terminal" },
      { "<C-`>", function() Snacks.terminal() end, mode = { "n", "t", "i" }, desc = "Toggle Terminal" },
      { "<C-~>", function() Snacks.terminal() end, mode = { "n", "t", "i" }, desc = "Toggle Terminal" },
      { "<C-j>", function() Snacks.terminal() end, mode = { "n", "t", "i" }, desc = "Toggle Terminal" },

      -- 5. Notifications History & Dismiss
      { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
  },
}
