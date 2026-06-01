#!/bin/bash
# ============================================================================
# .zshrc テスト
# ============================================================================
# 使い方: bash tests/test_zshrc.sh
# 任意ツールが無い環境でも .zshrc が読み込めることを検証する

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=tests/helpers.sh
source "$SCRIPT_DIR/helpers.sh"

TMP_ROOT=$(mktemp -d)
trap 'rm -rf "$TMP_ROOT"' EXIT

make_ls_without_color() {
  local stub_bin="$1"
  mkdir -p "$stub_bin"

  cat > "$stub_bin/ls" <<'STUB'
#!/bin/bash
if [ "${1:-}" = "--color=auto" ]; then
  exit 1
fi
exec /bin/ls "$@"
STUB

  chmod +x "$stub_bin/ls"
}

make_zoxide_stub() {
  local stub_bin="$1"
  cat > "$stub_bin/zoxide" <<'STUB'
#!/bin/bash
if [ "${1:-}" = "init" ]; then
  printf 'z() { builtin cd "$@"; }\n'
fi
STUB
  chmod +x "$stub_bin/zoxide"
}

bold "=== .zshrc テスト ==="
echo ""

bold "--- 構文 ---"

zsh -n "$REPO_DIR/.zshrc"
assert_eq ".zshrc は zsh 構文として有効" "0" "$?"

echo ""
bold "--- 任意ツールなし ---"

missing_home="$TMP_ROOT/missing-home"
missing_stub="$TMP_ROOT/missing-bin"
mkdir -p "$missing_home"
make_ls_without_color "$missing_stub"

missing_output=$(
  HOME="$missing_home" \
  PATH="$missing_stub:/usr/bin:/bin" \
  TERM=xterm-256color \
  zsh -f -c '
    source "$1"
    alias ls
    if alias cd >/dev/null 2>&1; then
      print "CD_ALIAS=$(alias cd)"
    else
      print "CD_ALIAS=missing"
    fi
    true
  ' zsh "$REPO_DIR/.zshrc" 2>&1
)
missing_status=$?

assert_eq "任意ツールなしでも source が完了する" "0" "$missing_status"
assert_not_contains "sheldon 未導入で command not found を出さない" "$missing_output" "sheldon: command not found"
assert_not_contains "starship 未導入で command not found を出さない" "$missing_output" "starship: command not found"
assert_not_contains "zoxide 未導入で command not found を出さない" "$missing_output" "zoxide: command not found"
assert_not_contains "abbr 未導入で command not found を出さない" "$missing_output" "abbr: command not found"
assert_contains "GNU ls 非対応時は macOS 互換の -G alias にする" "$missing_output" "ls='ls -lG'"
assert_contains "zoxide 未導入時は cd alias を定義しない" "$missing_output" "CD_ALIAS=missing"

echo ""
bold "--- zoxide あり ---"

zoxide_home="$TMP_ROOT/zoxide-home"
zoxide_stub="$TMP_ROOT/zoxide-bin"
mkdir -p "$zoxide_home"
make_ls_without_color "$zoxide_stub"
make_zoxide_stub "$zoxide_stub"

zoxide_output=$(
  HOME="$zoxide_home" \
  PATH="$zoxide_stub:/usr/bin:/bin" \
  TERM=xterm-256color \
  zsh -f -c '
    source "$1"
    alias cd
    alias zz
    true
  ' zsh "$REPO_DIR/.zshrc" 2>&1
)
zoxide_status=$?

assert_eq "zoxide 利用可能時も source が完了する" "0" "$zoxide_status"
assert_contains "zoxide 利用可能時は cd を zls にする" "$zoxide_output" "cd=zls"
assert_contains "zoxide 利用可能時は zz を z にする" "$zoxide_output" "zz=z"

finish_tests
