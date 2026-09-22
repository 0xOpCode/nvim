-- ==============================================================================
-- 🎮 CORE KEYMAPS & SHORTCUTS (LEADER: SPACE)
-- ==============================================================================

local map = vim.keymap.set

-- Set Leader Key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. General Helpers
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- 2. Buffer Controls & Switching
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer Tab" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer Tab" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close Current Buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })

-- 3. Seamless Window Split Navigation (Ctrl + h/j/k/l)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 4. Window Split Creation
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- 5. Resize Window Splits with Arrow Keys
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- 6. Move Selected Lines Up/Down (Alt + j/k)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- 7. Better Indentation in Visual Mode (Stays in visual selection)
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- 8. Diagnostics Float
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics Float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- 9. 1-Click Copy All Logs / Notifications to System Clipboard
map("n", "<leader>nc", function()
  local lines = {}
  -- 1. Grab Snacks Notifier history
  if _G.Snacks and Snacks.notifier and Snacks.notifier.get_history then
    for _, notif in ipairs(Snacks.notifier.get_history()) do
      local title = notif.title and ("[" .. notif.title .. "] ") or ""
      local msg = notif.msg or ""
      if msg ~= "" then
        table.insert(lines, title .. msg)
      end
    end
  end
  -- 2. Grab standard Vim messages
  local msgs = vim.fn.execute("messages")
  if msgs and msgs ~= "" and msgs ~= "\n" then
    table.insert(lines, "\n--- Standard Messages ---")
    table.insert(lines, msgs)
  end

  local final_text = table.concat(lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
  if final_text == "" then
    vim.notify("ℹ️ No recent messages/logs found!", vim.log.levels.INFO)
    return
  end
  vim.fn.setreg("+", final_text)
  vim.fn.setreg('"', final_text)
  vim.notify("📋 Copied " .. #lines .. " logs/notifications to clipboard!", vim.log.levels.INFO)
end, { desc = "Copy all logs/notifications to clipboard" })

-- 10. Fast Compile & Run Current File (<leader>r)
local runner_term = nil
map("n", "<leader>r", function()
  -- 1. Auto-save if buffer is modified or has a filename
  if vim.bo.modified or vim.fn.empty(vim.fn.expand("%")) == 0 then
    vim.cmd("silent! write")
  end

  local ft = vim.bo.filetype
  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  local filename = vim.fn.expand("%:t")
  local output = vim.fn.expand("%:p:r")

  if file == "" then
    vim.notify("⚠️ Save file first before running!", vim.log.levels.WARN)
    return
  end

  local run_cmd = nil
  if ft == "c" then
    run_cmd = string.format("clang -Wall -Wextra -O2 -g %q -o %q -lm && %q", file, output, output)
  elseif ft == "cpp" then
    run_cmd = string.format("clang++ -Wall -Wextra -O2 -g -std=c++20 %q -o %q && %q", file, output, output)
  elseif ft == "rust" then
    run_cmd = string.format("rustc %q -o %q && %q", file, output, output)
  elseif ft == "python" then
    run_cmd = string.format("python3 %q", file)
  elseif ft == "javascript" then
    run_cmd = string.format("node %q", file)
  elseif ft == "typescript" then
    run_cmd = string.format("npx tsx %q", file)
  elseif ft == "sh" or ft == "bash" then
    run_cmd = string.format("bash %q", file)
  elseif ft == "java" then
    run_cmd = string.format("javac %q && java -cp %q %q", file, dir, vim.fn.expand("%:t:r"))
  else
    vim.notify("⚠️ No run command defined for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  -- Wrap command to display exit status and pause so output is visible
  local full_cmd = string.format(
    "cd %q && echo '⚡ Compiling & Running %s...' && %s; echo ''; echo '════════════════════════════════════════'; echo 'Finished with exit code '$?'. Press Enter to close...'; read",
    dir,
    filename,
    run_cmd
  )

  -- Close prior runner terminal if open
  if runner_term and runner_term:buf_valid() then
    runner_term:close()
  end

  runner_term = Snacks.terminal.open(full_cmd, {
    win = {
      position = "bottom",
      height = 0.38,
      border = "rounded",
      title = " 🚀 Run: " .. filename .. " ",
      title_pos = "center",
    },
    interactive = true,
  })
end, { desc = "Save, Compile & Run current file" })
