# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

zle_highlight=('paste:none')

# Which plugins would you like to load?
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
)
# export ZSH="/home/$USER/.oh-my-zsh"
export ZSH="$HOME/.oh-my-zsh"
[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# export
export TF_FORCE_GPU_ALLOW_GROWTH=true
# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi
#autoload -U colors && colors
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg --files --hidden'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export MANPAGER='nvim +Man!'
export MANWIDTH=999


export GOROOT=/usr/local/go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/Development/go_code
export PATH="$PATH:$GOPATH/bin"

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/statusbar:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export KUBECONFIG=~/.kube/config

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

# FIREBASE_EMULATOR
export FIRESTORE_EMULATOR_HOST=127.0.0.1:8080

export PATH="$PATH:/opt/nvim-linux64/bin"

# Cursor
export PATH="$PATH:/mnt/c/Users/sligh/AppData/Local/Programs/cursor/resources/app/bin"

export PATH="$HOME/Development/flutter/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
export OPENCLAW_NO_RESPAWN=1
export DOCKER_MCP_IN_CONTAINER=1
export CODEX_HOME=$HOME/.codex

# Android: use Linux SDK under WSL (Flutter/Gradle need Linux adb, aapt, etc.). Windows Studio SDK is only .exe.
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
export ADB_SERVER_SOCKET=tcp:localhost:5037

# Optional: Chrome path for tools that expect CHROME_EXECUTABLE (not used for Goldies Android dev)
if [[ -x '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe' ]]; then
  export CHROME_EXECUTABLE='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
elif [[ -x '/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe' ]]; then
  export CHROME_EXECUTABLE='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
