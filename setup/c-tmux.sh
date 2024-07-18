PLUGIN_FOLDER="$HOME/Documents/plugins"

PLUGIN_LIST="tmux-plugins/tmux-continuum tmux-plugins/tmux-resurrect tmux-plugins/tmux-cowboy ofirgall/tmux-window-name"

# clone repos to folder
# more resources: https://github.com/tmux-plugins/list?tab=readme-ov-file
for PLUG in $PLUGIN_LIST
do
    path="$PLUGIN_FOLDER/$PLUG"
    git clone https://github.com/$PLUG.git "$path"
    if [ $? -ne 0 ]; then
        echo "\t**Already cloned $PLUG"
        continue
    fi
    echo "run-shell $path/*.tmux" >> ~/.tmux.conf
done
