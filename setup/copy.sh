DIR=$(echo $PWD)
OLDDIR="$HOME/.olddotfiles"

mkdir $OLDDIR

for file in $(ls ../files); do
	mv ~/.$file $OLDDIR/
	ln -s $DIR/../files/$file $HOME/.$file
done

mv ~/.config/nvim $OLDDIR/nvim
ln -s $DIR/../config/nvim $HOME/.config/nvim

echo "export PATH=\"$PATH:$DIR/../bin\"" >> ~/.bashrc
echo ". $DIR/../bin/z" >> ~/.bashrc
