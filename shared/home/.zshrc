# ZSH config
[ -f "$HOME/.config/zsh/.environment.zsh" ] && source "$HOME/.config/zsh/.environment.zsh"
[ -f "$HOME/.config/zsh/environment.zsh" ] && source "$HOME/.config/zsh/environment.zsh"
[ -f "$HOME/.config/zsh/exports.zsh" ] && source "$HOME/.config/zsh/exports.zsh"
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"
[ -f "$HOME/.config/zsh/functions.zsh" ] && source "$HOME/.config/zsh/functions.zsh"
[ -f "$HOME/.config/zsh/profile.zsh" ] && source "$HOME/.config/zsh/profile.zsh"
[ -f "$HOME/.config/zsh/prompt.zsh" ] && source "$HOME/.config/zsh/prompt.zsh"
[ -f "$HOME/.config/zsh/fnm.zsh" ] && source "$HOME/.config/zsh/fnm.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v brew >/dev/null 2>&1; then
  fzf_prefix="$(brew --prefix fzf 2>/dev/null)"
  [ -f "$fzf_prefix/shell/completion.zsh" ] && source "$fzf_prefix/shell/completion.zsh"
  [ -f "$fzf_prefix/shell/key-bindings.zsh" ] && source "$fzf_prefix/shell/key-bindings.zsh"
fi

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"


# bun completions
[ -s "/home/unbalanced/.bun/_bun" ] && source "/home/unbalanced/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/unbalanced/.opencode/bin:$PATH
