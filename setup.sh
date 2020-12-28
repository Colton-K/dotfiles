#!/bin/bash

# set vars
DIR=$(echo $PWD)
OLDCONFIGDIR="$HOME/.olddotfiles"
FILES="bashrc gitconfig vim vimrc zshrc Xresources"
ZSHTHEMES="ckammes"


# check your privilidge
if [ "$1" != "noroot" ]; then
    # root
    # install zsh and omz if needed
    which zsh 2> /dev/null
    if test $? -eq 0; then
        echo "Already installed ZSH"
    else
        # update
        echo "------------------"
        echo "Updating system..."
        sudo apt-get update
        sudo apt-get upgrade qq
        sudo apt-get install zsh
        
        chsh -s /usr/bin/zsh
    fi

    which wget 2> /dev/null
    if ! test $? -eq 0; then
        echo "Install wget because wget doesn't exist in $WGET"
        sudo apt-get -y install wget
    fi

    which git 2> /dev/null
    if ! test $? -eq 0; then
        echo "Install git because git doesn't exist in $GIT"
        sudo apt-get -y install git
    fi
    # install programs
    # sublime text
    which subl 2> /dev/null
    if test $? -gt 0; then
        echo "-----------------------"
        echo "Install sublime text..."
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        sudo apt-get install -y apt-transport-https
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt-get update qq
        sudo apt-get install -y sublime-text
    fi

    # fuzzy finder
    which fzf 2> /dev/null
    if test $? -gt 0; then
        echo "-----------------------"
        echo "Install fuzzy finder..."
        #sudo apt-get install -y fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi

    # vim
    which vim 2> /dev/null
    if test $? -gt 0; then
        echo "-----------------------"
        echo "Install vim..."
        sudo apt-get install -y vim
    fi
fi

which zsh 2> /dev/null
if test $? -gt 0; then
    OH_MY_ZSH=$HOME/.oh-my-zsh/oh-my-zsh.sh
    if test -f "$OH_MY_ZSH"; then
        echo "Already exists oh-my-zsh in $OH_MY_ZSH"
        exit
    else
        echo "Press Ctrl-D once zsh opens"
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    fi
fi

# link oh-my-zsh theme to correct folder
echo "----------------------------------"
echo "Create sym links for $ZSHTHEMES in $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme"

for zshTheme in $ZSHTHEMES; do
    if test -L $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme; then
        # if it is a link to something, remove the link
        rm $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme
    elif test -f $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme; then
        # if it is a file, move it to old directory
        mv $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme $OLDCONFIGDIR/$zshTheme.zsh-theme
    fi
    ln -s $DIR/$zshTheme.zsh-theme $HOME/.oh-my-zsh/themes/$zshTheme.zsh-theme
done

# create symbolic links for $files
echo "-----------------------------------"
echo "Create sym links for $FILES in $HOME"
cd $HOME

for file in $FILES; do
    # check if there is already a file there
    if test -f ".$file"; then
        # if so, move it to a oldconfig directory
        if [ ! -d "$OLDCONFIGDIR" ]; then
            mkdir $OLDCONFIGDIR
        fi
        mv .$file $OLDCONFIGDIR/.$file
    elif test -d ".$file"; then # catches case where 'file' is a directory - ex custom vim colors
        if [ ! -d "$OLDCONFIGDIR" ]; then
            mkdir $OLDCONFIGDIR
        fi
        mv .$file $OLDCONFIGDIR/.$file
    fi
    # create a symlink
    ln -s $DIR/$file ~/.$file
done
