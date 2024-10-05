#Core
alias snvim="sudo -E nvim"

#Arch Linux
alias pacsu="sudo pacman -Syu --noconfirm && yay -Syu"
alias pacin="sudo pacman -S --noconfirm"
alias yacin="yay -S --noconfirm"
alias pacre="sudo pacman -Rns"
alias yacre="yay -Rns"
alias paclean='sudo pacman -Qdtq | sudo pacman -Rns - ; sudo fstrim -av'
alias pacache="sudo pacman -Scc --noconfirm && yay -Scc --noconfirm"

#AstroNvim
alias avzsh="nvim ~/.dotfiles/.zshrc"
alias avdots="nvim ~/.dotfiles/"
alias avbsh="nvim ~/.dotfiles/.bashrc"
alias avpac="snvim ~/.dotfiles/public/pacman.conf"
alias avhyp="nvim ~/.dotfiles/dot-config/hypr"
alias avags="nvim ~/.dotfiles/dot-config/ags/"
alias avnvim="nvim ~/.dotfiles/dot-config/nvim/"

#ProtonVPN
alias pvpn="protonvpn-cli c --cc US -p udp"
alias pvpc="protonvpn-cli c"
alias pvpd="protonvpn-cli d"

#NMCLI
alias nmli="nmcli device wifi list"
alias nmco="nmcli device wifi connect"
alias nmcomp='nmcli device wifi connect "Mon Palais"'

#OTHERS
alias mkex="chmod +x"
alias ythd="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '~/Downloads/Video/%(title)s.%(ext)s'"
alias cldl="scdl --onlymp3 --path Downloads/sdcl -l"
alias nfetch="clear && neofetch"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lsa="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="/usr/bin/ls -al"
alias cdar="cd ~/arch_progs/"
alias codedots="code ~/.dotfiles"
alias codeags="code ~/.dotfiles/dot-config/ags/"
alias zdots="cd ~/.dotfiles/"
alias curl='noglob curl'
alias spwmusic='/usr/bin/mpd ~/.config/mpd/mpd.conf; /usr/bin/mpd-mpris --no-instance --host 127.0.0.1 & disown'

# Node & Bun
alias ptd="pnpm tauri dev"
alias prd="pnpm run dev"

alias btd="bun tauri dev"
alias brd="bun run dev"

# Ripgrep
alias rgfs='rg --fixed-strings --'

# Git Aliases

# Clone
alias gc="/usr/bin/git clone"

# Status
alias gs="/usr/bin/git status"
alias gss="/usr/bin/git status -s"

# Add
alias ga="/usr/bin/git add"
alias gaa="/usr/bin/git add --all"

# Commit
alias gcm="/usr/bin/git commit -m"

# Checkout and Switch
alias gco="/usr/bin/git checkout"
alias gcob="/usr/bin/git checkout -b"
alias gsw="/usr/bin/git switch"
alias gswc="/usr/bin/git switch -c"
alias gswm='/usr/bin/git switch $(git_main_branch)'
alias gswd='/usr/bin/git switch $(git_develop_branch)'

# Branch
alias gbr="/usr/bin/git branch"
alias gbd="/usr/bin/git branch -d"

# Bisect
alias gbs="/usr/bin/git bisect"
alias gbss="/usr/bin/git bisect start"
alias gbsc="/usr/bin/git bisect continue"
alias gbsg="/usr/bin/git bisect good"
alias gbsb="/usr/bin/git bisect bad"
alias gbsr="/usr/bin/git bisect reset"

# Log
alias glog="/usr/bin/git log --oneline --decorate --graph --all"

# Log
alias glog="/usr/bin/git log --oneline --decorate --graph --all"

# Pull
alias gpl="/usr/bin/git pull"
alias gplr="/usr/bin/git pull --rebase"
alias gplm="/usr/bin/git pull origin main"
alias ggpull='/usr/bin/git pull origin "$(git_current_branch)"'

# Push
alias gp="/usr/bin/git push"
alias gpf!="/usr/bin/git push --force"
alias gpsm="/usr/bin/git push origin main"
alias ggpush='/usr/bin/git push origin "$(git_current_branch)"'

# Fetch
alias gf="/usr/bin/git fetch"
alias gfa="/usr/bin/git fetch --all --prune"

# Restore
alias gr="/usr/bin/git restore"

# Merge
alias gm="/usr/bin/git merge"
alias gmom='/usr/bin/git merge origin/$(git_main_branch)'

# Stash
alias gst="/usr/bin/git stash"
alias gsta="/usr/bin/git stash apply"
alias gstd="/usr/bin/git stash drop"
alias gstl="/usr/bin/git stash list"
alias gstp="/usr/bin/git stash pop"

# Tag
alias gts="/usr/bin/git tag -s"
alias gtsv="/usr/bin/git tag | sort -V"

function git_current_branch() {
	git branch --show-current
}
function gd() {
	git diff --name-only --relative --diff-filter=d "$@" | xargs bat --diff
}

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
alias mkr='make run'
alias mkp='make prune'
alias mkc='make create'
alias mkd='make docs'

# Rust Aliases
alias cg='cargo'
alias cgc='cargo check'
alias cgr='cargo run'
alias cgb='cargo build'
alias cgbr='cargo build --release'

# Angular Aliases
alias ngs='ng serve'
alias ngso='ng serve --open'
alias nggc='ng generate component'

# >>> coursier install directory >>>
export PATH="$PATH:$HOME/.local/share/coursier/bin"
export PATH=$PATH:$(go env GOPATH)/bin

export GPG_TTY=$(tty)
