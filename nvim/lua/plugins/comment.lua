------------------------------------------------------------------------------
-- Comment.nvim: コメントトグル
------------------------------------------------------------------------------
-- gc{motion} でコメント/アンコメント

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    -- JSX/TSXでのコメント対応
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- ts-context-commentstringの設定
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    require("Comment").setup({
      -- Treesitterと連携してファイルタイプに応じたコメント
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}

-- 使い方:
-- gcc          - 現在行をコメントトグル
-- gc{motion}   - motion範囲をコメントトグル
--   例: gcip   - 段落をコメント
--   例: gc5j   - 5行下までコメント
-- gbc          - 現在行をブロックコメント
-- gb{motion}   - motion範囲をブロックコメント
--
-- ビジュアルモード:
--   gc         - 選択範囲をコメントトグル
--   gb         - 選択範囲をブロックコメント
