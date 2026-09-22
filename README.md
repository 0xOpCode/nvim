# 🛡️ Daemon OS — Modern Modular Neovim IDE (2026 Meta Stack)

High-performance, pure OLED high-contrast, modular Neovim setup tuned for instant startup, zero bloat, and modern developer ergonomics.

---

## ⚡ Architecture & Highlights

- **Package Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim) with lazy-loading, rock-solid lockfile reproducibility, and disabled legacy vim plugins.
- **Theme**: High-contrast OLED transparent [Cyberdream](https://github.com/scottmckendry/cyberdream.nvim) (`#000000` deep black).
- **Modern Hub**: [Snacks.nvim](https://github.com/folke/snacks.nvim) providing:
  - Custom ASCII Daemon OS dashboard
  - Ultra-fast Fuzzy Picker (Files, Grep, Buffers, Recent, Git)
  - Integrated File Explorer
  - Scratch Floating Terminal (`<leader>tt` / `<C-\>`)
  - Filtered Notification System (`<leader>nh` / `<leader>nd`)
- **Completion Engine**: Next-generation [Blink.cmp](https://github.com/saghen/blink.cmp) with fuzzy matching, auto-brackets, and documentation floats.
- **LSP & Tooling**:
  - [Mason.nvim](https://github.com/williamboman/mason.nvim) & [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
  - Native LSP Config for `clangd` (C/C++ with background index & UTF-16 fix), `pyright` (Python), `bashls` (Bash/Zsh), and `lua_ls` (Lua).
  - Transient clangd AST error (-32602) noise suppression.
  - [Conform.nvim](https://github.com/stevearc/conform.nvim) format-on-save (`stylua`, `clang-format`, `ruff`, `prettier`, `shfmt`).
- **Syntax**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) with high-speed syntax trees and [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim).
- **Git Integration**: [Gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) with gutter indicators, blame lines, hunk previews, and one-key [LazyGit](https://github.com/jesseduffield/lazygit) float via Snacks.
- **Mini Ergonomics**: [Mini.nvim](https://github.com/echasnovski/mini.nvim) suite (`mini.pairs`, `mini.comment`, `mini.surround`, `mini.icons`).

---

## ⌨️ Essential Keymaps (`<leader>` = `Space`)

### 📁 Files, Buffers & Explorer
| Key | Action |
| --- | --- |
| `<leader>e` | Toggle File Explorer |
| `<leader>ff` | Find files (Snacks picker) |
| `<leader>fg` | Live grep / text search |
| `<leader>fb` | Find open buffer |
| `<leader>fr` | Recent files |
| `<S-l>` / `<S-h>` | Next / Previous buffer tab |
| `<leader>bd` | Close current buffer |
| `<leader>ba` | Close all other buffers |

### 🪟 Windows & Splits
| Key | Action |
| --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move left / down / up / right split |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split |
| `<C-Up>` / `<C-Down>` | Resize window height |
| `<C-Left>` / `<C-Right>` | Resize window width |

### 💡 Code, LSP & Execution
| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol across project |
| `<leader>cf` | Format current file (Conform) |
| `<leader>cd` | Show line diagnostics float |
| `[d` / `]d` | Previous / Next diagnostic |
| `<leader>r` | **Compile & Run current file** (C, C++, Python, JS/TS, Bash) |
| `<leader>nc` | **Copy all notifications & messages** to clipboard |

### 🐙 Git & Terminal
| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit popup |
| `<leader>gb` | Git blame line |
| `<leader>gp` | Preview git hunk |
| `[h` / `]h` | Previous / Next git hunk |
| `<leader>tt` / `<C-\>` | Toggle Floating Terminal |

---

## 📂 Directory Structure

```
~/.config/nvim/
├── init.lua                # Core entry point & deprecation guards
├── lazy-lock.json          # Pinned plugin lockfile
└── lua/
    ├── config/
    │   ├── keymaps.lua     # Leader bindings & utility workflows
    │   ├── lazy.lua        # Lazy.nvim setup & UI configs
    │   └── options.lua     # Neovim options (OLED settings, tabs, splits)
    └── plugins/
        ├── completion.lua  # Blink.cmp completion & snippets
        ├── git.lua         # Gitsigns setup
        ├── lsp.lua         # Mason, LSP servers & Conform formatter
        ├── mini.lua        # Mini.pairs, comments, surround
        ├── snacks.lua      # Snacks picker, explorer, dashboard, terminal
        ├── treesitter.lua  # Treesitter syntax highlighting & rainbow
        └── ui.lua          # Cyberdream theme, Bufferline, Lualine, Which-key
```
