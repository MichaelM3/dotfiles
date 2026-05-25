# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="${CASE_SENSITIVE:-false}"

zle_highlight=('paste:none')

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
)

export ZSH="$HOME/.oh-my-zsh"
[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

export TF_FORCE_GPU_ALLOW_GROWTH=true
export EDITOR="${EDITOR:-nvim}"
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export GOPATH="${GOPATH:-$HOME/Development/go_code}"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
export FIRESTORE_EMULATOR_HOST=127.0.0.1:8080
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init - zsh)"

export CODEX_HOME="$HOME/.codex"

