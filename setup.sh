#!/bin/bash

# set vars
DIR=$(echo $PWD)
OLDCONFIGDIR="$HOME/.olddotfiles"
FILES="profile bashrc gitconfig vim vimrc zshrc Xresources tmux.conf"

# TODO: install git
sudo apt-get install git 
if test $? -gt 0; then
    echo "Failed to install git"
fi

# nodejs server needed for coc.nvim vim plugin - installs to $HOME/.local to avoid needing root privilidges
which node 2> /dev/null
if test $? -gt 0; then
    echo "--------------"
    echo "Install nodejs"
    curl -sL install-node.now.sh/lts | bash -s -- --prefix=$HOME/.local
fi

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

# reload config files
xrdb ~/.Xresources
source ~/.bashrc
