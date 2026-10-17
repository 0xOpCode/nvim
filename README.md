# ByteC Studio v2.0 - Pocket C & C++ IDE

High-contrast OLED modular Neovim configuration tuned for fast mobile startup, Termux clipboard integration, and VS Code keyboard ergonomics.

---

## Architecture & Highlights

- **Package Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim) with lazy-loading, lockfile reproducibility, and disabled legacy vim plugins.
- **Theme**: High-contrast OLED transparent [Cyberdream](https://github.com/scottmckendry/cyberdream.nvim) (`#000000` background).
- **Statusline Mode Guidance**: [Lualine](https://github.com/nvim-lualine/lualine.nvim) displays explicit mode prompts (`NORMAL (Press i to type)`, `INSERT (Typing)`, `VISUAL (Selected)`).
- **Termux & Selection Ergonomics**:
  - Shift+Arrow selection enabled via `keymodel = "startsel,stopsel"` and `selectmode = "mouse,key"`.
  - Automatic Termux clipboard provider configuration when `termux-clipboard-set` and `termux-clipboard-get` exist in `PATH` or `/data/data/com.termux/files/usr/bin/`.
- **Workspace Hub**: [Snacks.nvim](https://github.com/folke/snacks.nvim) providing:
  - ByteC Studio v2.0 dashboard (`n` New File, `f` Find File, `r` Recent Files, `t` Open Terminal, `c` Config, `q` Quit)
  - Fuzzy Picker (Files, Grep, Buffer Lines, Buffers, Recent, Git)
  - File Explorer (`<leader>e`)
  - Floating Terminal (`<leader>tt`, `<C-\>`, `<C-j>`)
  - Filtered Notification System (`<leader>nh`, `<leader>nd`)
- **Completion Engine**: [Blink.cmp](https://github.com/saghen/blink.cmp) with fuzzy matching, auto-brackets, and documentation floats.
- **LSP & Formatting**:
  - [Mason.nvim](https://github.com/williamboman/mason.nvim) and [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
  - Neovim 0.11+ `vim.lsp.config` and `vim.lsp.enable` support with fallback to `lspconfig` on Neovim 0.10 for `clangd`, `pyright`, `bashls`, and `lua_ls`.
  - [Conform.nvim](https://github.com/stevearc/conform.nvim) format-on-save with Allman brace style enforced for C and C++ via `clang-format`.
- **Syntax**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) configured with a 10-parser mobile set (`bash`, `c`, `cpp`, `json`, `lua`, `markdown`, `markdown_inline`, `python`, `vim`, `vimdoc`) and [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim).
- **Compiler & Crash Runner**: `<leader>r` and `<F5>` format and save the active buffer, record the path in `~/.bytec/.last_file`, compile C/C++ binaries into `${TMPDIR:-/tmp}/bytec_nvim_bin`, invoke `explain` on compiler errors, report exit codes `139` (segmentation fault) and `136` (floating point exception), and read from `/dev/tty` before closing.

---

## Keymaps (`<leader>` = `Space`)

### VS Code Shortcuts
| Key | Mode | Action |
| --- | --- | --- |
| `<C-s>` / `<leader>w` | `n`, `i`, `v` | Save and format buffer |
| `<C-z>` | `n`, `i`, `v` | Undo |
| `<C-y>` / `<C-S-z>` | `n`, `i`, `v` | Redo |
| `<C-c>` | `x` | Copy selection to system clipboard |
| `<C-c>` | `n`, `i` | Copy current line to system clipboard |
| `<C-x>` | `x` | Cut selection to system clipboard |
| `<C-x>` | `n` | Cut current line to system clipboard |
| `<C-v>` | `n`, `i`, `x` | Paste from system clipboard |
| `<A-v>` | `n` | Enter Visual Block mode |
| `<C-a>` | `n`, `i`, `v` | Select entire buffer |
| `<A-a>` | `n` | Increment number under cursor |
| `<C-/>` / `<C-_>` | `n`, `i`, `v` | Toggle comment on line or selection |
| `<C-f>` | `n`, `i` | Search in current buffer |
| `<C-d>` | `n`, `i` | Select word under cursor |
| `<C-d>` | `x` | Select next occurrence of visual selection |
| `(`, `[`, `{`, `"`, `'`, `` ` `` | `x` | Wrap characterwise or linewise selection |
| `<C-Enter>` / `<A-o>` / `<leader>o` | `n`, `i`, `v` | Insert new line below |
| `<C-S-Enter>` / `<A-O>` / `<leader>O` | `n`, `i`, `v` | Insert new line above |
| `<C-j>` / `<C-\>` / `<leader>tt` | `n`, `i`, `t` | Toggle floating terminal |

### Files, Buffers & Explorer
| Key | Action |
| --- | --- |
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files (Snacks picker) |
| `<leader>fg` | Live grep text search |
| `<leader>fb` | Find open buffer |
| `<leader>fr` | Recent files |
| `<S-l>` / `<S-h>` | Next / Previous buffer tab |
| `<leader>bd` | Close current buffer |
| `<leader>ba` | Close all other buffers |

### Windows & Splits
| Key | Action |
| --- | --- |
| `<C-h>` / `<C-k>` / `<C-l>` | Move to left / upper / right split |
| `<leader>sv` | Split window side by side |
| `<leader>sh` | Split window stacked |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split |
| `<C-Up>` / `<C-Down>` | Resize window height |
| `<C-Left>` / `<C-Right>` | Resize window width |

### Code, LSP & Execution
| Key | Action |
| --- | --- |
| `<leader>r` / `<F5>` | Format, save, compile, and run current file |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol across project |
| `<leader>cf` | Format current buffer (Conform) |
| `<leader>cd` | Show line diagnostics float |
| `<leader>ch` | Switch between C/C++ header and source |
| `<leader>ci` | Toggle LSP inlay hints |
| `[d` / `]d` | Previous / Next diagnostic |
| `<leader>nc` | Copy all notifications and messages to clipboard |

### Git & Terminal
| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit floating window |
| `<leader>gf` | Find git files |
| `<leader>gb` | Git blame current line |
| `<leader>tt` / `<C-\>` / `<C-j>` | Toggle floating terminal |

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                # Entry point and notification filters
├── lazy-lock.json          # Pinned plugin lockfile
└── lua/
    ├── config/
    │   ├── keymaps.lua     # VS Code bindings, clipboard actions, and runner
    │   ├── lazy.lua        # Lazy.nvim bootstrap
    │   └── options.lua     # Editor options, Shift+Arrow selection, Termux clipboard
    └── plugins/
        ├── completion.lua  # Blink.cmp completion and snippets
        ├── git.lua         # Gitsigns configuration
        ├── lsp.lua         # Mason, LSP 0.10/0.11 setup, and Conform Allman formatter
        ├── mini.lua        # Mini.pairs, comments, surround
        ├── snacks.lua      # Snacks dashboard, picker, explorer, terminal
        ├── treesitter.lua  # Treesitter syntax highlighting and rainbow delimiters
        └── ui.lua          # Cyberdream theme, Bufferline, Lualine mode prompts, Which-key
```
