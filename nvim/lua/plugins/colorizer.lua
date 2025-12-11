------------------------------------------------------------------------------
-- nvim-colorizer: 色コードのプレビュー表示
------------------------------------------------------------------------------
-- CSS/HTML等で色コード(red, #ff0000, rgb()等)の横に実際の色を表示

return {
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    opts = {
      filetypes = {
        "html",
        "css",
        "scss",
        "sass",
        "less",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
        "lua",
        "vim",
        "conf",
        "markdown",
      },
      user_default_options = {
        names = true,         -- "red", "blue" などの色名
        RGB = true,           -- #RGB 形式
        RRGGBB = true,        -- #RRGGBB 形式
        RRGGBBAA = true,      -- #RRGGBBAA 形式
        rgb_fn = true,        -- rgb(), rgba()
        hsl_fn = true,        -- hsl(), hsla()
        css = true,           -- CSS の色指定全般
        css_fn = true,        -- CSS関数 (rgb, hsl等)
        mode = "background",  -- "background" or "foreground" or "virtualtext"
        tailwind = true,      -- Tailwind CSS の色クラス
        virtualtext = "■",
      },
    },
  },

  ------------------------------------------------------------------------------
  -- ccc.nvim: カラーピッカー
  ------------------------------------------------------------------------------
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert", "CccHighlighterToggle" },
    keys = {
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
      { "<leader>cc", "<cmd>CccConvert<cr>", desc = "Convert color format" },
    },
    opts = {
      highlighter = {
        auto_enable = false,  -- colorizerと重複するので無効
      },
    },
  },
}
