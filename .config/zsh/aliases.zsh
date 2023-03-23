alias gpu_watch="watch -n -1 nvidia-smi"
alias zshconfig="nvim ~/.config/zsh"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias v="nvim ."

# use this with media keys later
alias play="spotify play"
alias pause="spotify pause"
alias next="spotify next"
alias prev="spotify prev"

alias gp='git add . && git commit -m "auto push" && git push'
alias zrc='nvim ~/.zshrc'
alias zsource='source ~/.zshrc'
# alias ls='exa --color=always --group-directories-first'
alias p='sudo pacman -S'
alias y='yay -S'
alias fshoot_full='flameshot full -p ~/pics/screenshots'
alias kill_vbox="kill $(ps -e | grep VirtualBox | awk '{ print $1 }')"
alias wallpapers="sxiv /storage/pics/wallpapers"
alias list_systemctl="systemctl list-unit-files --state=enabled"
alias greeter="dm-tool switch-to-greeter"
alias small_text="sed -i 's/size: 22.0/size: 15.0/g' ~/.config/alacritty/alacritty.yml"
alias big_text="sed -i 's/size: 15.0/size: 22.0/g' ~/.config/alacritty/alacritty.yml"
alias logout="dm-tool switch-to-greeter"
alias i3-logout="i3-msg exit"
alias monitors="xrandr -q | grep " connected" | cut -d ' ' -f1"
alias sk="screenkey -s small --scr 1"
alias skk="killall screenkey"
alias i3conf="nvim ~/.config/i3/config"
alias viconf="nvim ~/.config/nvim/"
