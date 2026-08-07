# .bash_profile

# Source Versaterm dev environment unconditionally (needed for VS Code, scripts)
if [ -f /usr/local/bin/setup_recenv.vtmpgsql.dev ]; then
  . /usr/local/bin/setup_recenv.vtmpgsql.dev
fi

case $- in
  *i*) ;;
  *) return ;;
esac

# Mark that we're in bash_profile so .bashrc's re-entry guard stops the loop
# when .bashrc sources us back on non-login shells.
export _BASH_PROFILE_SOURCED=1

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
CurrentHost=$(uname -n)
PS1="${LOGNAME}@${CurrentHost}> "
export PS1
DBEDIT=vim
export DBEDIT
PATH=$PATH:.:/usr/local/bin:/usr/bin:/etc:$HOME/bin
PATHBAK=$PATH:.:/usr/bin:/etc:$HOME/bin
unset USERNAME
export USERNAME PATH PATHBAK

# workmux drops new panes into a `<project>__worktrees/<branch>` sibling
# directory. Every fresh pane here is a login shell, so without this check
# the interactive environment picker below grabs the pane before anything
# else can run — its blocking `read CHOICE` swallows whatever workmux sends
# next as a single (invalid) menu selection. Skip the picker for worktree
# cwds and wire up the dev env against THIS worktree instead of the shared
# checkout (see ~/.local/bin/workmux-env.sh for why plain `cd` isn't enough).
# exec's into zsh (not bash) so these panes match every other window's shell.
case "$PWD" in
  *__worktrees/*)
    . ~/.local/bin/workmux-env.sh "$PWD"
    exec zsh -i
    ;;
esac

if ([ -t 0 ] && [ -t 1 ]) || [ -n "$TMUX" ]; then
  # your login screen here

  case "${TERM}" in
  xterm*|tmux*)
    CHOICE=0
    while [ "$CHOICE" = "0" ]; do
      clear
      echo "System:   $(uname -n)"
      echo "Terminal: $TERM"
      echo "User:     $(id)"
      echo
      echo "  1 - Launch TMUX session"
      echo "  2 - RMS Dev - Postgres"
      echo "  3 - RMS Dev - SQLServer"
      echo "  4 - RMS Dev - Informix"
      echo "  5 - RMS Dev - vtmauto"
      echo "  6 - RMS Dev - Postgres Old"
      echo "  H - Home Directory"
      echo
      echo "  N - NCIC 7.6 Dev - vtmifx"
      echo
      echo "  Q - Quit"
      echo "  C - Claude (Postgres)"
      echo "  B - SSH to Bastion"
      echo " "
      echo "Selection: "
      read CHOICE

      case "$CHOICE" in
      1)
        tmux -u a
        ;;
      2)
        SETUPFILE=setup_recenv.vtmpgsql.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        ;;
      3)
        SETUPFILE=setup_recenv.vtmsqlsvr.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        ;;
      4)
        SETUPFILE=setup_recenv.vtmifx.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        ;;
      5)
        SETUPFILE=setup_recenv.vtmauto.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        ;;
      6)
        NEWVDXDIR=/home/mhoyle/dev/usrms8.1_old
        export NEWVDXDIR
        SETUPFILE=setup_recenv.vtmpgsql.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        ;;
      [Nn])
        SETUPFILE=setup_ncic.vtmifx.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $NCICDIR
        ;;
      [Hh])
        cd $HOME
        ;;
      [Cc])
        SETUPFILE=setup_recenv.vtmpgsql.dev
        export SETUPFILE
        . /usr/local/bin/${SETUPFILE}
        cd $VDXDIR
        exec claude
        ;;
      [Bb])
        TERM=xterm ssh vcloud-bastion
        ;;
      [Qq])
        exit
        ;;
      *)
        "\nInvalid selection ... Please re-try. \n"
        CHOICE=0
        ;;
      esac
    done
    exec zsh -i
    ;;
  dumb)
    SETUPFILE=setup_recenv.vtmpgsql.dev
    export SETUPFILE
    . /usr/local/bin/${SETUPFILE}
    cd $VDXDIR
    exec zsh -i
    ;;
  esac

fi

# User specific environment and startup programs

alias rm="rm -i"
alias vi="vim"

export TERM="xterm-256color"

# Git Login status info
# git remote prune origin
# git fetch
# git branch -vva
# git status

function gui() {
  ~/VDXinvoke.sh
}

function bastion() {
  TERM=xterm ssh vcloud-bastion
}

export VTMXSL=~/stylesheets
export PATH=~/.local/bin:$PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
