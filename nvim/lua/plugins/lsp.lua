------------------------------------------------------------------------------
-- LSP: Language Server Protocol設定
------------------------------------------------------------------------------

return {
  -- LSPConfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: LSPサーバー管理
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      -- Mason setup
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })

      -- 自動インストールするLSPサーバー
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',           -- Lua
          'ts_ls',            -- TypeScript/JavaScript
          'pyright',          -- Python
          'gopls',            -- Go
          'rust_analyzer',    -- Rust
          'html',             -- HTML
          'cssls',            -- CSS
          'jsonls',           -- JSON
          'yamlls',           -- YAML
        },
        automatic_installation = true,
      })

      -- LSP設定
      local lspconfig = require('lspconfig')
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- デフォルトのLSP設定
      local default_setup = function(server)
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- 個別のLSP設定
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- その他のサーバーはデフォルト設定
      for _, server in ipairs({ 'gopls', 'rust_analyzer', 'html', 'cssls', 'jsonls', 'yamlls' }) do
        default_setup(server)
      end

      -- 診断表示設定
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          source = 'if_many',
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = 'always',
          border = 'rounded',
        },
      })

      -- 診断サイン設定
      local signs = {
        Error = '✘',
        Warn = '▲',
        Hint = '⚑',
        Info = '»',
      }

      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSPアタッチ時の設定
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
        callback = function(event)
          -- ホバー情報をフロートウィンドウで表示
          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
          )
        end,
      })
    end,
  },
}
