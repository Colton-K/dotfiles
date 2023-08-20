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

which fzf 2> /dev/null
if test $? -gt 0; then
	echo "-----------------------"
	echo "Install fuzzy finder..."
	sudo apt-get install -y fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
fi

