export PYENV_ROOT="${HOME}/.pyenv"
export RBENV_ROOT="${HOME}/.rbenv"
export PLENV_ROOT="${HOME}/.plenv"
export GOENV_ROOT="${HOME}/.goenv"
export GOPATH="${HOME}/go"
export NDENV_ROOT="${HOME}/.ndenv"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

if [[ "$(uname)" == 'Darwin' ]]; then
    # /etc/paths が優先されるので、一旦無効にしてから path_helper を呼び出し、最後にシステムパスを追加する
    setopt no_global_rcs
    if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
    fi
    PATH_COREUTILS="/usr/local/opt/coreutils/libexec/gnubin"
    PATH_CURL="/usr/local/opt/curl/bin"
    PATH_GPG_AGENT="/usr/local/opt/gpg-agent/bin"
    PATH_TAR="/usr/local/opt/gnu-tar/libexec/gnubin"

    export PATH="${PATH_COREUTILS}:${PATH_GPG_AGENT}:${PATH_CURL}:${PATH_TAR}:${PATH}"
    export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig:${PKG_CONFIG_PATH}"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:/usr/local/opt/gnu-tar/libexec/gnuman:${MANPATH}"
    if [[ -d /usr/local/share/zsh-syntax-highlighting/highlighters ]]; then
        export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters;
    fi
fi

export PATH=$PYENV_ROOT/shims:$RBENV_ROOT/shims:$PLENV_ROOT/shims:$GOENV_ROOT/shims:$GOPATH/bin:$NDENV_ROOT/shims:$PATH
if which npm > /dev/null; then
    export NODE_PATH=$(npm root -g)
fi
typeset -U path manpath

source ~/.key_list
