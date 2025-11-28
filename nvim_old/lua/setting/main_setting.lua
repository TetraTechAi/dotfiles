local options = {
  -- 一般
	encoding = 'utf-8',
	fileencoding = 'utf-8',
	number = true,
	wrap = false,
	title = true,
	backup = false,
	clipboard = 'unnamedplus',
	cmdheight = 2,
  termguicolors = true,

  -- インデント
	shiftwidth = 2,
	tabstop = 2,
  softtabstop = 2,
	expandtab = true,
  smartindent = true,

  -- 検索
  showmatch = true,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  hlsearch = true,
  incsearch = true,
  inccommand = split,

  -- 補完
  wildmode = 'list:longest',
  infercase = true,
  wildmenu = true,

}

for k, v in pairs(options) do
	vim.opt[k] = v
end
