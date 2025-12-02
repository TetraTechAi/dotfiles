------------------------------------------------------------------------------
-- Neovim 設定エントリーポイント
------------------------------------------------------------------------------

-- プロバイダー設定（使用しないプロバイダーを無効化）
vim.g.loaded_ruby_provider = 0   -- Ruby provider無効化
vim.g.loaded_perl_provider = 0   -- Perl provider無効化

-- Core設定の読み込み
require('core.options')    -- 基本オプション
require('core.keymaps')    -- キーマッピング
require('core.autocmds')   -- オートコマンド

-- プラグイン管理（lazy.nvim）
require('plugins')         -- プラグイン設定
