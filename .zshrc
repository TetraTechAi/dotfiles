# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
##############
#    メイン設定 #############

# Ctrl+Dでログアウトしない
setopt IGNOREEOF

# 日本語使用
export LANG=ja_JP.UTF-8

# 色の使用
autoload -Uz colors
colors

# 補完機能の使用
autoload -Uz compinit
compinit

# cdなしでディレクトリ移動
setopt auto_cd

# キーバインド（Viモード）
bindkey -v

# ディレクトリスタック
setopt auto_pushd
setopt pushd_ignore_dups

# スペルチェック
setopt correct

# ファイル上書き防止
setopt no_clobber

# ヒストリーファイル
HISTFILE=~/.zsh_history

# ヒストリーサイズ
export HISTSIZE=10000

# ヒストリーファイルサイズ
export SAVEHIST=10000

# 重複したコマンドを無視
setopt hist_ignore_dups

# すべての重複を無視
setopt hist_ignore_all_dups

# スペースで始まるコマンドを無視
setopt hist_ignore_space

# ヒストリー実行前に確認
setopt hist_verify

# ヒストリーを共有
setopt share_history

# ヒストリーにタイムスタンプを記録
setopt extended_history

# タイムスタンプフォーマット
HIST_STAMPS="yyyy-mm-dd"

# 余分な空白を削除
setopt hist_reduce_blanks

# historyコマンド自体は保存しない
setopt hist_no_store

# ヒストリー展開を有効化
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history




##############
# エイリアス
##############

# ls
alias ls='ls -l --color=auto'
alias ll='ls -alF --color=auto'

# cd
alias d='cd ~/dotfiles'

# neovim
alias vi='nvim'
alias vim='nvim'


#############
# 環境変数
#############

# エディタ
export EDITOR=nvim

# nvim設定ファイルの場所
# export XDG_CONFIG_HOME=~/dotfiles
export XDG_CONFIG_HOME=~/.config


############
# 評価
############

# Sheldon読み込み
eval "$(sheldon source)"



############
# 関数
############

# yazi（ファイルマネージャー）- 終了時にディレクトリ変更を反映
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# iTerm2 Shell Integration（要事前設定）
iterm2_print_user_vars() {
  iterm2_set_user_var test $(badge)
}

# バッジ表示
function badge() {
  printf "\e]1337;SetBadgeFormat=%s\a"\
  $(echo -n "$1" | base64)
}

# SSH接続（fzfでサーバー選択、config.d対応）
function ssh_local() {
  local config_files=("$HOME/.ssh/config")

  # config.dディレクトリが存在する場合、*.configファイルを追加
  if [[ -d "$HOME/.ssh/config.d" ]]; then
    config_files+=("$HOME/.ssh/config.d"/*.config(N))
  fi

  # 全ての設定ファイルからHost定義を抽出
  local server=$(cat "${config_files[@]}" 2>/dev/null | \
    grep "^Host " | \
    sed "s/^Host //g" | \
    grep -v '\*' | \
    sort -u | \
    fzf)

  if [ -z "$server" ]; then
    return
  fi

  badge "$server"
  ssh "$server"
}

# fzfでヒストリー検索（Ctrl+R）
function fzf-history-selection() {
  BUFFER=$(history -n 1 | tac -r | awk '!a[$0]++' | fzf --prompt="History > " --height=40% --reverse)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# cdr（最近訪れたディレクトリ）
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# fzfで最近訪れたディレクトリに移動（Ctrl+E）
function fzf-cdr () {
  local selected_dir="$(cdr -l | awk '{$1=""; sub(" ", ""); print $0}' | fzf --prompt="cdr > " --query="$LBUFFER" --height=40% --reverse)"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzf-cdr
bindkey '^E' fzf-cdr

# ghqで管理しているリポジトリに移動（Ctrl+X）
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --prompt="repositories > " --query="$LBUFFER" --height=40% --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^X' fzf-src


# Starshipプロンプト
eval "$(starship init zsh)"


# zoxide（スマートcd）
eval "$(zoxide init zsh)"
alias cd='z'

# exa（モダンなls代替）
#if [[ $(command -v exa) ]]; then
#  alias ls='exa --git --icons'
#  alias ll='exa -l --git --icons'
#  alias la='exa -la --git --icons'
#  alias lta='exa -lT --git --icons'
#  alias lt='exa -T --git --icons'
#fi

# cd後に自動でls実行
cdls()
{
  \cd "$@" && ls
}
alias cd='cdls'

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

PATH=~/.console-ninja/.bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Added by Windsurf
export PATH="/Users/nakayamaseiya/.codeium/windsurf/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/nakayamaseiya/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/nakayamaseiya/.lmstudio/bin"
# End of LM Studio CLI section

#source /Users/nakayamaseiya/work/git/github.com/TetraTechAi/claude-code-test/scripts/claude-optimization.sh
