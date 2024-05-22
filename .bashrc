[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

source ~/.local/share/blesh/ble.sh
eval "$(starship init bash)"

#Binds
bind '"\e[1;5C": forward-word'    # Ctrl + Right
bind '"\e[1;5D": backward-word'   # Ctrl + Left
bind '"\C-h": backward-kill-word' # Ctrl + Backspace
bind '"\C-l": clear-screen'       # Ctrl + L

#Aliases
source ~/.profile

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.console-ninja/.bin:$PATH"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"
