echo "installing fzf"
which fzf 2&> /dev/null
if test $? -gt 0; then
	echo "-----------------------"
	echo "Install fuzzy finder..."
	# sudo apt-get install -y fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
fi

CWD=$(pwd)
Z_DIR="$CWD/../bin/z"
echo ". $Z_DIR" >> ~/.exports
