# for color reference, see: https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt/124409#124409

# username@hostname
usernamehostname() {
   echo "%{$FG[034]%}%n@$(hostname)%{$reset_color%}" # 046 and 034 are both good colors
}

# make the directory visible
directory() {
    echo "%{$FG[033]%}%~%{$reset_color%}"
}

# show git repo if available
gitinfo() {
    echo " %{$FG[087]%}$(git_prompt_info)%{$reset_color%}"
}

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# have there be a newline and then display the prompt
moneymoneydollabill() {
    echo "$\n$"
}

# putting it all together
PROMPT='%B$(usernamehostname):$(directory)$(gitinfo)%$(moneymoneydollabill)%b '
