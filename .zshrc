export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which plenv > /dev/null; then eval "$(plenv init -)"; fi
if which goenv > /dev/null; then eval "$(goenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which ndenv > /dev/null; then eval "$(ndenv init -)"; fi

# 履歴管理
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history  # 履歴の共有
setopt hist_ignore_dups  # 直前と同じコマンドを履歴に残さない
setopt hist_ignore_all_dups  # 重複するコマンドを履歴に残さない
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_no_store  # 履歴にhistoryコマンドを記録しない

function buildgo() {
    go fmt $1 && go build $1
}

if uname | grep "Darwin" > /dev/null; then
    alias brwe='brew'
    alias vim='mvim -v'
    alias -s html='open -a Google\ Chrome'
elif uname | grep "Linux" > /dev/null; then
    alias -s html='firefox -new-tab'
fi
alias suod='sudo'
alias weather='curl http://wttr.in/'
alias -s py='python'
alias -s go=buildgo
alias -s txt='cat'
alias -s {jpg,jpeg,png,pdf}='open -a Preview'
alias l='ls -G'
alias ls='ls -G'
alias la='ls -laG'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias '..'='cd ..'
if `which pry > /dev/null`; then alias irb='pry'; fi


# 入力補完
autoload -U compinit
compinit -C
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
setopt auto_list  # 補完候補があるときに一覧表示
setopt auto_menu  # 補完候補があるときに自動表示
setopt list_packed  # 補完結果を詰めて表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 大文字・小文字を区別しない

zstyle ':completion:*' use-cache yes  # 補完候補のキャッシュ
zstyle ':completion:*' cache-path ~/.zsh/cache  # キャッシュの保管場所
zstyle ':completion:*' verbose no

# 訂正
setopt correct
setopt correct_all

setopt autocd
setopt auto_pushd

if which peco > /dev/null; then
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
fi

if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

pandoc_embed_html () {
  pandoc --self-contained -s -t html5 -c ~/.pandoc/pandoc.css $@
}

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

if [ -d /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
