export PYENV_ROOT="${HOME}/.pyenv"
export RBENV_ROOT="${HOME}/.rbenv"
export PLENV_ROOT="${HOME}/.plenv"
export GOENV_ROOT="${HOME}/.goenv"
export GOPATH="${HOME}/go"
export NDENV_ROOT="${HOME}/.ndenv"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

if [[ "$(uname)" == 'Darwin' ]]; then
    PATH_COREUTILS="/usr/local/opt/coreutils/libexec/gnubin"
    PATH_CURL="/usr/local/opt/curl/bin"
    PATH_GPG_AGENT="/usr/local/opt/gpg-agent/bin"
    PATH_TAR="/usr/local/opt/gnu-tar/libexec/gnubin"

    export PATH="${PATH_COREUTILS}:${PATH_GPG_AGENT}:${PATH_CURL}:${PATH_TAR}:${PATH}"
    export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig:${PKG_CONFIG_PATH}"
    export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:/usr/local/opt/gnu-tar/libexec/gnuman:${MANPATH}"
    if [[ -d /usr/local/share/zsh-syntax-highlighting/highlighters ]]; then
        export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters;
    fi
fi

export PATH=$PYENV_ROOT/shims:$RBENV_ROOT/shims:$PLENV_ROOT/shims:$GOENV_ROOT/shims:$GOPATH/bin:$NDENV_ROOT/shims:$PATH

source ~/.key_list
