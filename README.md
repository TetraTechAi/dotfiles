# Dotfiles

個人的な開発環境設定ファイルの管理リポジトリです。

## 📋 目次

- [含まれる設定](#含まれる設定)
- [必要要件](#必要要件)
- [インストール](#インストール)
- [使い方](#使い方)
- [カスタマイズ](#カスタマイズ)
- [トラブルシューティング](#トラブルシューティング)

## 📦 含まれる設定

このリポジトリには以下の設定ファイルが含まれています：

| ファイル/ディレクトリ | 説明 | リンク先 |
|-------------------|------|----------|
| `.tmux.conf` | Tmux設定ファイル | `~/.tmux.conf` |
| `.zshrc` | Zsh設定ファイル | `~/.zshrc` |
| `starship.toml` | Starshipプロンプト設定 | `~/.config/starship.toml` |
| `wezterm/` | WezTerm端末エミュレータ設定 | `~/.config/wezterm` |
| `nvim/` | Neovim設定ファイル | `~/.config/nvim` |
| `yazi/` | Yaziファイルマネージャー設定 | `~/.config/yazi` |
| `sheldon/` | Sheldonプラグイン設定 | `~/.config/sheldon` |
| `Brewfile` | Homebrewパッケージ管理 | - |

## 🔧 必要要件

以下のツールがインストールされていることを推奨します：

- **Git** - リポジトリのクローン
- **Zsh** - シェル
- **Tmux** - ターミナルマルチプレクサ
- **Neovim** - テキストエディタ ([インストール手順](https://github.com/neovim/neovim/wiki/Installing-Neovim))
- **Starship** - プロンプトカスタマイズ ([インストール手順](https://starship.rs/guide/#%F0%9F%9A%80-installation))
- **WezTerm** - ターミナルエミュレータ ([インストール手順](https://wezfurlong.org/wezterm/install/macos.html))

### オプション
- **Sheldon** - Zshプラグインマネージャー
- **zoxide** - より賢いcdコマンド
- **peco** - インタラクティブフィルタリングツール
- **yazi** - ターミナルファイルマネージャー

## 🚀 インストール

### 1. リポジトリのクローン

```bash
cd ~
git clone git@github.com:TetraTechAi/dotfiles.git
```

### 2. シンボリックリンクの作成

#### 自動セットアップ（推奨）

```bash
cd ~/dotfiles
./setup.sh
```

これにより以下が実行されます：
1. Brewfileからパッケージをインストール
2. シンボリックリンクを作成
3. zshrcを再読み込み

#### 個別実行

```bash
# Brewパッケージのみインストール
./setup.sh -b

# シンボリックリンクのみ作成
./setup.sh -l

# link.shを直接実行
./link.sh
```

#### Dry-run（事前確認）

実際に変更を加える前に、何が実行されるか確認できます：

```bash
cd ~/dotfiles
./link.sh -d
```

#### 手動セットアップ

自動セットアップを使わない場合は、以下のコマンドで手動リンク：

```bash
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/wezterm ~/.config/wezterm
```

### 3. 設定の反映

```bash
# Zsh設定を再読み込み
source ~/.zshrc

# または新しいシェルセッションを開始
exec zsh
```

## 📖 使い方

### link.shスクリプト

`link.sh`は設定ファイルのシンボリックリンクを自動的に作成するスクリプトです。

```bash
# ヘルプを表示
./link.sh -h

# Dry-run（実際には実行せず確認のみ）
./link.sh -d

# シンボリックリンクを作成
./link.sh
```

#### 安全機能

- **既存ファイルの自動バックアップ**: 既存のファイルは `.backup.YYYYMMDD_HHMMSS` として保存されます
- **既存リンクのチェック**: 既に正しくリンクされている場合はスキップされます
- **ディレクトリの自動作成**: 必要なディレクトリ（例：`~/.config`）が自動的に作成されます

### 設定の更新

設定ファイルを変更した後：

```bash
cd ~/dotfiles

# 変更を確認
git status

# 変更をコミット
git add .
git commit -m "Update configuration"

# リモートにプッシュ
git push origin develop
```

### 別のマシンへの展開

1. 新しいマシンで必要なツールをインストール
2. リポジトリをクローン
3. `./link.sh`を実行

```bash
# クローン
git clone git@github.com:TetraTechAi/dotfiles.git ~/dotfiles

# セットアップ
cd ~/dotfiles
./link.sh

# 設定を反映
source ~/.zshrc
```

## 🎨 カスタマイズ

### Zsh (.zshrc)

主な設定：
- **履歴管理**: 10,000行のコマンド履歴
- **エイリアス**: `ls`, `cd`, `vim`のカスタムエイリアス
- **Viキーバインド**: `bindkey -v`
- **プラグインマネージャー**: Sheldon

### Starship (starship.toml)

プロンプトのカスタマイズ設定です。詳細は[Starship公式ドキュメント](https://starship.rs/config/)を参照してください。

### WezTerm (wezterm/)

ターミナルエミュレータの設定：
- **カラースキーム**: Dracula+
- **フォント**: JetBrains Mono
- **背景透明度**: 75%
- **キーバインド**: Cmd+t（新規タブ）、Cmd+d（画面分割）など

詳細は`wezterm/wezterm.lua`を参照してください。

### Tmux (.tmux.conf)

Tmuxの設定ファイルです。

### Yazi (yazi/)

高速なターミナルファイルマネージャーの設定です。

#### ターミナルでの使い方

```bash
# yaziを起動
yazi

# yaziを起動し、終了時にそのディレクトリに移動
yy
```

#### yazi内のキーバインド

**基本操作**
| キー | 動作 |
|------|------|
| `j/k` | 上下移動 |
| `h/l` | 親ディレクトリ/ディレクトリに入る |
| `Enter` | ファイルを開く |
| `q` | 終了 |
| `.` | 隠しファイル表示切替 |

**検索**
| キー | 動作 |
|------|------|
| `/` | ファイル名をフィルタ（現在のディレクトリ内） |
| `S` | ファイル内容検索（ripgrep） |
| `z` | zoxideでディレクトリジャンプ |
| `Z` | fzfでファイル検索 |

**ソート**
| キー | 動作 |
|------|------|
| `sn` | 名前でソート |
| `sN` | 名前でソート（逆順） |
| `ss` | サイズでソート |
| `sS` | サイズでソート（逆順） |
| `sm` | 更新日時でソート |
| `sM` | 更新日時でソート（逆順） |

**クイックジャンプ（カスタム）**
| キー | 動作 |
|------|------|
| `gd` | ~/dotfilesに移動 |
| `gh` | ホームに移動 |
| `gc` | ~/.configに移動 |
| `gD` | ~/Downloadsに移動 |
| `gw` | ~/workに移動 |

**ファイル操作**
| キー | 動作 |
|------|------|
| `Ctrl+n` | 新規ファイル/ディレクトリ作成 |
| `Space` | 選択してカーソル移動 |
| `y` | コピー |
| `p` | ペースト |
| `d` | 削除 |
| `r` | リネーム |

### Neovim (nvim/)

モダンなテキストエディタNeovimの設定です。プラグイン管理にlazy.nvimを使用し、IDE的な機能を提供します。

#### 対応言語

**LSP（言語サーバー）対応:**
- スクリプト言語: Lua, JavaScript/TypeScript, Python, PHP
- コンパイル言語: Go, Rust, C/C++
- Web: HTML, CSS, Tailwind CSS, Emmet
- データ/設定: JSON, YAML, TOML
- インフラ: Bash, Dockerfile, Docker Compose, Terraform

**Treesitter（構文ハイライト）対応:**
- スクリプト: lua, javascript, typescript, tsx, python, php, ruby
- コンパイル: go, gomod, gosum, rust, c, cpp
- Web: html, css, scss
- データ: json, jsonc, yaml, toml, xml
- シェル/インフラ: bash, dockerfile, terraform, hcl
- ドキュメント: markdown, markdown_inline
- その他: vim, vimdoc, regex, query, git_config, gitcommit, gitignore, diff

#### プラグイン一覧

| プラグイン | 説明 |
|-----------|------|
| lazy.nvim | プラグインマネージャー |
| tokyonight.nvim | カラースキーム |
| lualine.nvim | ステータスライン |
| nvim-treesitter | 構文ハイライト・テキストオブジェクト |
| telescope.nvim | ファジーファインダー |
| nvim-lspconfig + Mason | LSPサーバー管理 |
| nvim-cmp | 自動補完 |
| nvim-autopairs | 括弧・クォート自動補完 |
| nvim-ts-autotag | HTMLタグ自動補完 |
| nvim-surround | 囲み文字操作 |
| Comment.nvim | コメントトグル |
| gitsigns.nvim | Git統合 |
| yazi.nvim | ファイルマネージャー統合 |
| peek.nvim | Markdownプレビュー |
| live-server.nvim | HTMLライブプレビュー |
| copilot.lua | GitHub Copilot AI補完 |
| im-select.nvim | IME自動切り替え |
| alpha-nvim | スタートアップ画面 |

#### キーマッピング

リーダーキー: `<Space>`

##### 基本操作

| キー | モード | 動作 |
|------|--------|------|
| `<Esc>` | Normal | 検索ハイライト解除 |
| `<C-s>` | Normal/Insert | ファイル保存 |
| `<C-q>` | Normal | 終了 |
| `jk` | Insert | ESC（ノーマルモードに戻る） |
| `J` | Visual | 選択行を下に移動 |
| `K` | Visual | 選択行を上に移動 |
| `<` / `>` | Visual | インデント増減（選択維持） |
| `H` | Normal/Visual | 行頭へ移動 |
| `L` | Normal/Visual | 行末へ移動 |
| `<C-d>` | Normal | 半画面下へ（中央揃え） |
| `<C-u>` | Normal | 半画面上へ（中央揃え） |

##### ウィンドウ操作

| キー | 動作 |
|------|------|
| `<Space>wv` | 垂直分割 |
| `<Space>wh` | 水平分割 |
| `<Space>wc` | ウィンドウを閉じる |
| `<Space>wo` | 他のウィンドウを閉じる |
| `<C-h/j/k/l>` | ウィンドウ間移動 |
| `<C-Up/Down/Left/Right>` | ウィンドウリサイズ |

##### バッファ操作

| キー | 動作 |
|------|------|
| `<Space>bn` | 次のバッファ |
| `<Space>bp` | 前のバッファ |
| `<Space>bd` | バッファ削除 |
| `<Space>ba` | 他のバッファを全削除 |

##### LSP操作

| キー | 動作 |
|------|------|
| `gd` | 定義へジャンプ |
| `gD` | 宣言へジャンプ |
| `gr` | 参照一覧 |
| `gi` | 実装へジャンプ |
| `gt` | 型定義へジャンプ |
| `K` | ホバー情報表示 |
| `<C-k>` | シグネチャヘルプ |
| `<Space>ca` | コードアクション |
| `<Space>rn` | リネーム |
| `<Space>fm` | フォーマット |
| `[d` / `]d` | 前/次の診断へ移動 |
| `<Space>e` | 診断フロート表示 |
| `<Space>q` | 診断リスト表示 |

##### Telescope（ファジーファインダー）

| キー | 動作 |
|------|------|
| `<Space>ff` | ファイル検索 |
| `<Space>fg` | grep検索 |
| `<Space>fb` | バッファ検索 |
| `<Space>fh` | ヘルプ検索 |
| `<Space>fr` | 最近使用ファイル |
| `<Space>fc` | コマンド検索 |
| `<Space>fk` | キーマップ検索 |
| `<Space>gc` | Gitコミット |
| `<Space>gf` | Gitファイル |

**Telescope内キー:**
| キー | 動作 |
|------|------|
| `<C-n>` / `<C-j>` | 次の項目 |
| `<C-p>` / `<C-k>` | 前の項目 |
| `<C-x>` | 水平分割で開く |
| `<C-v>` | 垂直分割で開く |
| `<C-t>` | 新規タブで開く |
| `<C-q>` | Quickfixに送る |

##### 補完操作 (nvim-cmp)

| キー | 動作 |
|------|------|
| `<Tab>` | 次の補完候補 / 閉じ括弧を抜ける |
| `<S-Tab>` | 前の補完候補 |
| `<CR>` | 補完確定 |
| `<C-Space>` | 補完メニュー表示 |
| `<C-e>` | 補完キャンセル |
| `<C-b>` / `<C-f>` | ドキュメントスクロール |

##### 自動補完機能

**括弧・クォート自動補完 (nvim-autopairs):**
- `(`, `[`, `{`, `"`, `'`, `` ` `` を入力すると自動で閉じる
- `<Tab>` で閉じ括弧を抜ける
- `<M-e>` (Alt+e) で括弧を追加（Fast Wrap）

**HTMLタグ自動補完 (nvim-ts-autotag):**
- `<div>` と入力すると `</div>` を自動追加
- 開始タグをリネームすると終了タグも自動変更
- `</` と入力すると自動で閉じる
- 対応: html, xhtml, xml, javascript, typescript, jsx, tsx, vue, svelte, php, markdown

##### 囲み文字操作 (nvim-surround)

**追加:**
| キー | 動作 | 例 |
|------|------|-----|
| `ys{motion}{char}` | 囲みを追加 | `ysiw"` → 単語を`"`で囲む |
| `yss{char}` | 行全体を囲む | `yss)` → 行を`()`で囲む |
| `ysiw<div>` | HTMLタグで囲む | 単語を`<div></div>`で囲む |

**削除:**
| キー | 動作 | 例 |
|------|------|-----|
| `ds{char}` | 囲みを削除 | `ds"` → `"`を削除 |
| `dst` | HTMLタグを削除 | |

**変更:**
| キー | 動作 | 例 |
|------|------|-----|
| `cs{old}{new}` | 囲みを変更 | `cs"'` → `"`を`'`に変更 |
| `cst<span>` | HTMLタグを変更 | |

**ビジュアルモード:**
| キー | 動作 |
|------|------|
| `S{char}` | 選択範囲を囲む |

##### コメントトグル (Comment.nvim)

| キー | モード | 動作 |
|------|--------|------|
| `gcc` | Normal | 現在行をコメントトグル |
| `gc{motion}` | Normal | motion範囲をコメント（例: `gcip` 段落、`gc5j` 5行下まで） |
| `gbc` | Normal | 現在行をブロックコメント |
| `gb{motion}` | Normal | motion範囲をブロックコメント |
| `gc` | Visual | 選択範囲をコメントトグル |
| `gb` | Visual | 選択範囲をブロックコメント |

##### Git操作 (gitsigns.nvim)

| キー | 動作 |
|------|------|
| `]c` | 次のGit変更箇所 |
| `[c` | 前のGit変更箇所 |
| `<Space>gs` | hunkをステージ |
| `<Space>gr` | hunkをリセット |
| `<Space>gS` | バッファ全体をステージ |
| `<Space>gu` | ステージ取り消し |
| `<Space>gR` | バッファ全体をリセット |
| `<Space>gp` | hunkをプレビュー |
| `<Space>gb` | blame行表示 |
| `<Space>gB` | blame表示切替 |
| `<Space>gd` | diff表示 |
| `ih` | (text object) hunk選択 |

##### Treesitterテキストオブジェクト・移動

**テキストオブジェクト:**
| キー | 動作 |
|------|------|
| `af` / `if` | 関数の外側/内側 |
| `ac` / `ic` | クラスの外側/内側 |
| `aa` / `ia` | パラメータの外側/内側 |

**コード内移動:**
| キー | 動作 |
|------|------|
| `]f` / `[f` | 次/前の関数開始 |
| `]F` / `[F` | 次/前の関数終了 |
| `]c` / `[c` | 次/前のクラス開始 |
| `]C` / `[C` | 次/前のクラス終了 |

**インクリメンタル選択:**
| キー | 動作 |
|------|------|
| `gnn` | 選択開始 |
| `grn` | ノードを拡大 |
| `grc` | スコープを拡大 |
| `grm` | ノードを縮小 |

##### ファイルマネージャー (yazi.nvim)

| キー | 動作 |
|------|------|
| `<Space>y` | カレントファイルの場所でyaziを開く |
| `<Space>Y` | カレントディレクトリでyaziを開く |
| `<Space>fy` | yaziをトグル（前回の状態を復元） |

##### プレビュー機能

**Markdownプレビュー (peek.nvim):**
| キー | 動作 |
|------|------|
| `<Space>mp` | Markdownプレビューを開く |
| `<Space>mc` | Markdownプレビューを閉じる |

コマンド: `:PeekOpen`, `:PeekClose`

機能: ライブプレビュー、同期スクロール、TeX数式、Mermaid図、GitHub風スタイル

**HTMLライブプレビュー (live-server.nvim):**
| キー | 動作 |
|------|------|
| `<Space>ls` | Live Serverトグル |

コマンド: `:LiveServerStart`, `:LiveServerStop`, `:LiveServerToggle`

ポート5500でブラウザにライブプレビュー、ファイル保存時に自動リロード

**ブラウザでプレビュー:**
| キー | 動作 |
|------|------|
| `<Space>op` | HTML/Markdownをブラウザで開く |

##### ターミナル操作

| キー | 動作 |
|------|------|
| `<Esc><Esc>` | ターミナルモード終了 |
| `<Space>tt` | ターミナル起動 |
| `<Space>tv` | ターミナル（垂直分割） |
| `<Space>th` | ターミナル（水平分割） |

##### GitHub Copilot (copilot.lua)

AIによるコード補完。初回は `:Copilot auth` でGitHubアカウント認証が必要。

**インライン補完:**
| キー | 動作 |
|------|------|
| `<M-l>` (Alt+l) | 提案を受け入れ |
| `<M-w>` (Alt+w) | 単語単位で受け入れ |
| `<M-j>` (Alt+j) | 行単位で受け入れ |
| `<M-]>` (Alt+]) | 次の提案 |
| `<M-[>` (Alt+[) | 前の提案 |
| `<C-]>` (Ctrl+]) | 提案を却下 |

**パネル操作:**
| キー | 動作 |
|------|------|
| `<C-CR>` (Ctrl+Enter) | 候補一覧パネルを開く |
| `[[` / `]]` | パネル内で前/次の候補 |
| `<CR>` | 候補を選択 |
| `gr` | 候補を更新 |

**コマンド:**
```vim
:Copilot auth     " GitHubアカウントで認証（初回のみ）
:Copilot status   " 接続状態を確認
:Copilot enable   " Copilotを有効化
:Copilot disable  " Copilotを無効化
:Copilot toggle   " Copilotをトグル
:Copilot panel    " パネルを開く
```

##### IME自動切り替え (im-select.nvim)

日本語入力時の利便性向上。依存: `brew install im-select`

| 状態遷移 | 動作 |
|----------|------|
| Insert → Normal | 自動で半角英数に切り替え |
| Normal → Insert | 前回のIME状態を復元 |
| コマンドライン離脱 | 自動で半角英数に切り替え |

##### スタートアップ画面 (alpha-nvim)

Neovim起動時に表示されるダッシュボード。

| キー | 動作 |
|------|------|
| `e` | 新規ファイル |
| `f` | ファイル検索 (Telescope) |
| `r` | 最近のファイル (Telescope) |
| `g` | Git status (Telescope) |
| `p` | プラグイン管理 (Lazy) |
| `m` | Mason (LSP管理) |
| `c` | 設定ファイル |
| `q` | 終了 |

##### その他

| キー | 動作 |
|------|------|
| `<Space>=` | ファイル全体をインデント |
| `[q` / `]q` | 前/次のQuickfixアイテム |
| `[l` / `]l` | 前/次のLoclistアイテム |

#### 基本設定 (options.lua)

| 設定 | 値 | 説明 |
|------|-----|------|
| 行番号 | 相対番号 + 絶対番号 | `relativenumber` + `number` |
| インデント | 4スペース（言語別調整あり） | Web系/設定ファイルは2スペース |
| クリップボード | システム共有 | `unnamedplus` |
| 検索 | 大文字小文字スマート | `ignorecase` + `smartcase` |
| カラー | True Color対応 | `termguicolors` |
| Undo | 永続化 | `undofile` |
| 補完 | LSP最適化 | `menu,menuone,noselect` |
| 折りたたみ | Treesitterベース | `foldmethod=expr` |
| grep | ripgrep使用 | `grepprg=rg --vimgrep` |

#### オートコマンド (autocmds.lua)

| 機能 | 説明 |
|------|------|
| ヤンクハイライト | コピー時に一瞬ハイライト |
| カーソル位置復元 | ファイル再オープン時に前回位置へ |
| 言語別インデント | Web系2スペース、Python/PHP等4スペース |
| 行末空白削除 | 保存時に自動削除 |
| ディレクトリ自動作成 | 保存時に親ディレクトリを作成 |
| Git commit設定 | スペルチェック有効、72文字制限 |
| ターミナル最適化 | 行番号非表示、自動インサート |
| 大ファイル最適化 | 100KB以上で機能制限 |
| ウィンドウリサイズ | 自動で分割サイズ均等化 |

#### コマンド

```vim
:Mason          " LSPサーバー管理画面
:Lazy           " プラグイン管理画面
:TSUpdate       " Treesitterパーサー更新
:checkhealth    " 設定の診断
```

