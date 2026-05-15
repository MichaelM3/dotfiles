# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

zle_highlight=('paste:none')

# Which plugins would you like to load?
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
)
export ZSH="$HOME/.oh-my-zsh"
[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
