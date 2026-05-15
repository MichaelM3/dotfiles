# ZSH config
[ -f $HOME/.config/zsh/.environment.zsh ] && source $HOME/.config/zsh/.environment.zsh
[ -f $HOME/.config/zsh/environment.zsh ] && source $HOME/.config/zsh/environment.zsh
[ -f $HOME/.config/zsh/exports.zsh ] && source $HOME/.config/zsh/exports.zsh
[ -f $HOME/.config/zsh/prompt.zsh ] && source $HOME/.config/zsh/prompt.zsh
[ -f $HOME/.config/zsh/aliases.zsh ] && source $HOME/.config/zsh/aliases.zsh
[ -f $HOME/.config/zsh/functions.zsh ] && source $HOME/.config/zsh/functions.zsh
# [ -f $HOME/.config/zsh/luamb.zsh ] && source $HOME/.config/zsh/luamb.zsh
[ -f $HOME/.config/zsh/fnm.zsh ] && source $HOME/.config/zsh/fnm.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v brew >/dev/null 2>&1; then
  fzf_prefix="$(brew --prefix fzf 2>/dev/null)"
  [ -f "$fzf_prefix/shell/completion.zsh" ] && source "$fzf_prefix/shell/completion.zsh"
  [ -f "$fzf_prefix/shell/key-bindings.zsh" ] && source "$fzf_prefix/shell/key-bindings.zsh"
fi
