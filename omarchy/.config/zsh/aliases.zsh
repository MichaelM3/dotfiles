alias zshconfig="nvim ~/.config/zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vim="nvim"


alias gp='git add . && git commit -m "auto push" && git push'
alias gps='git push --set-upstream origin'
alias zrc='nvim ~/.zshrc'
alias zsource='source ~/.zshrc'

alias p='sudo pacman -S'
alias y='yay -S'

alias vimrc="nvim ~/.config/nvim/"

alias pacup='sudo pacman -Syu'
alias yayup='sudo yay -Syu'

alias dockilla='docker kill $(docker ps -q)'

# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd="zd"
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias d='docker'
alias r='rails'
n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }

# Git
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

alias onsched='tmuxinator onsched'
