declare -A osInfo;
osInfo[/etc/debian_version]="apt-get install -y"
osInfo[/etc/alpine-release]="apk --update add"
osInfo[/etc/centos-release]="yum install -y"
osInfo[/etc/fedora-release]="dnf install -y"
osInfo[/etc/amazon-linux-release]="dnf install -y"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done

echo "Package manager command: $package_manager"

packages="git htop"

${package_manager} ${packages}

if [ ${PWD/*\//} != "dotfiles" ]; then
    git clone https://github.com/Colton-K/dotfiles.git
    cd dotfiles
    ./setup.sh
    exit
fi

# set vars
DIR=$(echo $PWD)
OLDCONFIGDIR="$HOME/.olddotfiles"
FILES="profile bashrc gitconfig vim vimrc zshrc Xresources tmux.conf"

# fuzzy finder - shouldn't need root to install it
which fzf 2> /dev/null
if test $? -gt 0; then
    echo "-----------------------"
    echo "Install fuzzy finder..."
    #sudo apt-get install -y fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

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

# add bin files to path
echo "export PATH=\$PATH:$DIR/bin"
echo "export PATH=\"\$PATH:$DIR/bin\"" >> "$DIR/bashrc" # add bin files

# reload config files
xrdb ~/.Xresources
source ~/.bashrc
