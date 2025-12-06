------------------------------------------------------------------------------
-- カラースキーム: Tokyo Night
------------------------------------------------------------------------------

return {
  "folke/tokyonight.nvim",
  lazy = false,    -- 起動時に即座にロード
  priority = 1000, -- 他のプラグインより先にロード
  config = function()
    require("tokyonight").setup({
      style = "night",        -- night, storm, day, moon
      transparent = false,    -- 背景透過
      terminal_colors = true, -- ターミナルカラーを設定

      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },

      -- サイドバー（NvimTreeなど）のスタイル
      sidebars = { "qf", "help", "terminal" },

      -- 日付変更で自動切り替え（オプション）
      day_brightness = 0.3,

      -- カスタムハイライト
      on_highlights = function(hl, c)
        -- カーソル行のハイライトを少し明るく
        hl.CursorLine = { bg = c.bg_highlight }
        -- 検索ハイライトを目立たせる
        hl.Search = { bg = c.yellow, fg = c.black }
        hl.IncSearch = { bg = c.orange, fg = c.black }
      end,
    })

    -- カラースキームを適用
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
