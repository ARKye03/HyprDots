#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

source ~/.local/share/blesh/ble.sh
eval "$(starship init bash)"

#Binds
bind '"\e[1;5C": forward-word'  # Ctrl + Right
bind '"\e[1;5D": backward-word'  # Ctrl + Left
bind '"\C-h": backward-kill-word' # Ctrl + Backspace
bind '"\C-l": clear-screen' # Ctrl + L


#Aliases
alias pacsu="sudo pacman -Syu --noconfirm && yay -Su --noconfirm"
alias pacin="sudo pacman -S"
alias yacin="yay -S --noconfirm"
alias pacre="sudo pacman -Rs"
alias yacre="yay -Rs"
alias paclean='sudo pacman -Rns $(pacman -Qdtq)'
alias pacache="sudo pacman -Scc --noconfirm && yay -Scc --noconfirm"
alias gc="git clone"
alias getw="xprop | grep WM_CLASS"
alias mkex="chmod +x"
alias cldl="scdl --onlymp3 --path Downloads/sdcl -l"
alias nfetch="clear && neofetch"
alias nmli="nmcli device wifi list"
alias nmco="nmcli device wifi connect"
alias mntwin="sudo mount -t ntfs-3g /dev/nvme0n1p3 /mnt/c && sudo mount -t ntfs-3g /dev/sda1 /mnt/d && sudo mount -t ntfs-3g /dev/sdb1 /mnt/e"
alias lvzsh="lvim ~/.zshrc"
alias lvbsh="lvim ~/.bashrc"
alias lvpac="lvim /etc/pacman.conf"
alias ctd="cargo tauri dev"
alias ls="ls -l --group-directories-first --color"

#Dotnet Aliases
alias dn='dotnet new'
alias dr='dotnet run'
alias dt='dotnet test'
alias dw='dotnet watch'
alias dwr='dotnet watch run'
alias dwt='dotnet watch test'
alias ds='dotnet sln'
alias da='dotnet add'
alias dp='dotnet pack'
alias dng='dotnet nuget'
alias db='dotnet build'


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

PATH=~/.console-ninja/.bin:$PATH