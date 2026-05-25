#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh <wsl2|mac|omarchy> [--dry-run] [--force]

Installs layered dotfiles into $HOME:
  shared/home              -> every profile
  shared/portable/home     -> wsl2 and mac
  profiles/<profile>/home  -> selected profile

The installer creates real local directories and symlinks managed leaf files
inside them. Stateful directories such as .codex, .agents, .cursor, .config,
and .tmux are never replaced by whole-directory symlinks.

Existing files are moved to ~/.dotfiles-backup/<timestamp>/ unless --force is used.
USAGE
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

profile="$1"
shift

dry_run=0
force=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=1 ;;
    --force) force=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
  esac
done

case "$profile" in
  wsl2|mac|omarchy) ;;
  *) echo "Unknown profile: $profile" >&2; usage; exit 1 ;;
esac

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
backup_root="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
backup_used=0

run() {
  if [[ "$dry_run" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

ensure_backup_root() {
  if [[ "$backup_used" -eq 0 ]]; then
    run mkdir -p "$backup_root"
    backup_used=1
  fi
}

same_link() {
  local dest="$1"
  local src="$2"
  [[ -L "$dest" ]] || return 1
  [[ "$(readlink "$dest")" == "$src" ]] && return 0
  command -v realpath >/dev/null 2>&1 || return 1
  [[ "$(realpath "$dest" 2>/dev/null)" == "$(realpath "$src" 2>/dev/null)" ]]
}

backup_existing() {
  local dest="$1"
  local rel="$2"

  if [[ "$force" -eq 1 ]]; then
    run rm -rf "$dest"
    return
  fi

  ensure_backup_root
  run mkdir -p "$backup_root/$(dirname "$rel")"
  run mv "$dest" "$backup_root/$rel"
}

copy_symlink_target_into_real_dir() {
  local dest="$1"
  local rel="$2"
  local target

  target="$(realpath "$dest" 2>/dev/null || true)"
  if [[ -z "$target" || ! -d "$target" ]]; then
    backup_existing "$dest" "$rel"
    run mkdir -p "$dest"
    return
  fi

  if [[ "$force" -eq 1 ]]; then
    run rm -f "$dest"
    run mkdir -p "$dest"
    run cp -a "$target/." "$dest/"
    return
  fi

  ensure_backup_root
  run mkdir -p "$backup_root/$(dirname "$rel")"
  run mv "$dest" "$backup_root/$rel"
  run mkdir -p "$dest"
  run cp -a "$target/." "$dest/"
}

ensure_real_dir() {
  local dest="$1"
  local rel="$2"

  if [[ -L "$dest" ]]; then
    copy_symlink_target_into_real_dir "$dest" "$rel"
    return
  fi

  if [[ -e "$dest" && ! -d "$dest" ]]; then
    backup_existing "$dest" "$rel"
  fi

  [[ -d "$dest" ]] || run mkdir -p "$dest"
}

link_one() {
  local src="$1"
  local dest="$2"
  local rel="$3"

  if same_link "$dest" "$src"; then
    echo "ok: $dest"
    return
  fi

  ensure_real_dir "$(dirname "$dest")" "$(dirname "$rel")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    backup_existing "$dest" "$rel"
  fi

  run ln -s "$src" "$dest"
  echo "linked: $dest -> $src"
}

should_skip_rel() {
  local rel="$1"
  case "$rel" in
    .codex/config.toml|\
    .codex/auth.json|\
    .codex/history.jsonl|\
    .codex/session_index.jsonl|\
    .codex/installation_id|\
    .codex/.personality_migration|\
    .codex/version.json|\
    .codex/models_cache.json|\
    .codex/*.sqlite|\
    .codex/*.sqlite-shm|\
    .codex/*.sqlite-wal|\
    .codex/log/*|\
    .codex/cache/*|\
    .codex/generated_images/*|\
    .codex/memories/*|\
    .codex/plugins/*|\
    .codex/rules/*|\
    .codex/sessions/*|\
    .codex/shell_snapshots/*|\
    .codex/tmp/*|\
    .codex/.tmp/*|\
    .codex/vendor_imports/*|\
    .config/zsh/environment.zsh|\
    .config/zsh/.environment.zsh|\
    .config/nvim/lazy-lock.json|\
    .config/lazygit/state.yml|\
    .config/opencode/bun.lock|\
    .config/opencode/node_modules/*|\
    .tmux/plugins/*|\
    .tmux/resurrect/*)
      return 0
      ;;
  esac
  return 1
}

link_tree() {
  local src_root="$1"
  local dest_root="$2"
  local rel_root="$3"

  [[ -d "$src_root" ]] || return 0

  while IFS= read -r dir; do
    local rel="${dir#"$src_root"}"
    rel="${rel#/}"
    local dest="$dest_root"
    local rel_dest="$rel_root"
    if [[ -n "$rel" ]]; then
      dest="$dest_root/$rel"
      if [[ "$rel_root" == "." ]]; then
        rel_dest="$rel"
      else
        rel_dest="$rel_root/$rel"
      fi
    fi
    ensure_real_dir "$dest" "$rel_dest"
  done < <(find "$src_root" -type d -print | sort)

  while IFS= read -r src; do
    local rel="${src#"$src_root"/}"
    local rel_dest
    if [[ "$rel_root" == "." ]]; then
      rel_dest="$rel"
    else
      rel_dest="$rel_root/$rel"
    fi
    should_skip_rel "$rel_dest" && continue
    link_one "$src" "$dest_root/$rel" "$rel_dest"
  done < <(find "$src_root" \( -type f -o -type l \) -print | sort)
}

render_codex_config() {
  local profile_root="$repo_dir/profiles/$profile/codex"
  local dest="$HOME/.codex/config.toml"
  local tmp
  tmp="$(mktemp)"

  for fragment in \
    "$repo_dir/shared/codex/config.top.toml" \
    "$profile_root/config.top.toml" \
    "$repo_dir/shared/codex/config.toml" \
    "$profile_root/config.toml"; do
    [[ -f "$fragment" ]] || continue
    printf '# %s\n' "${fragment#"$repo_dir"/}" >>"$tmp"
    cat "$fragment" >>"$tmp"
    printf '\n' >>"$tmp"
  done

  ensure_real_dir "$HOME/.codex" ".codex"

  if [[ -f "$dest" ]] && cmp -s "$tmp" "$dest"; then
    rm -f "$tmp"
    echo "ok: $dest"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    backup_existing "$dest" ".codex/config.toml"
  fi

  if [[ "$dry_run" -eq 1 ]]; then
    printf 'dry-run: install rendered Codex config %q\n' "$dest"
    rm -f "$tmp"
  else
    mv "$tmp" "$dest"
  fi
  echo "rendered: $dest"
}

layers=("$repo_dir/shared/home")
case "$profile" in
  wsl2|mac) layers+=("$repo_dir/shared/portable/home") ;;
esac
layers+=("$repo_dir/profiles/$profile/home")

for layer in "${layers[@]}"; do
  link_tree "$layer" "$HOME" "."
done

link_tree "$repo_dir/shared/home/.agents/codex/agents" "$HOME/.codex/agents" ".codex/agents"
link_tree "$repo_dir/shared/home/.agents/cursor/agents" "$HOME/.cursor/agents" ".cursor/agents"
link_tree "$repo_dir/shared/home/.agents/cursor/skills" "$HOME/.cursor/skills" ".cursor/skills"
link_tree "$repo_dir/shared/home/.agents/cursor/rules" "$HOME/.cursor/rules" ".cursor/rules"
render_codex_config

echo "done: $profile"
if [[ "$dry_run" -eq 0 && "$backup_used" -eq 1 ]]; then
  echo "backups: $backup_root"
fi
