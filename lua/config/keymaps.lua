-- ==============================================================================
-- CORE KEYMAPS & SHORTCUTS (LEADER: SPACE)
-- ==============================================================================

local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1. General Helpers & VS Code Shortcuts
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save and format buffer" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save and format buffer" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Undo / Redo (Ctrl+Z, Ctrl+Y, Ctrl+Shift+Z)
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("v", "<C-z>", "<Esc>u", { desc = "Undo" })

map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
map("v", "<C-y>", "<Esc><C-r>", { desc = "Redo" })

map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })
map("v", "<C-S-z>", "<Esc><C-r>", { desc = "Redo" })

-- System Clipboard Copy / Cut / Paste (Ctrl+C, Ctrl+X, Ctrl+V)
map("x", "<C-c>", function()
  vim.cmd('normal! "+y')
  vim.notify("Copied selection to clipboard", vim.log.levels.INFO)
end, { desc = "Copy selection to clipboard" })

map({ "n", "i" }, "<C-c>", function()
  vim.cmd('normal! "+yy')
  vim.notify("Copied line to clipboard", vim.log.levels.INFO)
end, { desc = "Copy line to clipboard" })

map("x", "<C-x>", '"+d', { desc = "Cut selection to clipboard" })
map("n", "<C-x>", '"+dd', { desc = "Cut line to clipboard" })

