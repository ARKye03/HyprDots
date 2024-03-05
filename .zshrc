
if [[ "$TERM_PROGRAM" != "WarpTerminal" ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  
  HISTFILE=~/.histfile
  HISTSIZE=5000
  SAVEHIST=5000
  zstyle :compinstall filename '/home/archkye/.zshrc'
  
  #ZStyles Completions
  zstyle ':completion:*' verbose true
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  
  #Zsh Options
  setopt PROMPT_SUBST
  setopt MENU_COMPLETE
  setopt LIST_PACKED
  setopt AUTO_LIST
  setopt HIST_IGNORE_DUPS
  setopt HIST_FIND_NO_DUPS
  setopt COMPLETE_IN_WORD
  
  #Plugins
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
  
  #Binds
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[[1;5C' forward-word  # Ctrl + Right
  bindkey '^[[1;5D' backward-word  # Ctrl + Left
  bindkey '^H' backward-kill-word # Ctrl + Backspace
  bindkey "^L" clear-screen # Ctrl + L
  
  autoload -Uz compinit
  compinit
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  
fi

#Aliases
alias pacsu="yay --noconfirm"
alias pacin="sudo pacman -S --noconfirm"
alias yacin="yay -S --noconfirm"
alias pacre="sudo pacman -Rns"
alias yacre="yay -Rns"
alias paclean='sudo pacman -Qdtq | sudo pacman -Rns - ; sudo fstrim -av'
alias pacache="sudo pacman -Scc --noconfirm && yay -Scc --noconfirm"
alias eclean="./.config/eclean.sh"
alias gc="git clone"
alias getw="xprop | grep WM_CLASS"
alias mkex="chmod +x"
alias ythd="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --merge-output-format mp4 -o '~/Downloads/ythd/%(title)s.%(ext)s'"
alias cldl="scdl --onlymp3 --path Downloads/sdcl -l"
alias nfetch="clear && neofetch"
alias nmli="nmcli device wifi list"
alias nmco="nmcli device wifi connect"
alias nmcomp='nmcli device wifi connect "Mon Palais"'
alias mntwin="sudo mount -t ntfs-3g /dev/nvme0n1p3 /mnt/c && sudo mount -t ntfs-3g /dev/sda1 /mnt/d && sudo mount -t ntfs-3g /dev/sdb1 /mnt/e"
alias lvzsh="lvim ~/.zshrc"
alias lvbsh="lvim ~/.bashrc"
alias lvpac="sudo lvim /etc/pacman.conf"
alias lvbsp="lvim ~/.config/bspwm/bspwmrc"
alias lvhyp="lvim ~/.config/hypr/hyprland.conf"
alias lvags="lvim ~/.config/ags/config.js"
alias lvsxh="lvim ~/.config/sxhkd/sxhkdrc"
alias lvpic="sudo lvim ~/.config/picom/picom.conf"
alias ptd="pnpm tauri dev"
alias prd="pnpm run dev"
alias pvpn="protonvpn-cli c --cc US -p udp"
alias pvpc="protonvpn-cli c"
alias pvpd="protonvpn-cli d"
alias ls="ls -l --group-directories-first --color"
alias cdar="cd /home/archkye/arch_progs/"

#.Net Aliases
alias vsgit='wget -O .gitignore  https://raw.githubusercontent.com/github/gitignore/main/VisualStudio.gitignore'
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
#export WEBKIT_DISABLE_COMPOSITING_MODE=1
#export RUST_BACKTRACE=1
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig/
#export PKG_CONFIG_SYSROOT_DIR=/

# pnpm
export PNPM_HOME="/home/archkye/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Load Angular CLI autocompletion.
#source <(ng completion script)

PATH=~/.console-ninja/.bin:$PATH
