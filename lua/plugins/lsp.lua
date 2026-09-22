-- ==============================================================================
-- 💡 LANGUAGE SERVER PROTOCOL (LSP), MASON & AUTO-FORMATTING
-- ==============================================================================

return {
  -- 1. Mason (LSP, Linter & Formatter Manager)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- 2. Mason LSP Bridge (v1.31.0 - Neovim 0.10.x compatible)
  {
    "williamboman/mason-lspconfig.nvim",
    tag = "v1.31.0",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },

  -- 3. Core LSP Configuration & Keymaps
  {
    "neovim/nvim-lspconfig",
    tag = "v2.5.0",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Global diagnostic borders and icons
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Keymaps via LspAttach (clean modern style, works on 0.10+)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gD", vim.lsp.buf.declaration, "Go to Declaration")
          map("gr", vim.lsp.buf.references, "Find References")
          map("gi", vim.lsp.buf.implementation, "Go to Implementation")
          map("K", function()
            pcall(vim.lsp.buf.hover)
          end, "Hover Documentation")
          map("<leader>cr", vim.lsp.buf.rename, "Code Rename Across Project")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>cs", vim.lsp.buf.signature_help, "Signature Help")
        end,
      })

      -- Suppress transient -32602 (AST not ready) error handlers
      local orig_highlight = vim.lsp.handlers["textDocument/documentHighlight"]
      vim.lsp.handlers["textDocument/documentHighlight"] = function(err, result, ctx, config)
        if err and err.code == -32602 then
          return
        end
        if orig_highlight then
          return orig_highlight(err, result, ctx, config)
        end
      end

      -- Clangd capabilities with utf-16 offset encoding
      local clangd_capabilities = vim.tbl_deep_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
      })

      -- Core active servers configured directly for reliable startup
      local servers = {
        clangd = {
          capabilities = clangd_capabilities,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
        },
        bashls = {
          capabilities = capabilities,
        },
        pyright = {
          capabilities = capabilities,
        },
        lua_ls = {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim", "Snacks" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for server, opts in pairs(servers) do
        lspconfig[server].setup(opts)
      end
    end,
  },

  -- 4. Fast Auto-Formatting on Save (Conform.nvim)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format Current Buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}
