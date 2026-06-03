#!/bin/bash
# ============================================================================
# format-edited-files.sh テスト
# ============================================================================
# 使い方: bash tests/test_format_edited_files.sh
# Edit/Write と apply_patch 入力から対象ファイルだけを整形することを検証する

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=tests/helpers.sh
source "$SCRIPT_DIR/helpers.sh"

TMP_ROOT=$(mktemp -d)
trap 'rm -rf "$TMP_ROOT"' EXIT

make_formatter_stubs() {
  local stub_bin="$1"
  mkdir -p "$stub_bin"

  cat > "$stub_bin/npx" <<'STUB'
#!/bin/bash
printf 'npx %s\n' "$*" >> "$TEST_FORMAT_LOG"
exit 0
STUB

  cat > "$stub_bin/black" <<'STUB'
#!/bin/bash
printf 'black %s\n' "$*" >> "$TEST_FORMAT_LOG"
exit 0
STUB

  chmod +x "$stub_bin/npx" "$stub_bin/black"
}

run_hook() {
  local input="$1"
  TEST_FORMAT_LOG="$FORMAT_LOG" PATH="$STUB_BIN:/usr/bin:/bin:$PATH" \
    bash "$REPO_DIR/scripts/format-edited-files.sh" <<< "$input"
}

bold "=== format-edited-files.sh テスト ==="
echo ""

STUB_BIN="$TMP_ROOT/bin"
FORMAT_LOG="$TMP_ROOT/format.log"
WORK_DIR="$TMP_ROOT/work"
mkdir -p "$WORK_DIR"
make_formatter_stubs "$STUB_BIN"
: > "$FORMAT_LOG"

js_file="$WORK_DIR/app.js"
py_file="$WORK_DIR/app.py"
md_file="$WORK_DIR/README.md"
json_file="$WORK_DIR/config.json"
sh_file="$WORK_DIR/script.sh"
missing_file="$WORK_DIR/missing.json"

printf 'const x=1\n' > "$js_file"
printf 'print("hi")\n' > "$py_file"
printf '# Title\n' > "$md_file"
printf '{}\n' > "$json_file"
printf 'echo hi\n' > "$sh_file"

bold "--- direct file_path ---"

run_hook "$(jq -n --arg file "$js_file" '{tool_input: {file_path: $file}}')"
assert_file_contains "JavaScript は prettier を実行する" "$FORMAT_LOG" "npx prettier --write $js_file"

run_hook "$(jq -n --arg file "$py_file" '{tool_input: {file_path: $file}}')"
assert_file_contains "Python は black を実行する" "$FORMAT_LOG" "black $py_file"

before_lines=$(wc -l < "$FORMAT_LOG" | tr -d '[:space:]')
run_hook "$(jq -n --arg file "$sh_file" '{tool_input: {file_path: $file}}')"
after_lines=$(wc -l < "$FORMAT_LOG" | tr -d '[:space:]')
assert_eq "非対象拡張子は整形しない" "$before_lines" "$after_lines"

run_hook "$(jq -n --arg file "$missing_file" '{tool_input: {file_path: $file}}')"
after_missing_lines=$(wc -l < "$FORMAT_LOG" | tr -d '[:space:]')
assert_eq "存在しないファイルは無視する" "$after_lines" "$after_missing_lines"

echo ""
bold "--- apply_patch command ---"

patch_command=$(printf '%s\n' \
  '*** Begin Patch' \
  "*** Update File: $md_file" \
  '@@' \
  '-# Title' \
  '+# Updated' \
  '*** End Patch')

run_hook "$(jq -n --arg command "$patch_command" '{tool_input: {command: $command}}')"
assert_file_contains "apply_patch の Update File から Markdown を整形する" "$FORMAT_LOG" "npx prettier --write $md_file"

add_patch_command=$(printf '%s\n' \
  '*** Begin Patch' \
  "*** Add File: $json_file" \
  '+{"ok":true}' \
  '*** End Patch')

run_hook "$(jq -n --arg command "$add_patch_command" '{tool_input: {command: $command}}')"
assert_file_contains "apply_patch の Add File から JSON を整形する" "$FORMAT_LOG" "npx prettier --write $json_file"

finish_tests
