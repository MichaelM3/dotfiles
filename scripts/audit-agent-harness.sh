#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
shared_root="$repo_dir/shared/home/.agents"
shared_skills="$shared_root/skills"
cursor_root="$shared_root/cursor"
codex_agents="$shared_root/codex/agents"

failures=0
tmp_dirs=()

cleanup() {
  for dir in "${tmp_dirs[@]}"; do
    rm -rf "$dir"
  done
}
trap cleanup EXIT

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  failures=$((failures + 1))
}

ok() {
  printf 'ok: %s\n' "$*"
}

require_dir() {
  local path="$1"
  [[ -d "$path" ]] || fail "missing directory: $path"
}

require_file() {
  local path="$1"
  [[ -f "$path" || -L "$path" ]] || fail "missing file: $path"
}

skill_names() {
  local root="$1"
  find "$root" -mindepth 2 -maxdepth 2 -name SKILL.md -printf '%h\n' |
    while IFS= read -r dir; do basename "$dir"; done |
    sort
}

check_agent_formats() {
  local root="$1"
  local extension="$2"
  local label="$3"

  require_dir "$root"
  while IFS= read -r path; do
    fail "$label agent has wrong extension: $path"
  done < <(find "$root" -mindepth 1 -maxdepth 1 -type f ! -name "*.$extension" -print)
}

check_duplicate_names_in_root() {
  local root="$1"
  local label="$2"
  local tmp

  tmp="$(mktemp)"
  find -L "$root" -mindepth 2 -maxdepth 2 -name SKILL.md -printf '%h\n' |
    while IFS= read -r dir; do
      printf '%s\t%s\n' "$(basename "$dir")" "$(realpath "$dir")"
    done >"$tmp"

  while IFS= read -r name; do
    fail "$label exposes duplicate skill name '$name': $(grep -F "$name"$'\t' "$tmp" | cut -f2 | paste -sd ',')"
  done < <(cut -f1 "$tmp" | sort | uniq -d)

  rm -f "$tmp"
}

require_dir "$shared_skills"
require_dir "$cursor_root/skills"
require_dir "$cursor_root/agents"
require_dir "$cursor_root/rules"
require_dir "$codex_agents"

if [[ -e "$shared_skills/mini-orchestrate" || -L "$shared_skills/mini-orchestrate" ]]; then
  fail "mini-orchestrate is exposed through shared Codex-visible skills: $shared_skills/mini-orchestrate"
fi

if [[ ! -d "$cursor_root/skills/mini-orchestrate" ]]; then
  fail "missing Cursor-only skill: $cursor_root/skills/mini-orchestrate"
fi

while IFS= read -r name; do
  case "$name" in
    codex-*) continue ;;
  esac
  adapter="$cursor_root/skills/$name"
  if [[ ! -L "$adapter" ]]; then
    fail "Cursor adapter missing symlink for shared skill: $name"
    continue
  fi
  if [[ ! -e "$adapter" ]]; then
    fail "Cursor adapter has broken skill symlink: $adapter -> $(readlink "$adapter")"
    continue
  fi
  if [[ "$(realpath "$adapter")" != "$(realpath "$shared_skills/$name")" ]]; then
    fail "Cursor adapter skill points to wrong target: $adapter"
  fi
done < <(skill_names "$shared_skills")

check_agent_formats "$cursor_root/agents" "md" "Cursor"
check_agent_formats "$codex_agents" "toml" "Codex"
check_duplicate_names_in_root "$cursor_root/skills" "Cursor"

for profile in wsl2 mac omarchy; do
  tmp_home="$(mktemp -d)"
  tmp_dirs+=("$tmp_home")
  HOME="$tmp_home" "$repo_dir/install.sh" "$profile" --force >/dev/null

  for stateful in .agents .codex .cursor .config; do
    if [[ -L "$tmp_home/$stateful" ]]; then
      fail "$profile installed stateful directory as symlink: $stateful"
    fi
    require_dir "$tmp_home/$stateful"
  done

  require_file "$tmp_home/.codex/config.toml"
  require_file "$tmp_home/.codex/AGENTS.md"
  require_file "$tmp_home/.codex/agents/planner.toml"
  require_file "$tmp_home/.cursor/agents/mini-orchestrator.md"
  require_file "$tmp_home/.cursor/rules/shared-agent-harness.mdc"
  require_file "$tmp_home/.agents/AGENTS.md"
  require_file "$tmp_home/.config/zsh/profile.zsh"

  if [[ -e "$tmp_home/.codex/skills" ]]; then
    fail "$profile installed managed Codex skills root: $tmp_home/.codex/skills"
  fi

  case "$profile" in
    wsl2|mac)
      require_file "$tmp_home/.config/nvim/init.lua"
      require_file "$tmp_home/.tmux.conf"
      ;;
    omarchy)
      require_file "$tmp_home/.config/tmux/tmux.conf"
      if [[ -e "$tmp_home/.config/nvim/lua/mike" ]]; then
        fail "omarchy received portable nvim layer"
      fi
      ;;
  esac
done

if git -C "$repo_dir" ls-files | grep -Eq '(^|/)\.tmux/plugins/|(^|/)\.codex/(auth\.json|history\.jsonl|installation_id|version\.json|models_cache\.json|.*\.sqlite|log/|cache/|memories/|plugins/|rules/|sessions/|shell_snapshots/|tmp/|\.tmp/|vendor_imports/|skills/\.system/)'; then
  fail "generated or cached files are still tracked"
fi

if (( failures > 0 )); then
  printf 'agent harness audit failed: %d issue(s)\n' "$failures" >&2
  exit 1
fi

ok "layered dotfiles layout"
