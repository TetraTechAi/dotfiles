------------------------------------------------------------------------------
-- nvim-lint: 非同期リンター
------------------------------------------------------------------------------
-- LSP診断と併用して追加のリント機能を提供

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    -- 言語別リンター設定
    lint.linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      svelte = { 'eslint_d' },

      -- Python
      python = { 'ruff', 'mypy' },

      -- Go
      go = { 'golangcilint' },

      -- Lua
      lua = { 'luacheck' },

      -- PHP
      php = { 'phpcs' },

      -- シェル
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },

      -- Dockerfile
      dockerfile = { 'hadolint' },

      -- YAML
      yaml = { 'yamllint' },

      -- Markdown
      markdown = { 'markdownlint' },
    }

    -- 自動リント実行（autocmd）
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- 手動リント実行のキーマップ
    vim.keymap.set('n', '<leader>ll', function()
      lint.try_lint()
    end, { desc = 'リント実行' })

    -- リンターリストを表示するコマンド
    vim.api.nvim_create_user_command('LintInfo', function()
      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype] or {}
      if #linters == 0 then
        vim.notify('No linters configured for filetype: ' .. filetype, vim.log.levels.WARN)
      else
        vim.notify('Linters for ' .. filetype .. ': ' .. table.concat(linters, ', '), vim.log.levels.INFO)
      end
    end, { desc = '現在のファイルタイプのリンター表示' })
  end,
}

-- 使い方:
-- <leader>ll   - 手動リント実行
-- :LintInfo    - 現在のファイルタイプに設定されたリンター表示
--
-- 自動リント:
-- - ファイルを開いた時
-- - ファイル保存後
-- - インサートモード終了時
