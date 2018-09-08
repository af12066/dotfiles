export GOPATH=$HOME/go
export PATH=/usr/local/opt/openssl/bin:$HOME/.anyenv/bin:$GOPATH/bin:/usr/local/sbin:$PATH
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export XDG_CONFIG_HOME=$HOME/.config
export ZPLUG_HOME=/usr/local/opt/zplug
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

source ${HOME}/.env.sh
