# Dotfiles

Layered personal dotfiles for WSL2, macOS, and Omarchy.

## Layout

```text
shared/home/              # managed files installed for every profile
shared/portable/home/     # managed files shared by WSL2 and macOS
shared/codex/             # Codex config fragments rendered at install time
profiles/<profile>/home/  # profile-specific managed files
profiles/<profile>/codex/ # profile-specific Codex config fragments
```

`home/` directories mirror `$HOME`. The installer creates real directories in
`$HOME` and symlinks managed leaf files inside them.

Stateful directories stay local and real:

- `$HOME/.codex`
- `$HOME/.agents`
- `$HOME/.cursor`
- `$HOME/.config`
- `$HOME/.tmux`

That keeps credentials, sessions, caches, generated files, downloaded plugins,
and lock files out of Git.

## New Machine

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
cp shared/home/.config/zsh/.environment.zsh.example ~/.config/zsh/.environment.zsh
$EDITOR ~/.config/zsh/.environment.zsh
./install.sh <profile>
```

Profiles:

```bash
./install.sh wsl2
./install.sh mac
./install.sh omarchy
```

Preview first:

```bash
./install.sh <profile> --dry-run
```

Overwrite instead of backing up:

```bash
./install.sh <profile> --force
```

Default behavior moves existing files to `~/.dotfiles-backup/<timestamp>/`.

## Codex

Codex runtime state is local. The repo tracks:

- shared harness instructions and skills under `shared/home/.agents`
- Codex `AGENTS.md` under `shared/home/.codex/AGENTS.md`
- Codex config fragments under `shared/codex` and `profiles/<profile>/codex`

`install.sh` renders `$HOME/.codex/config.toml` from those fragments. It does
not symlink the whole `.codex` directory.

## Generated Files

Do not track:

- Codex auth, logs, SQLite DBs, sessions, plugins, system skills, and caches
- tmux plugins and resurrect state
- Neovim lock/cache/session files
- tool credentials under `.config`
- `node_modules`, package locks generated inside tool config dirs

Legacy top-level `wsl2/`, `mac/`, and `omarchy/` directories are ignored so
old local symlink targets and caches can remain on disk during migration.

## Verify

```bash
scripts/audit-agent-harness.sh
```
