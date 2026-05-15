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


export EDITOR='vim'
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export GOROOT=/usr/lib/go
export GOPATH="$HOME/Development/go_code"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export KUBECONFIG="$HOME/.kube/config"
export JAVA_HOME="/usr/lib/jvm/default"
export FIRESTORE_EMULATOR_HOST=127.0.0.1:8080
export PATH="$HOME/Development/flutter/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init - zsh)"

export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
export OPENCLAW_NO_RESPAWN=1
export DOCKER_MCP_IN_CONTAINER=1

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
