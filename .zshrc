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

