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

packages="git"

${package_manager} ${packages}

if [ ${PWD/*\//} != "dotfiles" ]; then
    git clone https://github.com/Colton-K/dotfiles.git
    cd dotfiles
    ./setup.sh
    exit
fi
