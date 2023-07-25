# don't put duplicate lines or lines starting with space in the history.
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
shopt -s globstar

# case insensitive globbing
shopt -s nocaseglob

# spelling autocorrect
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

getGIT() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[1;36m\]$(getGIT) \[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias gs="git status"

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    
    alias schoolssh='ssh -X ckammes@student02.cse.nd.edu'

    alias gpu="sudo system76-power graphics"
    alias profile="system76-power profile"
    alias shutdown="sudo shutdown -h now"
    alias n="nautilus ."
    alias ne="nautilus . && exit"
    alias wgetall="wget --level=inf --recursive --page-requisites --user-agent=Mozilla --no-parent --convert-links --adjust-extension --no-clobber -e robots=off "

    alias vi="nvim"
    alias c="xclip -sel c"
    alias v="xclip -o -sel c"


    # for mplab to control pic microcontroller
    alias mp="sudo mplab_ide"
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

PS1=$PS1"\n$ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash



RED="31"
GREEN="32"
BLUE="34"
BOLDBLUE="\e[1;${BLUE}m"
BOLDGREEN="\e[1;${GREEN}m"
UNDERLINEDGREEN="\e[4;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

# make man pages look nice!
export LESS_TERMCAP_mb=$'\e[1;32m' # main highlighted color
export LESS_TERMCAP_md=$'\e[1;32m' # ^ 34 for blue
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m' # variable name color
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;4;32m' # bottom bar color
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal


# export LESS_TERMCAP_mb="${BOLDBLUE}" # main highlighted color
# export LESS_TERMCAP_md=${BOLDBLUE} # ^
# export LESS_TERMCAP_me=${ENDCOLOR}
# export LESS_TERMCAP_se=${ENDCOLOR}
# export LESS_TERMCAP_so=${BOLDGREEN} # variable name color
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=${BOLDGREEN} # bottom bar color
# export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

alias crc="ssh ckammes@crcfe01.crc.nd.edu"
alias crcfs="mkdir -p remotefs && sshfs ckammes@crcfe01.crc.nd.edu:/afs/crc.nd.edu/user/c/ckammes/ remotefs "

# make using tmux nice
alias tmux="env TERM=xterm-256color tmux"

# allow for proper alt tab
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab', '<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  "['<Alt><Shift>Tab', '<Super><Shift>Tab']"

. /home/colton/work/dotfiles/bin/z

export PATH="$PATH:/home/colton/bin"
export PATH="$PATH:/home/colton/work/dotfiles/bin"
