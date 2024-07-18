
echo "check if gnome configs need to be set"
which gnome-session
if [ $? -eq 0 ]; then
    # are running gnome
    cat >> ~/.bashrc <<< "# allow for proper alt tab
    gsettings set org.gnome.desktop.wm.keybindings switch-applications \"[]\"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward \"[]\"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows \"['<Alt>Tab', '<Super>Tab']\"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  \"['<Alt><Shift>Tab', '<Super><Shift>Tab']\""
fi

echo "installing pip"
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
rm get-pip.py

echo "installing boto3"
/home/$(whoami)/.local/bin/pip install boto3 --user

/home/$(whoami)/.local/bin/pip install thefuck --user

