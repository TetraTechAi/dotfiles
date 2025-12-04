-- ============================================================================
-- yazi.nvim - ターミナルファイルマネージャー統合
-- ============================================================================

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>y", "<cmd>Yazi<cr>", desc = "Yazi: カレントファイル" },
    { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Yazi: カレントディレクトリ" },
    { "<leader>fy", "<cmd>Yazi toggle<cr>", desc = "Yazi: トグル（前回の状態を復元）" },
  },
  opts = {
    -- ディレクトリを開いた時にyaziを使用
    open_for_directories = true,

    -- yaziのフローティングウィンドウ設定
    floating_window_scaling_factor = 0.9,

    -- yaziが閉じた後にフォーカスを戻すウィンドウ
    yazi_floating_window_border = "rounded",
  },
}
