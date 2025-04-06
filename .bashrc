#function mhelp od aja, zisti co robi command

function mhelp() {
  whatis "$1"
  man "$1" | sed -n "/^\s*${2}/,/^$/p"
}

# set vim as default editor
export EDITOR="/usr/bin/vim"
export VIMINIT="source /home/adam/gits/dotfiles/.vimrc"
#PATH="$PATH:/usr/lib/dart/bin"
alias vi='vim'
alias nano='nano --rcfile /home/adam/gits/dotfiles/.nanorc'
alias cnode='clear; node'
alias lsa='ls --classify --almost-all'
alias ncdu='ncdu --color dark'
#kubectl bash completion
source <(kubectl completion bash)
# alias ps with c groups
alias psc='ps xawf -eo pid,user,cgroup,args'
# in man bash PROMPTING
function prompt() {
  ## just posix https://askubuntu.com/questions/640096/how-do-i-check-which-terminal-i-am-using#640105
  local emulator psgit1 pscolor1
  #emulator=$(basename "/"$(ps -o cmd -f -p "$(cat /proc/${$}/stat | cut -d ' ' -f 4)" | tail -1 | sed 's/ .*$//'))"
  #emulator=$(ps -p ${$} | tail -n 1)
  #if [[ "${emulator}" =~ .*"bash" ]]; then
  emulator="${TERM_PROGRAM}"
  #fi
  psgit1="\$(git branch 2>'/dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
  pscolor1="\[\033[36m\]${psgit1}\[\033[0m\]"

  case "${emulator##*\ }" in
  *code)
    #export PS1="${PWD##*/}%${pscolor1} "
    export PS1="\W%${pscolor1} "
    ;;
  *)
    #local hostnames=${POSHOSTNAMES:-"hp-win11 pc NP48412"}
    #if echo "$hostnames" | grep -q $(hostname); then
    local arr
    declare -A arr=(["Win11"]=1 ["pc"]=1 ["NP48412"]=1 ["pc-hp"]=1 ["ThinkPad"]=1)
    [[ -v arr[$(hostname)] ]] && export PS1="\w%${pscolor1} "
    ;;
  esac
  unset psgit1 pscolor1 emulator arr
}
prompt


# ssh
complete -W "$(awk '/^Host\s\*/{next}; /^Host/{print $2}' "${HOME}/.ssh/config" 2>'/dev/null')" ssh sftp

# Operation system specific

if [[ $(uname -o) =~ "Linux" ]]; then
	export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
else
	export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
	## git-bash specific
	export PATH=/bin:/usr/bin:$PATH # fix conflicts with win utils find,sort
fi


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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
