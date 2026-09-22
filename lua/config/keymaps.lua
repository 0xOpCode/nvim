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
map("n", "<leader>r", function()
  vim.cmd("w") -- Auto-save first
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local output = vim.fn.expand("%:r")

  if ft == "c" then
    Snacks.terminal("clang -Wall -O2 " .. file .. " -o " .. output .. " && ./" .. output .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "cpp" then
    Snacks.terminal("clang++ -Wall -O2 -std=c++20 " .. file .. " -o " .. output .. " && ./" .. output .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "java" then
    Snacks.terminal("javac " .. file .. " && java " .. output .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "python" then
    Snacks.terminal("python3 " .. file .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "javascript" then
    Snacks.terminal("node " .. file .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "typescript" then
    Snacks.terminal("npx tsx " .. file .. "; echo '\n--- Finished (Press Enter) ---'; read")
  elseif ft == "sh" or ft == "bash" then
    Snacks.terminal("bash " .. file .. "; echo '\n--- Finished (Press Enter) ---'; read")
  else
    vim.notify("⚠️ No run command defined for filetype: " .. ft, vim.log.levels.WARN)
  end
end, { desc = "Compile & Run current file" })
