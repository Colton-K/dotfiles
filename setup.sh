#!/bin/bash

# set vars
DIR="/home/colton/work/dotfiles"
OLDCONFIGDIR="/home/colton/olddotfiles"
FILES="bashrc gitconfig vim vimrc zshrc"

# update
sudo apt-get update
sudo apt-get -y upgrade

# install zsh and omz if needed (borrowed code)
ZSH=/usr/bin/zsh
if test -f "$ZSH"; then
    echo "Already installed ZSH"
else
    sudo apt-get install zsh
    chsh -s /usr/bin/zsh
    unset ZSH
    WGET=/usr/bin/wget
    if ! test -f "$WGET"; then
        echo "Install wget because wget doesn't exist in $WGET"
        sudo apt-get -y install wget
        unset WGET
    fi
    GIT=/usr/bin/git
    if ! test -f "$GIT"; then
        echo "Install git because git doesn't exist in $GIT"
        sudo apt-get -y install git
        unset GIT
    fi
    OH_MY_ZSH=/root/.oh-my-zsh/oh-my-zsh.sh
    if test -f "$OH_MY_ZSH"; then
        echo "Already exists oh-my-zsh in $OH_MY_ZSH"
        exit
    else
        echo "Press Ctrl-D once zsh opens"
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    fi
fi

# link oh-my-zsh theme to correct folder
ln -s ckammes.zsh-theme $HOME/.oh-my-zsh/themes/

# install programs
# sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get -y install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get -y update
sudo apt-get -y install sublime-text

# fuzzy finder
sudo apt-get -y install fzf

# create symbolic links for $files
echo -n "Changing to the home directory $HOME\n"
cd $HOME

for file in $FILES; do
    echo "processing $file"

    # check if there is already a file there
    if test -f ".$file"; then
        # if so, move it to a oldconfig directory
        if [ ! -d "$OLDCONFIGDIR" ]; then
            mkdir $OLDCONFIGDIR
        fi
        mv .$file $OLDCONFIGDIR/.$file
    elif test -d "$file"; then # catches case where 'file' is a directory - ex custom vim colors
        if [ ! -d "$OLDCONFIGDIR" ]; then
            mkdir $OLDCONFIGDIR
        fi
        mv .$file $OLDCONFIGDIR/.$file
    fi
    # create a symlink
    ln -s $DIR/$file ~/.$file
done

