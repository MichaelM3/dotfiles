# Dotfiles

Portable configs split by target OS:

- `wsl2/`
- `mac/`
- `omarchy/`

Files that normally live in `$HOME` are stored at OS dir root. Files that normally live in `$HOME/.config` are stored under each OS dir `.config/`.

## New Machine

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
cp <os>/.config/zsh/.environment.zsh.example <os>/.config/zsh/.environment.zsh
$EDITOR <os>/.config/zsh/.environment.zsh
./install.sh <os>
```

Use one of:

```bash
./install.sh wsl2
./install.sh mac
./install.sh omarchy
```

Preview first:

```bash
./install.sh <os> --dry-run
```

Overwrite existing files instead of backing them up:

```bash
./install.sh <os> --force
```

By default, existing real files move to `~/.dotfiles-backup/<timestamp>/`.

## Environment

`zsh/.environment.zsh` is ignored by git. Put machine-local values there:

- API keys and tokens
- SDK paths
- local `PATH` entries
- `JAVA_HOME`, `ANDROID_HOME`, `KUBECONFIG`
- private aliases with credentials

Tracked zsh files source `.environment.zsh` first, then load shared shell config, prompt, aliases, functions, and `fnm`.

## Included Configs

Current live WSL2 configs were used as source of truth. Portable tracked configs include:

- `.zshrc`
- `.tmux.conf`
- `.tmux/`
- `.codex/` global instructions, sanitized config, skills
- `.agents/`
- `.config/zsh/`
- `.config/nvim/`
- `.config/lazygit/`
- `.config/tmuxinator/`
- `.config/opencode/` without `node_modules`

Credential/cache dirs like `gcloud`, `gh/hosts.yml`, `firebase`, `ngrok`, `stripe`, Codex auth/log DBs, and tool caches are intentionally ignored.
