-- ============================================================================
-- WezTerm設定ファイル
-- ============================================================================

-- WezTermのモジュールを読み込み
local wezterm = require 'wezterm'

-- 設定ビルダーを初期化
local config = wezterm.config_builder()

-- ============================================================================
-- 基本設定
-- ============================================================================

-- 設定ファイルの自動リロードを有効化
config.automatically_reload_config = true

-- WezTermの更新チェックを有効化
config.check_for_updates = true
-- 更新チェックの間隔を86400秒(24時間)に設定
config.check_for_updates_interval_seconds = 86400

-- デフォルトの作業ディレクトリをホームディレクトリに設定
config.default_cwd = wezterm.home_dir

-- URLをクリック可能に設定
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- ============================================================================
-- フォント設定
-- ============================================================================

-- フォントファミリーの指定(JetBrains Mono, Fira Code等)
config.font = wezterm.font_with_fallback {
    'JetBrains Mono',
    'Menlo',
    'Hiragino Sans',  -- 日本語フォント
}

-- フォントサイズを12ptに設定
config.font_size = 12.0

-- リガチャ(合字)を有効化
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- 日本語入力メソッド(IME)を有効化
config.use_ime = true

-- ============================================================================
-- 外観・カラー設定
-- ============================================================================

-- カラースキームを"Dracula+"に設定
config.color_scheme = "Dracula+"

-- ウィンドウ背景の透明度を75%に設定(0.0=完全透明, 1.0=不透明)
config.window_background_opacity = 0.75

-- macOSのウィンドウ背景ブラー効果を無効化(0=なし)
config.macos_window_background_blur = 0

-- ウィンドウ背景のグラデーション設定
config.window_background_gradient = {
  -- 黒色(#000000)を使用
  colors = { "#000000" }
}

-- カラー設定
config.colors = {
  tab_bar = {
    -- 非アクティブなタブのエッジを非表示
    inactive_tab_edge = "none",
  },
}

-- ウィンドウフレームの設定
config.window_frame = {
  -- 非アクティブ時のタイトルバー背景を透明に
  inactive_titlebar_bg = "none",
  -- アクティブ時のタイトルバー背景を透明に
  active_titlebar_bg = "none",
}

-- ウィンドウ装飾の設定(コメントアウト中)
-- config.window_decorations = "RESIZE"

-- ============================================================================
-- ウィンドウサイズ・レイアウト設定
-- ============================================================================

-- 初期ウィンドウサイズ
config.initial_cols = 100  -- 初期ウィンドウの横幅(カラム数)
config.initial_rows = 40   -- 初期ウィンドウの高さ(行数)

-- ウィンドウのパディング(余白)設定
config.window_padding = {
    left = 10,    -- 左側の余白(ピクセル)
    right = 10,   -- 右側の余白(ピクセル)
    top = 10,     -- 上側の余白(ピクセル)
    bottom = 10,  -- 下側の余白(ピクセル)
}

-- ============================================================================
-- タブバー設定
-- ============================================================================

-- タブバーにタブを表示
config.show_tabs_in_tab_bar = true

-- タブが1つだけの場合はタブバーを非表示
config.hide_tab_bar_if_only_one_tab = true

-- タブバーの新規タブボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- ============================================================================
-- スクロール設定
-- ============================================================================

-- タブごとに保持するスクロールバック行数(100000行)
config.scrollback_lines = 100000

-- スクロールバーを表示
config.enable_scroll_bar = true

-- ============================================================================
-- パフォーマンス設定
-- ============================================================================

-- GPUアクセラレーションを有効化(パフォーマンス向上)
config.front_end = "WebGpu"

-- アニメーションのフレームレート
config.animation_fps = 60

-- 最大フレームレート
config.max_fps = 60

-- ============================================================================
-- キーバインド設定
-- ============================================================================

config.keys = {
    -- ------------------------------------------------------------------------
    -- タブ操作
    -- ------------------------------------------------------------------------
    { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },  -- Cmd+t: 新しいタブを開く
    { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab{ confirm = true } },  -- Cmd+w: 現在のタブを閉じる(確認あり)

    -- ------------------------------------------------------------------------
    -- タブの移動
    -- ------------------------------------------------------------------------
    { key = '[', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },  -- Cmd+Shift+[: 前のタブに移動
    { key = ']', mods = 'CMD|SHIFT', action = wezterm.action.ActivateTabRelative(1) },   -- Cmd+Shift+]: 次のタブに移動
    { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },  -- Cmd+1: 1番目のタブに移動
    { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },  -- Cmd+2: 2番目のタブに移動
    { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },  -- Cmd+3: 3番目のタブに移動
    { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },  -- Cmd+4: 4番目のタブに移動
    { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },  -- Cmd+5: 5番目のタブに移動
    { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },  -- Cmd+6: 6番目のタブに移動
    { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },  -- Cmd+7: 7番目のタブに移動
    { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },  -- Cmd+8: 8番目のタブに移動
    { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(-1) }, -- Cmd+9: 最後のタブに移動

    -- ------------------------------------------------------------------------
    -- ペイン分割
    -- ------------------------------------------------------------------------
    { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal{ domain = 'CurrentPaneDomain' } },  -- Cmd+d: 水平分割
    { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical{ domain = 'CurrentPaneDomain' } },  -- Cmd+Shift+d: 垂直分割

    -- ------------------------------------------------------------------------
    -- ペインの移動
    -- ------------------------------------------------------------------------
    { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },   -- Cmd+Shift+h: 左のペインに移動
    { key = 'j', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },   -- Cmd+Shift+j: 下のペインに移動
    { key = 'k', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },     -- Cmd+Shift+k: 上のペインに移動
    { key = 'l', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },  -- Cmd+Shift+l: 右のペインに移動

    -- ------------------------------------------------------------------------
    -- ペインのサイズ調整
    -- ------------------------------------------------------------------------
    { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Left', 5 } },   -- Cmd+Shift+←: ペインを左に拡大
    { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Right', 5 } }, -- Cmd+Shift+→: ペインを右に拡大
    { key = 'UpArrow', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Up', 5 } },       -- Cmd+Shift+↑: ペインを上に拡大
    { key = 'DownArrow', mods = 'CMD|SHIFT', action = wezterm.action.AdjustPaneSize{ 'Down', 5 } },   -- Cmd+Shift+↓: ペインを下に拡大

    -- ------------------------------------------------------------------------
    -- ペインを閉じる
    -- ------------------------------------------------------------------------
    { key = 'w', mods = 'CMD|SHIFT', action = wezterm.action.CloseCurrentPane{ confirm = true } },  -- Cmd+Shift+w: 現在のペインを閉じる(確認あり)
}

-- ============================================================================
-- イベントハンドラー
-- ============================================================================

-- 設定ファイルがリロードされた時にログに通知を記録
wezterm.on('window-config-reloaded', function(window, pane)
    wezterm.log_info 'the config was reloaded for this window!'
end)

-- タブタイトルのフォーマット設定
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- デフォルトの背景色(グレー系)
  local background = "#5c6d74"
  -- デフォルトの前景色(白)
  local foreground = "#FFFFFF"

  -- アクティブなタブの場合
  if tab.is_active then
    -- 背景色をゴールド系に変更
    background = "#ae8b2d"
    -- 前景色は白のまま
    foreground = "#FFFFFF"
  end

  -- タブタイトルを作成(両端に3つのスペースを追加し、最大幅で切り詰め)
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

  -- タイトルの表示スタイルを返す
  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- ============================================================================
-- 設定を返す
-- ============================================================================

return config
