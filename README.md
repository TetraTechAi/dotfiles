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


