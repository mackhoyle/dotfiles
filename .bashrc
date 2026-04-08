# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export LD_LIBRARY_PATH=/home/mhoyle/libevent_install/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/mhoyle/libevent_install/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH="$HOME/tmux:$PATH"
export GOROOT=$HOME/go-local/go
export GOPATH=$HOME/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/cmake-local/bin:$PATH"
export PATH="$HOME/neovim/build/bin:$PATH"



# Dotfiles bare repo
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# User specific aliases and functions
#function grepn { grep -Ir --exclude-dir=.git --exclude-dir=.svn --include \*.4gl --include \*.per "N $@" ; }
#function grepf { grep -Ir --exclude-dir=.git --exclude-dir=.svn --include \*.4gl --include \*.per "$@" ; }
#function grepa { grep -Ir --exclude-dir=.git --exclude-dir=.svn "$@" ; }
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function o4 { find -H $VDXDIR -name "$@*.4gl" -exec vim {} \; ;}


function kr {
  su -c 'ps -aux | grep restMain.42m | grep -v grep | tr -s " " |  cut -d " " -f 2 | xargs printf "%s " | xargs kill -9';
}
function kx {
  su -c 'ps -aux | grep main_xapi.42m | grep -v grep | tr -s " " |  cut -d " " -f 2 | xargs printf "%s " | xargs kill -9';
}




[ -f ~/.fzf.bash ] && source ~/.fzf.bash




