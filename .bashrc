export PATH="$HOME/bin:/Library/Ruby/bin:/usr/local/mysql/bin:/usr/local/bin:$PATH:/usr/local/sbin"
export JRUBY_HOME="~/src/jruby"
export HIVE_HOME=/usr/local/Cellar/hive/0.9.0/libexec
export HADOOP_HOME=/usr/local/Cellar/hadoop/1.0.3/libexec
export EDITOR="/usr/local/bin/vim"
export LESSEDIT="mate -l %lm %f"
export LESS="-erX"
export BROWSER="open /Applications/Safari.app"
export LC_CTYPE=en_AU.UTF-8
export LEFTRIGHT=1
export NODE_PATH="/usr/local/lib/node_modules"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

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

# Alias definitions
alias gitrm='git status | grep deleted | awk '\''{print $3}'\'' | xargs git rm'
alias c='bc -l <<< '
alias sunspot-solr='sunspot-solr -d ~/.solr -s ~/.solr'
#alias s='bundle exec spec'
alias rps='rake parallel:spec[9]'
alias stage='cap staging current_branch deploy'

# Make up/down keys autocomplete
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# Ruby
alias irb='irb --readline -r irb/completion'

# Capistrano
alias cppassword="grep password config/deploy.rb | awk -F\\\" '{print \$2}' | pbcopy"

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

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"

if [ -d "$HOME/.rvm" ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
  export PATH="$HOME/.rvm/bin:$PATH"
fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
