export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# env 一式の設定
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
setopt hist_reduce_blanks  # 余計な空白を削除して履歴保存
setopt hist_verify  # 履歴を呼び出してから実行までに一旦編集できるように
setopt hist_no_store  # 履歴にhistoryコマンドを記録しない

# typo 修正やエイリアスの設定
if [[ "$(uname)" == "Darwin" ]]; then
    alias brwe='brew'
    alias vim='mvim -v'
    if [[ -e /Applications/Google\ Chrome.app ]]; then alias -s html='open -a Google\ Chrome'; fi
    alias -s {jpg,jpeg,png,pdf}='open -a Preview'
    if [[ -e /Applications/Google\ Chrome.app ]]; then alias chrome='open -a Google\ Chrome'; fi
    alias itunes='open -a iTunes'
    if [[ -e /Applications/Visual\ Studio\ Code.app ]]; then alias vscode='open -a Visual\ Studio\ Code'; fi
    if [[ -e /Applications/Slack.app ]]; then alias slack='open -a Slack'; fi
elif [[ "$(uname)" == "Linux" ]]; then
    alias -s html='firefox -new-tab'
fi
alias suod='sudo'
alias wttr='curl http://wttr.in/'
alias -s py='python'
alias -s txt='cat'
alias l='ls -G'
alias ls='ls -G'
alias la='ls -laG'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias '..'='cd ..'
if $(which pry > /dev/null); then alias irb='pry'; fi
if $(which ipython > /dev/null); then alias python='ipython'; fi

# 入力補完
if [[ -d /usr/local/share/zsh-completions ]]; then
    chmod go-w '/usr/local/share'
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=2  # 補完候補を矢印キーで選択できるように
if [[ -f ~/.dircolors ]]; then eval $(dircolors ~/.dircolors); fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # ls をカラフルに
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'  # Tab キーでいい感じに補完してくれる

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
setopt auto_list  # 補完候補があるときに一覧表示
setopt auto_menu  # 補完候補があるときに自動表示
setopt list_packed  # 補完結果を詰めて表示

zstyle ':completion:*' use-cache yes  # 補完候補のキャッシュ
zstyle ':completion:*' cache-path ~/.zsh/cache  # キャッシュの保管場所
zstyle ':completion:*' verbose no

# 訂正
setopt correct
setopt correct_all

# ディレクトリ名を入力するだけで cd する
setopt autocd
# cd したら pushd に追加して、popd で戻れるようにする
setopt auto_pushd

# peco
if $(which peco > /dev/null); then
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

# zsh-syntax-highlighting
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestions
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

setopt promptsubst  # 終了ステータスを表示

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
 %# '
RPROMPT='%(?.%2F.%1F) %? ↩︎%f'
