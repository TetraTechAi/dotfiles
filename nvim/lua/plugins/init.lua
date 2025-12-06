------------------------------------------------------------------------------
-- プラグイン管理（lazy.nvim）
------------------------------------------------------------------------------

-- lazy.nvim Bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim設定
require('lazy').setup({
  -- プラグイン設定ファイルの自動読み込み
  { import = 'plugins.colorscheme' },
  { import = 'plugins.lualine' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.telescope' },
  { import = 'plugins.lsp' },
  { import = 'plugins.completion' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.yazi' },
  { import = 'plugins.peek' },
}, {
  -- lazy.nvim UI設定
  ui = {
    border = 'rounded',
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  -- パフォーマンス設定
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- Neovimランタイムパスから不要なプラグインを無効化
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  -- 変更検出設定
  checker = {
    enabled = false,  -- 起動時の自動アップデートチェックを無効化
    notify = false,
  },
})
