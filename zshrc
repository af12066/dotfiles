# Basic settings
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# Enable /path/to/zsh/site-functions
autoload -U compinit
compinit

# Enable vsc info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{%F{yellow}%}"
zstyle ':vcs_info:git:*' unstagedstr "%{%F{red}%}"
zstyle ':vcs_info:*' formats "%{%F{green}%}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () { vcs_info }
PROMPT='%n@%m %{%14F%}%~%f ${vcs_info_msg_0_} %# '

# Use asdf
[ /usr/local/opt/asdf/libexec/asdf.sh ] && source /usr/local/opt/asdf/libexec/asdf.sh
# Use fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use zsh-syntax-highlighting
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias
alias vim=nvim
alias vscode='open -a /Applications/Visual\ Studio\ Code.app'
