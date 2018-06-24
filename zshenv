export GOPATH=$HOME/go
export PATH=/usr/local/sbin:/usr/local/opt/openssl/bin:$HOME/.anyenv/bin:$GOPATH/bin:$PATH
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export XDG_CONFIG_HOME=$HOME/.config
export ZPLUG_HOME=/usr/local/opt/zplug
