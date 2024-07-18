package_manager=""

which apt > /dev/null 2>&1
if [ $? -eq 0 ]; then
    package_manager="apt-get install -y "
elif which dnf > /dev/null 2>&1; then
    package_manager="dnf install -y "
elif which yum > /dev/null 2>&1; then
    package_manager="yum install -y "
else
    echo "Error: No supported package manager found."
    exit 1
fi

echo "Package manager command: $package_manager"

packages="git htop pip ripgrep nodejs gcc firefox tmux bat"

for VAR in $packages
do
    ${package_manager} $VAR
done
