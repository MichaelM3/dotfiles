export DOTFILES_PROFILE='wsl2'
export DOTFILES_PROMPT_CONTEXT='wsl2'

if [[ -x "$HOME/nvim-linux-x86_64.appimage" ]]; then
  alias vim='$HOME/nvim-linux-x86_64.appimage'
fi

alias zig='snap run zig'
alias k0s='sudo k0s'
alias kubectl='sudo k0s kubectl'
alias macforward='ssh -N -L 18789:127.0.0.1:18789 unbalanced@192.168.0.77'
alias macremote='ssh unbalanced@192.168.0.77'
alias wslup='sudo apt update && sudo apt upgrade -y'

export EDITOR='vim'
export GOROOT=/usr/local/go
export PATH="$PATH:/usr/local/go/bin"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/mnt/c/Users/sligh/AppData/Local/Programs/cursor/resources/app/bin"
export PATH="$HOME/Development/flutter/bin:$PATH"
export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
export OPENCLAW_NO_RESPAWN=1
export DOCKER_MCP_IN_CONTAINER=1

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
export ADB_SERVER_SOCKET=tcp:localhost:5037

if [[ -x '/mnt/c/Program Files/Google/Chrome/Application/chrome.exe' ]]; then
  export CHROME_EXECUTABLE='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
elif [[ -x '/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe' ]]; then
  export CHROME_EXECUTABLE='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

function chrome() {
  local windows_path
  windows_path=$(wslpath -w "$1")
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$windows_path"
}

