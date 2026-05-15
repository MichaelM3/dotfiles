#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh <wsl2|mac|omarchy> [--dry-run] [--force]

Symlinks selected OS config into $HOME:
  OS root files/dirs -> $HOME
  OS .config/*      -> $HOME/.config/*

Existing files are moved to ~/.dotfiles-backup/<timestamp>/ unless --force is used.
USAGE
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

os="$1"
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

case "$os" in
  wsl2|mac|omarchy) ;;
  *) echo "Unknown OS: $os" >&2; usage; exit 1 ;;
esac

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
src_root="$repo_dir/$os"
backup_root="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

run() {
  if [[ "$dry_run" -eq 1 ]]; then
    printf 'dry-run:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

same_link() {
  local dest="$1"
  local src="$2"
  [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]
}

backup_existing() {
  local dest="$1"
  local rel="$2"

  if [[ "$force" -eq 1 ]]; then
    run rm -rf "$dest"
    return
  fi

  run mkdir -p "$backup_root/$(dirname "$rel")"
  run mv "$dest" "$backup_root/$rel"
}

link_one() {
  local src="$1"
  local dest="$2"
  local rel="$3"

  if same_link "$dest" "$src"; then
    echo "ok: $dest"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    backup_existing "$dest" "$rel"
  fi

  run mkdir -p "$(dirname "$dest")"
  run ln -s "$src" "$dest"
  echo "linked: $dest -> $src"
}

shopt -s nullglob dotglob

for item in "$src_root"/*; do
  name="$(basename "$item")"
  [[ "$name" == ".config" ]] && continue
  link_one "$item" "$HOME/$name" "$name"
done

run mkdir -p "$HOME/.config"
for item in "$src_root/.config"/*; do
  name="$(basename "$item")"
  link_one "$item" "$HOME/.config/$name" ".config/$name"
done

echo "done: $os"
if [[ "$dry_run" -eq 0 && -d "$backup_root" ]]; then
  echo "backups: $backup_root"
fi
