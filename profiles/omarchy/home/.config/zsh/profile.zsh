export DOTFILES_PROFILE='omarchy'
export DOTFILES_PROMPT_CONTEXT='arch'
export EDITOR='nvim'

alias zshconfig='nvim ~/.config/zsh'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias vim='nvim'
alias zrc='nvim ~/.zshrc'
alias gp='git add . && git commit -m "auto push" && git push'
alias p='sudo pacman -S'
alias y='yay -S'
alias pacup='sudo pacman -Syu'
alias yayup='sudo yay -Syu'
alias dockilla='docker kill $(docker ps -q)'

# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd='zd'

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

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='docker'
alias r='rails'
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}

export PATH="/usr/bin/python3.11:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/go/bin:$PATH"
export GOPATH="$HOME/.local/go"
export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
export GOROOT=/usr/lib/go
export PATH="$PATH:/usr/lib/go/bin"
export PATH="$HOME/.local/bin/statusbar:$PATH"
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
export PATH="$PATH:$HOME/.rvm/bin"

start_onsched() {
  cd "$HOME/Work/OnSched/v3/app" || { echo "Failed to cd to app dir"; return 1; }
  docker compose --env-file .env.local up -d

  cd "$HOME/Work/OnSched/v3/api" || { echo "Failed to cd to api dir"; return 1; }
  docker compose --env-file .env up -d

  echo "All Onsched v3 services started!"
}

compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress='tar -xzf'

iso2sd() {
  if [ $# -ne 2 ]; then
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    echo -e "\nAvailable SD cards:"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
    sudo eject "$2"
  fi
}

format-drive() {
  if [ $# -ne 2 ]; then
    echo "Usage: format-drive <device> <name>"
    echo "Example: format-drive /dev/sda 'My Stuff'"
    echo -e "\nAvailable drives:"
    lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
  else
    echo "WARNING: This will completely erase all data on $1 and label it '$2'."
    read -rp "Are you sure you want to continue? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      sudo wipefs -a "$1"
      sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
      sudo parted -s "$1" mklabel gpt
      sudo parted -s "$1" mkpart primary ext4 1MiB 100%
      sudo mkfs.ext4 -L "$2" "$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
      sudo chmod -R 777 "/run/media/$USER/$2"
      echo "Drive $1 formatted and labeled '$2'."
    fi
  fi
}

transcode-video-1080p() {
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}

transcode-video-4K() {
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}

img2jpg() {
  magick "$1" -quality 95 -strip "${1%.*}.jpg"
}

img2jpg-small() {
  magick "$1" -resize 1080x\> -quality 95 -strip "${1%.*}.jpg"
}

img2png() {
  magick "$1" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${1%.*}.png"
}

cursor() {
  ~/Applications/Cursor.AppImage "$@" >/dev/null 2>&1 & disown
}

