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
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_FIND_NO_DUPS
  setopt COMPLETE_IN_WORD
  setopt SHARE_HISTORY
  setopt APPEND_HISTORY
  
  #Plugins
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
  source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

  ZSH_AUTOSUGGEST_STRATEGY=(history completion)

  #Binds
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[[1;5C' forward-word  # Ctrl + Right
  bindkey '^[[1;5D' backward-word  # Ctrl + Left
  bindkey '^H' backward-kill-word # Ctrl + Backspace
  bindkey "^L" clear-screen # Ctrl + L
  
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  
fi
autoload -Uz compinit
compinit

# Aliases
source ~/.profile

# PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.console-ninja/.bin:$PATH"

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
eval "$(direnv hook zsh)"

eval "export PATH="/run/user/1000/fnm_multishells/112983_1716601015197/bin":$PATH
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/112983_1716601015197"
export FNM_DIR="/home/archkye/.local/share/fnm"
export FNM_COREPACK_ENABLED="false"
export FNM_ARCH="x64"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_LOGLEVEL="info"
export FNM_RESOLVE_ENGINES="false"
autoload -U add-zsh-hook
_fnm_autoload_hook () {
    if [[ -f .node-version || -f .nvmrc ]]; then
    fnm use --silent-if-unchanged
fi

}

add-zsh-hook chpwd _fnm_autoload_hook \
    && _fnm_autoload_hook

rehash"
eval "$(fnm env --use-on-cd)"

# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/archkye/.bun/_bun" ] && source "/home/archkye/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
