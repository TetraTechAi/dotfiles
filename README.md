# dotfiles

このリポジトリは、chezmoi を使用して管理されている dotfiles です。

## セットアップ方法

1. chezmoi をインストール

```bash
brew install chezmoi
```

2. dotfiles を適用

```bash
chezmoi init TetraTechAi/dotfiles
chezmoi apply
```

## 含まれる設定

- `.zshrc`: Zsh の設定ファイル
- `.config/`: 各種アプリケーションの設定ファイル

## 管理方法

設定ファイルを更新する場合：

```bash
chezmoi edit ~/.zshrc  # 設定ファイルを編集
chezmoi diff           # 変更内容を確認
chezmoi apply          # 変更を適用
```
