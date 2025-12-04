-- ============================================================================
-- peek.nvim - Markdownプレビュー
-- ============================================================================
-- ライブプレビュー、同期スクロール、TeX数式、Mermaid図対応

return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  ft = { "markdown" },
  keys = {
    { "<leader>mp", function() require("peek").open() end, desc = "Markdown Preview: 開く" },
    { "<leader>mc", function() require("peek").close() end, desc = "Markdown Preview: 閉じる" },
  },
  config = function()
    require("peek").setup({
      auto_load = true,         -- Markdownファイルで自動ロード
      close_on_bdelete = true,  -- バッファ削除時にプレビューを閉じる
      syntax = true,            -- シンタックスハイライト
      theme = "dark",           -- テーマ（dark/light）
      app = "browser",          -- プレビュー先（browser/webview）
    })

    -- コマンド定義
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}
