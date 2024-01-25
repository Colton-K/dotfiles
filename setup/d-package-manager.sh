package_manager="apt-get install -y "
which apt > /dev/null 2>&1
if test $? -gt 0; then
    package_manager="dnf install -y "
fi

echo "Package manager command: $package_manager"

packages="git htop pip ripgrep nodejs gcc firefox tmux"

for VAR in $packages
do
    ${package_manager} $VAR
done