map("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })
map("x", "<C-v>", '"+d"+P', { desc = "Paste over selection from clipboard" })
map("n", "<A-v>", "<C-v>", { desc = "Visual Block mode" })

-- Select All (Ctrl+A) and Number Increment (Alt+A)
map({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select entire buffer" })
map("n", "<A-a>", "<C-a>", { desc = "Increment number" })

-- Toggle Comment (Ctrl+/ and Ctrl+_)
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle line comment" })
map("i", "<C-/>", "<C-o>gcc", { remap = true, desc = "Toggle line comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle selection comment" })
map("n", "<C-_>", "gcc", { remap = true, desc = "Toggle line comment" })
map("i", "<C-_>", "<C-o>gcc", { remap = true, desc = "Toggle line comment" })
map("v", "<C-_>", "gc", { remap = true, desc = "Toggle selection comment" })

-- Search in Current Buffer (Ctrl+F)
map("n", "<C-f>", function()
  if _G.Snacks and Snacks.picker and Snacks.picker.lines then
    Snacks.picker.lines()
  else
    vim.api.nvim_feedkeys("/", "n", false)
  end
end, { desc = "Search in current buffer" })

map("i", "<C-f>", function()
  vim.cmd("stopinsert")
  if _G.Snacks and Snacks.picker and Snacks.picker.lines then
    Snacks.picker.lines()
  else
    vim.api.nvim_feedkeys("/", "n", false)
  end
end, { desc = "Search in current buffer" })

-- New Line Below (Ctrl+Enter, Alt+o, Space+o) & Above (Ctrl+Shift+Enter, Alt+O, Space+O)
map({ "n", "v" }, "<C-CR>", "o", { desc = "Insert line below" })
map("i", "<C-CR>", "<C-o>o", { desc = "Insert line below" })
map({ "n", "v" }, "<C-Enter>", "o", { desc = "Insert line below" })
map("i", "<C-Enter>", "<C-o>o", { desc = "Insert line below" })
map({ "n", "v" }, "<A-o>", "o", { desc = "Insert line below" })
map("i", "<A-o>", "<C-o>o", { desc = "Insert line below" })
map("n", "<leader>o", "o", { desc = "Insert line below" })

map({ "n", "v" }, "<C-S-CR>", "O", { desc = "Insert line above" })
map("i", "<C-S-CR>", "<C-o>O", { desc = "Insert line above" })
map({ "n", "v" }, "<C-S-Enter>", "O", { desc = "Insert line above" })
map("i", "<C-S-Enter>", "<C-o>O", { desc = "Insert line above" })
map({ "n", "v" }, "<A-O>", "O", { desc = "Insert line above" })
map("i", "<A-O>", "<C-o>O", { desc = "Insert line above" })
map("n", "<leader>O", "O", { desc = "Insert line above" })

-- Word Selection & Next Occurrence (Ctrl+D)
map("n", "<C-d>", "viw", { desc = "Select word under cursor" })
map("i", "<C-d>", "<C-o>viw", { desc = "Select word under cursor" })
map("x", "<C-d>", function()
  local save_s = vim.fn.getreg("s")
  local save_st = vim.fn.getregtype("s")
  vim.cmd('normal! "sy')
  local text = vim.fn.getreg("s")
  vim.fn.setreg("s", save_s, save_st)
  local escaped = vim.fn.escape(text, [[/\]]):gsub("\n", [[\n]])
  local keys = vim.api.nvim_replace_termcodes("/\\V" .. escaped .. "<CR>gn", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Select next occurrence" })

-- Visual Auto-Surround (Characterwise and Linewise)
local function visual_wrap(open_char, close_char)
  return function()
    local s = vim.fn.getreg("s")
    local st = vim.fn.getregtype("s")
    local u = vim.fn.getreg('"')
    local ut = vim.fn.getregtype('"')
    local mode = vim.fn.mode()
    vim.cmd('normal! "sy')
    local sel = vim.fn.getreg("s")
    if mode == "V" then
      sel = sel:gsub("\n$", "")
      local lines = vim.split(open_char .. sel .. close_char, "\n", { plain = true })
      local start_line = vim.fn.line("'<") - 1
      local end_line = vim.fn.line("'>")
      vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
    else
      vim.fn.setreg("s", open_char .. sel .. close_char, "c")
      vim.cmd('normal! gv"sp')
    end
    vim.fn.setreg("s", s, st)
    vim.fn.setreg('"', u, ut)
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

-- 3. Terminal Toggle (Ctrl+~, Ctrl+`, Ctrl+J, Ctrl+\, Space+tt)
map({ "n", "t", "i" }, "<C-`>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<C-~>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<C-j>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<C-\\>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map({ "n", "t", "i" }, "<leader>tt", function() Snacks.terminal() end, { desc = "Toggle Terminal" })

-- Window Split Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- 4. Window Split Creation
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window side by side" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window stacked" })
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

-- 7. Indentation in Visual Mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- 8. Diagnostics Float
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics Float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- 9. Copy All Logs / Notifications to System Clipboard
map("n", "<leader>nc", function()
  local lines = {}
  if _G.Snacks and Snacks.notifier and Snacks.notifier.get_history then
    for _, notif in ipairs(Snacks.notifier.get_history()) do
      local title = notif.title and ("[" .. notif.title .. "] ") or ""
      local msg = notif.msg or ""
      if msg ~= "" then
        table.insert(lines, title .. msg)
      end
    end
  end
  local msgs = vim.fn.execute("messages")
  if msgs and msgs ~= "" and msgs ~= "\n" then
    table.insert(lines, "\n--- Standard Messages ---")
    table.insert(lines, msgs)
  end

  local final_text = table.concat(lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
  if final_text == "" then
    vim.notify("No recent messages or logs found.", vim.log.levels.INFO)
    return
  end
  vim.fn.setreg("+", final_text)
  vim.fn.setreg('"', final_text)
  vim.notify("Copied " .. #lines .. " log entries to clipboard.", vim.log.levels.INFO)
end, { desc = "Copy all logs and notifications to clipboard" })

-- 10. Compile & Run Current File (<leader>r and <F5>)
local runner_term = nil
local function compile_and_run()
  if vim.fn.mode() == "i" then
    vim.cmd("stopinsert")
  end

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
  local tmp_bin = (vim.env.TMPDIR or "/tmp") .. "/bytec_nvim_bin"

  if file == "" then
    vim.notify("Save file before running.", vim.log.levels.WARN)
    return
  end

  local state_dir = vim.fn.expand("~/.bytec")
  vim.fn.mkdir(state_dir, "p")
  pcall(vim.fn.writefile, { file }, state_dir .. "/.last_file")

  local compile_cmd = nil
  local exec_cmd = nil

  if ft == "c" then
    compile_cmd = string.format("clang -Wall -Wextra -O2 -g %q -o %q -lm", file, tmp_bin)
    exec_cmd = string.format("%q", tmp_bin)
  elseif ft == "cpp" then
    compile_cmd = string.format("clang++ -Wall -Wextra -O2 -g -std=c++20 %q -o %q", file, tmp_bin)
    exec_cmd = string.format("%q", tmp_bin)
  elseif ft == "rust" then
    compile_cmd = string.format("rustc %q -o %q", file, tmp_bin)
    exec_cmd = string.format("%q", tmp_bin)
  elseif ft == "java" then
    compile_cmd = string.format("javac %q", file)
    exec_cmd = string.format("java -cp %q %q", dir, vim.fn.expand("%:t:r"))
  elseif ft == "python" then
    exec_cmd = string.format("python3 %q", file)
  elseif ft == "javascript" then
    exec_cmd = string.format("node %q", file)
  elseif ft == "typescript" then
    exec_cmd = string.format("npx tsx %q", file)
  elseif ft == "sh" or ft == "bash" then
    exec_cmd = string.format("bash %q", file)
  else
    vim.notify("No run command defined for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  local full_cmd
  if compile_cmd then
    full_cmd = string.format(
      "cd %q && printf 'Compiling and running %s...\\n\\n' && if ! %s; then if command -v explain >/dev/null 2>&1; then explain %q; fi; printf '\\nPress Enter to return to editor...'; read -r _ </dev/tty; exit 1; fi; %s; code=$?; rm -f %q; if [ \"$code\" -eq 139 ]; then printf '\\n%s\\n'; elif [ \"$code\" -eq 136 ]; then printf '\\nCrash detected: Floating point exception (division by zero).\\n'; fi; printf '\\n════════════════════════════════════════\\nFinished with exit code %%s.\\nPress Enter to return to editor...' \"$code\"; read -r _ </dev/tty",
      dir,
      filename,
      compile_cmd,
      file,
      exec_cmd,
      tmp_bin,
      "Crash detected: Segmentation fault (invalid memory or pointer access). Run: explain " .. filename
    )
  else
    full_cmd = string.format(
      "cd %q && printf 'Running %s...\\n\\n' && %s; code=$?; printf '\\n═══════════════════════════════════════\\nFinished with exit code %%s.\\nPress Enter to return to editor...' \"$code\"; read -r _ </dev/tty",
      dir,
      filename,
      exec_cmd
    )
  end

  if runner_term and runner_term:buf_valid() then
    runner_term:close()
  end

  runner_term = Snacks.terminal.open(full_cmd, {
    win = {
      position = "float",
      width = 0.98,
      height = 0.98,
      border = "rounded",
      title = " Run: " .. filename .. " ",
      title_pos = "center",
    },
    interactive = true,
  })
end

map({ "n", "i" }, "<leader>r", compile_and_run, { desc = "Save, Compile & Run current file" })
map({ "n", "i" }, "<F5>", compile_and_run, { desc = "Save, Compile & Run current file" })
