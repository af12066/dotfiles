eval "$(anyenv init -)"

bindkey -e

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_no_store
setopt autocd
setopt auto_pushd

autoload -U compinit
compinit

peco-select-history() {
  if type "peco" >/dev/null 2>&1; then
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle accept-line
    zle clear-screen
  else
    autoload -Uz is-at-least

    if is-at-least 4.3.9; then
      zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
    else
      history-incremental-search-backward
    fi
  fi
}

zle -N peco-select-history

bindkey '^r' peco-select-history

# Aliases
if (( $+commands[nvim] )); then
  alias vim=nvim
fi
alias k=kubectl
alias ls="ls -G"
alias la="ls -Glah"
alias ll="ls -Glh"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ..="cd .."

case "${OSTYPE}" in
  darwin*)
    if [[ -e /Applications/Visual\ Studio\ Code.app ]]; then
      alias vscode='open -a Visual\ Studio\ Code'
    fi
    ;;
esac

setopt promptsubst
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{%F{yellow}%}"
zstyle ':vcs_info:git:*' unstagedstr "%{%F{red}%}"
zstyle ':vcs_info:*' formats "%{%F{green}%}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd() {
    LANG=en_US.UTF-8 vcs_info
}
PROMPT='%n@%m %{%14F%}%~%f ${vcs_info_msg_0_}
 %#  '
RPROMPT='%(?.%{%2F%}.%{%1F%}) %? %f'

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

# Completions
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
fi
if (( $+commands[pip] )); then
  source <(pip completion --zsh)
fi

if [[ -e /Applications/Docker.app ]]; then
  source /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion
  source /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion
fi
