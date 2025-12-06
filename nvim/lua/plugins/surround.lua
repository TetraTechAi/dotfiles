------------------------------------------------------------------------------
-- nvim-surround: 囲み文字の操作
------------------------------------------------------------------------------
-- 括弧、クォート、HTMLタグなどで囲む・変更・削除

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- デフォルト設定を使用
    })
  end,
}

-- 使い方:
-- ys{motion}{char}  - 囲みを追加
--   例: ysiw"       - 単語を"で囲む
--   例: yss)        - 行全体を()で囲む
--   例: ysiw<div>   - 単語を<div></div>で囲む
--
-- ds{char}          - 囲みを削除
--   例: ds"         - "を削除
--   例: dst         - HTMLタグを削除
--
-- cs{old}{new}      - 囲みを変更
--   例: cs"'        - "を'に変更
--   例: cs)]        - ()を[]に変更
--   例: cst<span>   - HTMLタグを<span>に変更
--
-- ビジュアルモード:
--   S{char}         - 選択範囲を囲む
