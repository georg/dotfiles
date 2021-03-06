export EDITOR="/usr/local/bin/vim"
export LESS="-erX"
export BROWSER="open /Applications/Safari.app"
export LC_CTYPE=en_AU.UTF-8
export LEFTRIGHT=1
export AWS_DEFAULT_REGION=us-east-1

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
fi

# Make up/down keys autocomplete
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

function proml {
  local YELLOW="\[\033[0;33m\]"
  local   BLUE="\[\033[0;34m\]"
  local  GREEN="\[\033[0;32m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=''
    ;;
  esac

  PS1="${TITLEBAR}$GREEN\h:$BLUE\w $YELLOW\$(parse_git_branch)$GREEN\$ "
  PS2='> '
  PS4='+ '
}
proml
unset proml

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/share/chruby/chruby.sh ] && source /usr/local/share/chruby/chruby.sh
[ -f /usr/local/share/chruby/auto.sh ] && source /usr/local/share/chruby/auto.sh
