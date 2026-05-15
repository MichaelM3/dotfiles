#NEOVIM
alias vim='nvim'
alias vimrc='vim ~/.config/nvim/'

#GIT
alias ga='git add'
alias gcb='git checkout -b'
alias gp='git push'
alias gps='git push --set-upstream origin'

#ZSH
alias zshconfig='vim ~/.config/zsh'
alias ohmyzsh='vim ~/.oh-my-zsh'
alias zrc='vim ~/.zshrc'
alias zsource='source ~/.zshrc'

#TMUX
alias tmuxconfig='vim ~/.tmux.conf'
alias tmux='TERM=screen-256color-bce tmux'
alias onsched='tmuxinator onsched'

#PACKAGE MANAGERS
alias pn='pnpm'
alias zig='snap run zig'
alias k0s='sudo k0s'
alias kubectl='sudo k0s kubectl'

#SSH
alias macforward='ssh -N -L 18789:127.0.0.1:18789 unbalanced@192.168.0.77'
alias macremote='ssh unbalanced@192.168.0.77'

#MISC
alias wslup='sudo apt update && sudo apt upgrade -y'
alias q='exit'
alias catalias='cat ~/.config/zsh/aliases.zsh'
