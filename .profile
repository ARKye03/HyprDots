#Arch Linux Aliases
alias pacsu="sudo pacman -Syu --noconfirm && yay -Syu"
alias pacin="sudo pacman -S --noconfirm"
alias yacin="yay -S --noconfirm"
alias pacre="sudo pacman -Rns"
alias yacre="yay -Rns"
alias paclean='sudo pacman -Qdtq | sudo pacman -Rns - ; sudo fstrim -av'
alias pacache="sudo pacman -Scc --noconfirm && yay -Scc --noconfirm"

#AstroNvim Aliases
alias avzsh="nvim ~/.dotfiles/.zshrc"
alias avdots="nvim ~/.dotfiles/"
alias avbsh="nvim ~/.dotfiles/.bashrc"
alias avpac="sudo vim /etc/pacman.conf"
alias avhyp="nvim ~/.dotfiles/dot-config/hypr/"
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
alias ffetch="clear && fastfetch"
alias ptd="pnpm tauri dev"
alias prd="pnpm run dev"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lsa="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias cdar="cd ~/arch_progs/"
alias codedots="code ~/.dotfiles"
alias codeags="code ~/.dotfiles/dot-config/ags/"
alias zdots="cd ~/.dotfiles/"
alias curl='noglob curl'
alias spwmusic='/usr/bin/mpd ~/.config/mpd/mpd.conf; /usr/bin/mpd-mpris --no-instance --host 127.0.0.1 & disown'

# Git Aliases

# Clone
alias gc="git clone"

# Status
alias gs="git status"
alias gss="git status -s"

# Add
alias ga="git add"
alias gaa="git add --all"

# Commit
alias gcm="git commit -m"

# Checkout and Switch
alias gco="git checkout"
alias gcob="git checkout -b"
alias gsw="git switch"
alias gswc="git switch -c"
alias gswm='git switch $(git_main_branch)'
alias gswd='git switch $(git_develop_branch)'

# Branch
alias gbr="git branch"
alias gbd="git branch -d"

# Bisect
alias gbs="git bisect"
alias gbss="git bisect start"
alias gbsc="git bisect continue"
alias gbsg="git bisect good"
alias gbsb="git bisect bad"
alias gbsr="git bisect reset"

# Log
alias glog="git log --oneline --decorate --graph --all"

# Log
alias glog="git log --oneline --decorate --graph --all"

# Pull
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gplm="git pull origin main"
alias ggpull='git pull origin "$(git_current_branch)"'

# Push
alias gp="git push"
alias gpf!="git push --force"
alias gpsm="git push origin main"
alias ggpush='git push origin "$(git_current_branch)"'

# Fetch
alias gf="git fetch"
alias gfa="git fetch --all --prune"

# Restore
alias gr="git restore"

# Merge
alias gm="git merge"
alias gmom='git merge origin/$(git_main_branch)'

# Stash
alias gst="git stash"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"

# Tag
alias gts="git tag -s"
alias gtsv="git tag | sort -V"

function git_current_branch() {
	git branch --show-current
}
function gd() {
	git diff --name-only --relative --diff-filter=d $@ | xargs bat --diff
}
function eclean() {
	echo "Are you sure you want to clean the cache and remove old packages?"
	echo "Type 'yes' to continue: "
	read yn
	if [ "$yn" = "yes" ]; then
		~/.dotfiles/scripts/eclean.sh
	else
		echo "Aborted."
	fi
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
alias mr='make run'
alias mp='make prune'
alias mc='make create'

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

# export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
# export LD_LIBRARY_PATH=/usr/local/lib
# export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH

export GPG_TTY=$(tty)
