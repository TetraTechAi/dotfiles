#!/bin/bash
# ============================================================================
# setup.sh テスト
# ============================================================================
# 使い方: bash tests/test_setup.sh
# setup.sh の dry-run、オプション分岐、失敗時継続を検証する

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=tests/helpers.sh
source "$SCRIPT_DIR/helpers.sh"

TMP_ROOT=$(mktemp -d)
trap 'rm -rf "$TMP_ROOT"' EXIT

make_stub_bin() {
  local stub_bin="$1"
  mkdir -p "$stub_bin"

  cat > "$stub_bin/brew" <<'STUB'
#!/bin/bash
printf 'brew %s\n' "$*" >> "$TEST_COMMAND_LOG"
if [ "${1:-}" = "--version" ]; then
  printf 'Homebrew test\n'
  exit 0
fi
if [ "${BREW_BUNDLE_FAIL:-}" = "1" ] && [ "${1:-}" = "bundle" ]; then
  exit 1
fi
exit 0
STUB

  cat > "$stub_bin/npm" <<'STUB'
#!/bin/bash
printf 'npm %s\n' "$*" >> "$TEST_COMMAND_LOG"
if [ "${1:-}" = "list" ]; then
  exit 0
fi
exit 0
STUB

  cat > "$stub_bin/sketchybar" <<'STUB'
#!/bin/bash
printf 'sketchybar %s\n' "$*" >> "$TEST_COMMAND_LOG"
exit 0
STUB

  chmod +x "$stub_bin/brew" "$stub_bin/npm" "$stub_bin/sketchybar"
}

bold "=== setup.sh テスト ==="
echo ""

bold "--- dry-run ---"

dry_fixture="$TMP_ROOT/dry-fixture"
dry_home="$TMP_ROOT/dry-home"
dry_stub="$TMP_ROOT/dry-bin"
dry_log="$TMP_ROOT/dry-commands.log"
mkdir -p "$dry_home"
make_dotfiles_fixture "$dry_fixture"
make_stub_bin "$dry_stub"

dry_output=$(HOME="$dry_home" PATH="$dry_stub:/usr/bin:/bin" TEST_COMMAND_LOG="$dry_log" "$dry_fixture/setup.sh" -d 2>&1)
dry_status=$?

assert_eq "setup.sh -d は成功する" "0" "$dry_status"
assert_contains "dry-run はフォントディレクトリ作成予定を表示する" "$dry_output" "Would ensure font directory exists"
assert_not_exists "dry-run はフォントディレクトリを作らない" "$dry_home/Library"
assert_not_exists "dry-run は Codex 生成物を書き込まない" "$dry_fixture/.codex/user-config.toml"
assert_file_contains "Homebrew バージョン確認を実行する" "$dry_log" "brew --version"
assert_not_contains "dry-run は brew bundle を実行しない" "$(cat "$dry_log")" "brew bundle"

echo ""
bold "--- link-only ---"

link_fixture="$TMP_ROOT/link-fixture"
link_home="$TMP_ROOT/link-home"
mkdir -p "$link_home"
make_dotfiles_fixture "$link_fixture"
printf 'existing git local\n' > "$link_home/.gitconfig.local"

link_output=$(HOME="$link_home" PATH="/usr/bin:/bin" "$link_fixture/setup.sh" -l 2>&1)
link_status=$?

assert_eq "setup.sh -l は brew なしでも成功する" "0" "$link_status"
assert_contains "link-only は symlink 作成ステップを実行する" "$link_output" "Creating symbolic links"
assert_symlink_target "link-only は .zshrc をリンクする" "$link_home/.zshrc" "$link_fixture/.zshrc"

echo ""
bold "--- brew-only ---"

brew_fixture="$TMP_ROOT/brew-fixture"
brew_home="$TMP_ROOT/brew-home"
brew_stub="$TMP_ROOT/brew-bin"
brew_log="$TMP_ROOT/brew-commands.log"
mkdir -p "$brew_home"
make_dotfiles_fixture "$brew_fixture"
make_stub_bin "$brew_stub"

brew_output=$(HOME="$brew_home" PATH="$brew_stub:/usr/bin:/bin" TEST_COMMAND_LOG="$brew_log" "$brew_fixture/setup.sh" -b 2>&1)
brew_status=$?

assert_eq "setup.sh -b は成功する" "0" "$brew_status"
assert_file_contains "brew-only は brew bundle を実行する" "$brew_log" "brew bundle --file=Brewfile"
assert_not_exists "brew-only はリンクを作成しない" "$brew_home/.zshrc"
assert_not_contains "brew-only は link.sh を実行しない" "$brew_output" "Creating symbolic links"

echo ""
bold "--- brew 失敗時 ---"

fail_fixture="$TMP_ROOT/fail-fixture"
fail_home="$TMP_ROOT/fail-home"
fail_stub="$TMP_ROOT/fail-bin"
fail_log="$TMP_ROOT/fail-commands.log"
mkdir -p "$fail_home"
make_dotfiles_fixture "$fail_fixture"
make_stub_bin "$fail_stub"

fail_output=$(HOME="$fail_home" PATH="$fail_stub:/usr/bin:/bin" TEST_COMMAND_LOG="$fail_log" BREW_BUNDLE_FAIL=1 "$fail_fixture/setup.sh" -b 2>&1)
fail_status=$?

assert_eq "brew bundle が失敗しても setup.sh -b は継続する" "0" "$fail_status"
assert_contains "brew 失敗時の警告を表示する" "$fail_output" "Some Homebrew packages failed to install"

finish_tests
