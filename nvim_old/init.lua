require 'setting/main_setting'
if not vim.g.vscode then
  require 'plugin/lazy_nvim'
end
require 'keymap/main_keymap'
