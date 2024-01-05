package_manager="apt-get install -y "
which apt > /dev/null 2>&1
if test $? -gt 0; then
    package_manager="dnf install -y "
fi

echo "Package manager command: $package_manager"

packages="git htop"
echo "Package manager command: $package_manager"

packages="git htop pip ripgrep nodejs gcc firefox z"

${package_manager} ${packages}

which fzf 2> /dev/null
if test $? -gt 0; then
	echo "-----------------------"
	echo "Install fuzzy finder..."
	sudo apt-get install -y fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
fi
