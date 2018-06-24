eval "$(anyenv init -)"

bindkey -e

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_no_store
setopt autocd
setopt auto_pushd

autoload -U compinit
compinit

function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# Aliases
if (( $+commands[nvim] )); then
  alias vim=nvim
fi
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
zstyle ':vcs_info:git:*' stagedstr "%{%F{yellow}%}✅ "
zstyle ':vcs_info:git:*' unstagedstr "%{%F{red}%}🌟 "
zstyle ':vcs_info:*' formats "%{%F{green}%}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd() {
    LANG=en_US.UTF-8 vcs_info
}
PROMPT='%{%6F%}%n%f%{%5F%}@%f%{%3F%}%m%f %{%14F%}%~%f ${vcs_info_msg_0_}
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

if [[ -e /Applications/Docker.app ]]; then
  source /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion
  source /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion
fi
