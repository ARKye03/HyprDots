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
  source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
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

#Arch Linux Aliases
alias pacsu="sudo pacman -Syu --noconfirm && yay -Syu"
alias pacsuw='sudo pacman -Syu --noconfirm --config /etc/pacman-warp.conf && yay -Syu --noconfirm --config /etc/pacman-warp.conf'
alias pacin="sudo pacman -S --noconfirm"
alias yacin="yay -S --noconfirm"
alias pacre="sudo pacman -Rns"
alias yacre="yay -Rns"
alias paclean='sudo pacman -Qdtq | sudo pacman -Rns - ; sudo fstrim -av'
alias pacache="sudo pacman -Scc --noconfirm && yay -Scc --noconfirm"
alias eclean="./.config/eclean.sh"

#AstroNvim Aliases
alias avzsh="nvim ~/.zshrc"
alias avbsh="nvim ~/.bashrc"
alias avpac="sudo nvim /etc/pacman.conf"
alias avbsp="nvim ~/.config/bspwm/bspwmrc"
alias avhyp="nvim ~/.dotfiles/.config/hypr/hyprland.conf"
alias avags="nvim ~/.dotfiles/.config/ags/"
alias avsxh="nvim ~/.config/sxhkd/sxhkdrc"
alias avnvim="nvim ~/.config/nvim/"
alias avpic="sudo nvim ~/.config/picom/picom.conf"

#ProtonVPN
alias pvpn="protonvpn-cli c --cc US -p udp"
alias pvpc="protonvpn-cli c"
alias pvpd="protonvpn-cli d"

#NMCLI
alias nmli="nmcli device wifi list"
alias nmco="nmcli device wifi connect"
alias nmcomp='nmcli device wifi connect "Mon Palais"'

#OTHERS
alias getw="xprop | grep WM_CLASS"
alias mkex="chmod +x"
alias ythd="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --merge-output-format mp4 -o '~/Downloads/ythd/%(title)s.%(ext)s'"
alias cldl="scdl --onlymp3 --path Downloads/sdcl -l"
alias nfetch="clear && neofetch"
alias ptd="pnpm tauri dev"
alias prd="pnpm run dev"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lsa="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cdar="cd ~/arch_progs/"
alias codeX="code ~/.dotfiles"
alias lvimX="lvim ~/.dotfiles"
# alias nvimX="nvim ~/.dotfiles"
# alias zedX="Zed ~/.dotfiles"

# Git Aliases
alias gc="git clone"
alias gs="git status"
alias gss="git status -s"
alias ga="git add"
alias gaa="git add --all"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gbr="git branch"
alias gbd="git branch -d"
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gp="git push"
alias gpf!="git push --force"
alias gf="git fetch"
alias gd="git diff --name-only --relative --diff-filter=d | xargs bat --diff"
alias gr="git restore"
alias gplm="git pull origin main"
alias gpsm="git push origin main"
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias gm="git merge"
alias gmom='git merge origin/$(git_main_branch)'
alias grs="git restore"
alias gsw="git switch"
alias gswc="git switch -c"
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'
alias gts="git tag -s"
alias gtv="git tag | sort -V"


#.Net Aliases
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

# Make Aliases
alias mr='make run'
alias mp='make prune'
alias mc='make create'

# PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
PATH=~/.console-ninja/.bin:$PATH

export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# pnpm
export PNPM_HOME="/home/archkye/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

