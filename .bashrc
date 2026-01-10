# *********************************************************DATEOMATIC: Sun Jun 29 10:07:30 AM EDT 2025
# *********************************************************HASHOMATIC: cc5af9180b9d81b3a41391e2a13bcd0b
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# disable color support of ls and grep
alias ls='ls --color=never'
alias grep='grep --color=never'
alias fgrep='fgrep --color=never'
alias egrep='egrep --color=never'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# some git aliases
alias unstaged='git diff --name-only'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source ~/bash.library
source ~/bashrc.shared
source ~/bashrc.local


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export JAVA_HOME=/home/mestes/jdk-23.0.2
export PATH=$PATH:$JAVA_HOME/bin

echo $PATH > /tmp/pppp
cat /tmp/pppp


mkdir -p                     ~/BACKUPS
backup_file   .bashrc        ~/BACKUPS
backup_file   bashrc.shared  ~/BACKUPS
backup_file   bash.library   ~/BACKUPS
backup_file   .vimrc         ~/BACKUPS


function XXXTROWSACTUAL() {
         local void=1    # Bash-Function-Args
  local rows=$(tput lines)
  echo "$rows"
}
function XXXTROWS() {
         local offset=$1    # Bash-Function-Args
  local rows=$(odd_or_less $(tput lines)) # Use 'local' to keep variables within the function's scope.
  (( rows= rows + offset ))
  echo "$rows"
}

# Function to check if any tracked files have uncommitted changes
function xxgit_has_uncommitted_changes() {
    echo "true"
}
function git_has_uncommitted_changes() {
  # Check if there are any changes in tracked files (modified, added, deleted)
  # -s (or --porcelain) gives a stable, easy-to-parse format
  # -uall (or --untracked-files=all) shows all untracked files
  # --exclude-standard excludes files ignored by .gitignore
      if [[ -n $(git status --porcelain --untracked-files=no) ]]; then
        echo "true"
      else
        echo "false"
      fi
}
function git_uncommitted() {
  local void="";           # Bash-Function-Args
  local sz=""  
  if [ -d ".git" ]; then
    if [[ $(git_has_uncommitted_changes) == "true" ]]; then
        sz="c"
    else
        sz="n"
    fi
  fi

  echo "$sz"
}

function git_changecount() {
         local void="0";                          # Bash-Function-Args
     local tmp1=$(mktemp)
     if [ -d ".git" ]; then
        git diff --name-only           > $tmp1
        git diff --name-only --staged >> $tmp1
        cat $tmp1 | sort | uniq | wc -l
     fi
     rm -f "$tmp1" >/dev/null 2>&1
}

# show up to 3 parent dirs, except ~, resolve all other dir aliases
function git_toplevel() {
         local void="11";                          # Bash-Function-Args
     if [ -d ".git" ]; then
         git rev-parse --show-toplevel 2> /dev/null | sed -e "s,^$HOME,~,"
     fi
}
function git_branch() {
         local void="11";                          # Bash-Function-Args
     #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     if [ -d ".git" ]; then
         git branch --show-current 2> /dev/null | \
         sed 's/master/m/' | \
         sed 's/archival/a/'
     fi
}
function git_origin() {
         local void="11";                          # Bash-Function-Args
     # git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     if [ -d ".git" ]; then
         git config --get remote.origin.url 2> /dev/null
     fi
}
function git_originsync() {
         local void="11";                          # Bash-Function-Args
     if [ -d ".git" ]; then
         git config color.ui false
         git branch -vv 2> /dev/null |  gawk 'match($0, /\[([^\]]+)\]/, a) { print a[1] }' | sed 's/origin/o/' | sed 's/master/m/' | sed 's/ ahead /+/'
     else
         echo ""
     fi
}
function collapse_pwd() {
         local void="11";                          # Bash-Function-Args
    curr_pwd=$(pwd | sed -e "s,^$HOME,~,")
    echo $curr_pwd
}
function collapse_hostname() {
         local void="11";                          # Bash-Function-Args
    curr_hostname=$(hostname)
    echo $curr_hostname
}
function prompt_pos() {
  local rows=$(tput lines)
  local col=1
  ((row=rows-2))
  printf "\033[${row};${col}H"
  util.print.color blue "-----------------------------------"
  ((row=rows-1))
  printf "\033[${row};${col}H"
  printf "\033[K"
}

# Example usage:
# if [[ $(git_has_uncommitted_changes) == "true" ]]; then
#   echo "There are uncommitted changes in tracked files."
# else
#   echo "No uncommitted changes in tracked files."
# fi
# How it works:git status --porcelain: This command outputs the status of your working directory and staging area in a machine-readable format.--untracked-files=no: This option tells git status to not show untracked files. We are only interested in tracked files that have changed.--exclude-standard: This option ensures that files ignored by your .gitignore are not considered.-n $(...): This checks if the output of the git status command is non-empty. If there's any output, it means there are changes.The function returns "true" if changes are found, and "false" otherwise.


# export PS1='$(collapse_hostname) $(collapse_pwd) ($(git_toplevel):$(git_branch):$(git_originsync):$(git_uncommitted)$(git_changecount))>> '

export PS1='$(hostname) \
$(pwd | sed -e "s,^$HOME,~,") \
($(if [ -d ".git" ]; then git branch --show-current 2> /dev/null; fi)) \
($(if [ -d ".git" ]; then git diff --name-only --cached | wc -l; else echo "n"; fi),\
$(if [ -d ".git" ]; then git status --porcelain | wc -l; else echo "n"; fi)) \
>> '


