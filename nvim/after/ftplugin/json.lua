-- JSON filetype plugin
-- このファイルはJSONファイルを開くたびに自動的に読み込まれます

-- インデント設定
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- 自動インデント
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true
vim.opt_local.cindent = false

-- インデント式 - Treesitterを使用
vim.opt_local.indentexpr = 'nvim_treesitter#indent()'

-- indentexprがいつ評価されるかを設定
-- o, O (新しい行を開く), {, }, [, ], : などのキーで評価
vim.opt_local.indentkeys = '0{,0},0),0[,0],!^F,o,O,e,='
