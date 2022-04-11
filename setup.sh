#!/bin/bash

# set vars
DIR=$(echo $PWD)
OLDCONFIGDIR="$HOME/.olddotfiles"
FILES="profile bashrc gitconfig vim vimrc zshrc Xresources tmux.conf"
ZSHTHEMES="ckammes"

# check your privilidge
if [ "$1" != "noroot" ]; then
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

    # glances
    which glances 2> /dev/null
    if test $? -gt 0; then
        echo "---------------"
        echo "Install glances"
        sudo apt-get install -y glances
        # sudo dnf install glances
    fi

    # vim
    which vim 2> /dev/null
    if test $? -gt 0; then
        echo "-----------------------"
        echo "Install vim..."
        sudo apt-get install -y vim
        # sudo dnf install vim-enhanced
    fi

    sudo apt-get install -y vim-gtk3
    sudo apt-get install -y ripgrep # for vim file searching
    # sudo dnf install ripgrep
fi

# nodejs server needed for coc.nvim vim plugin - installs to $HOME/.local to avoid needing root privilidges
# which node 2> /dev/null
# if test $? -gt 0; then
#     echo "--------------"
#     echo "Install nodejs"
#     curl -sL install-node.now.sh/lts | bash -s -- --prefix=$HOME/.local
# fi

# fuzzy finder - shouldn't need root to install it
which fzf 2> /dev/null
if test $? -gt 0; then
    echo "-----------------------"
    echo "Install fuzzy finder..."
    #sudo apt-get install -y fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

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

# create sym links for nvim
echo "-----------------------------------"
echo "Create sym links for nvim files"

if [ -d ".config/nvim" ]; then
    # back it up
    mv ".config/nvim" ".config/nvim_old" 
fi

# link everything
ln -s $DIR/config/nvim ~/.config/nvim

# do it for coc config too
if [ -d ".config/coc" ]; then
    # back it up
    mv ".config/coc" ".config/coc_old" 
fi
ln -s $DIR/config/coc ~/.config/coc
echo "-----------------------------------"


# add bin files to path
echo "export PATH=\$PATH:$DIR/bin"
echo "export PATH=\"\$PATH:$DIR/bin\"" >> "$DIR/bashrc" # add bin files
echo "export PATH=\"\$PATH:$DIR/bin/node-v16.14.2-linux-x64/bin\"" >> "$DIR/bashrc" # add nodejs files

# reload config files
xrdb ~/.Xresources
source ~/.bashrc
