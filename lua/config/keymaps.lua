-- ==============================================================================
-- 🎮 CORE KEYMAPS & SHORTCUTS (LEADER: SPACE)
-- ==============================================================================

local map = vim.keymap.set

-- Set Leader Key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. General Helpers & VS Code Ergonomics
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save and format file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save and format file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- VS Code Undo / Redo (Ctrl+Z, Ctrl+Y, Ctrl+Shift+Z)
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("v", "<C-z>", "<Esc>u", { desc = "Undo" })

map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
map("v", "<C-y>", "<Esc><C-r>", { desc = "Redo" })

map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })
map("v", "<C-S-z>", "<Esc><C-r>", { desc = "Redo" })

-- VS Code New Line Below (Ctrl+Enter) & Above (Ctrl+Shift+Enter)
map({ "n", "v" }, "<C-CR>", "o", { desc = "Insert line below" })
map("i", "<C-CR>", "<C-o>o", { desc = "Insert line below" })
map({ "n", "v" }, "<C-Enter>", "o", { desc = "Insert line below" })
map("i", "<C-Enter>", "<C-o>o", { desc = "Insert line below" })

map({ "n", "v" }, "<C-S-CR>", "O", { desc = "Insert line above" })
map("i", "<C-S-CR>", "<C-o>O", { desc = "Insert line above" })
map({ "n", "v" }, "<C-S-Enter>", "O", { desc = "Insert line above" })
map("i", "<C-S-Enter>", "<C-o>O", { desc = "Insert line above" })

-- VS Code Ctrl+D (Select word under cursor in Normal, Insert, and Visual modes)
map("n", "<C-d>", "viw", { desc = "Select word under cursor" })
map("i", "<C-d>", "<Esc>viw", { desc = "Select word under cursor" })
map("x", "<C-d>", [["yy/<C-r>y<CR>gn]], { desc = "Select next occurrence" })

-- Visual mode Auto-Surround (Wrap selection in brackets or quotes - VS Code style)
local function visual_wrap(open_char, close_char)
  return function()
    local s = vim.fn.getreg("s")
    local st = vim.fn.getregtype("s")
    vim.cmd('normal! "sd')
    local sel = vim.fn.getreg("s")
    vim.api.nvim_paste(open_char .. sel .. close_char, false, -1)
    vim.fn.setreg("s", s, st)
  end
end

for _, pair in ipairs({
  { "(", ")" },
  { "[", "]" },
  { "{", "}" },
  { '"', '"' },
  { "'", "'" },
  { "`", "`" },
}) do
  local open_c, close_c = pair[1], pair[2]
  map("x", open_c, visual_wrap(open_c, close_c), { desc = "Wrap selection in " .. open_c .. close_c })
  if open_c ~= close_c then
    map("x", close_c, visual_wrap(open_c, close_c), { desc = "Wrap selection in " .. open_c .. close_c })
  end
end

-- 2. Buffer Controls & Switching
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer Tab" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer Tab" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close Current Buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })

-- 3. Terminal Toggle (VS Code Ctrl+~ / Ctrl+` / Ctrl+J hide/unhide)
map({ "n", "t", "i" }, "<C-`>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<C-~>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<C-j>", function() Snacks.terminal() end, { desc = "Toggle Terminal (VS Code Ctrl+J)" })

-- Window Split Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
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
  -- 1. Format and Auto-save before compile & run
  if vim.bo.modified or vim.fn.empty(vim.fn.expand("%")) == 0 then
    pcall(function()
      require("conform").format({ async = false, lsp_fallback = true })
    end)
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
      position = "float",
      width = 0.98,
      height = 0.98,
      border = "rounded",
      title = " 🚀 Run: " .. filename .. " ",
      title_pos = "center",
    },
    interactive = true,
  })
end, { desc = "Save, Compile & Run current file" })
