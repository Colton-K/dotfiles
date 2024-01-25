DIR=$(echo $PWD)
OLDDIR="$HOME/.olddotfiles"

BACKUP=0
mkdir $OLDDIR
if [ $? -eq 0 ]; then # don't create circular dependencies
    echo "Backup already exists, not going to overwrite"
    BACKUP=1
    echo "2 seconds to cancel"
    sleep 2
fi

for file in $(ls ../files); do
    if [ $BACKUP -eq 1 ]; then
        mv ~/.$file $OLDDIR/
    fi

    echo "trying to link $DIR/../files/$file to $HOME/.$file"
    ln -s $DIR/../files/$file $HOME/.$file
    if [ $? -ne 0 ]; then
        echo "---> failed"
    else
        echo "---> success"
    fi
done

mv ~/.config/nvim $OLDDIR/nvim
ln -s $DIR/../config/nvim $HOME/.config/nvim

echo "export PATH=\"$PATH:$DIR/../bin\"" >> ~/.exports
