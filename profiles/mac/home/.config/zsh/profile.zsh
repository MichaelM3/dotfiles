export DOTFILES_PROFILE='mac'
export DOTFILES_PROMPT_CONTEXT='mac'
export EDITOR='vim'

alias brewup='brew update && brew upgrade'

if command -v brew >/dev/null 2>&1; then
  export HOMEBREW_PREFIX="$(brew --prefix)"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
fi

export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$HOME/Development/flutter/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

function chrome() {
  open -a "Google Chrome" "$@"
}

