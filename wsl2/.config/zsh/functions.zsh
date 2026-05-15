# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] 
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] 
       [[ ${KEYMAP} == viins ]] 
       [[ ${KEYMAP} = '' ]] 
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# Start tmux pane in current python env
function sv() {
    source venv/bin/activate &&
        tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
}

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi

function chrome() {
  local windows_path
  windows_path=$(wslpath -w "$1")
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$windows_path"
}
