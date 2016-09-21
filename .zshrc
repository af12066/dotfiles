export PATH=/usr/local/bin:$PATH

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.nodebrew/current/bin:$HOME/.pyenv/shims:$PATH"

export PYENV_ROOT="$HOME/.pyenv"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

alias brwe='brew'
alias suod='sudo'
alias weather='curl http://wttr.in/'
alias -s py='python'
alias -s html='open -a Google\ Chrome'
alias -s txt='cat'
alias -s {jpg,jpeg,png,pdf}='open -a Preview'
alias vim='mvim -v'
alias l='ls'
alias la='ls -la'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# 入力補完
autoload -U compinit
compinit -u

# 訂正
setopt correct

setopt autocd

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        awk '!a[$0]++' | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

pandoc_embed_html () {
  pandoc --self-contained -s -t html5 --mathjax=https://gist.githubusercontent.com/yohm/0c8ed72b6f18948a2fd3/raw/624defc8ffebb0934ab459854b7b3efc563f6efb/dynoload.js -c https://gist.githubusercontent.com/griffin-stewie/9755783/raw/13cf5c04803102d90d2457a39c3a849a2d2cc04b/github.css $@  }

export NODE_PATH=~/.nodebrew/current/lib/node_modules

setopt promptsubst

# vcs_info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}✅ "
zstyle ':vcs_info:git:*' unstagedstr "%F{red}🌟 "
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd() {
    LANG=en_US.UTF-8 vcs_info
}
PROMPT='%6F%n%f%5F@%f%3F%m%f %14F%~%f '
PROMPT=$PROMPT'${vcs_info_msg_0_}
 %#  '
RPROMPT='%(?.%2F.%1F) %? ↩︎%f'

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath=(/usr/local/share/zsh-completions $fpath)
