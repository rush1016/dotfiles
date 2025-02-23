#!/bin/bash

###############################
# .make.sh
# This script will add the symlinks to each config files
###############################

dir=~/.dotfiles
old_dir=~/.dotfiles-old

# Files in $HOME
home_config_files="zshrc tmux.conf"

# Files in ~/.config
config_dir=~/.config
config_files="aerospace nvim lazygit"

mkdir -p $old_dir

cd $dir

echo "Creating symlinks for \$HOME config files"
for file in $home_config_files; do
    mv ~/.$file $old_dir/ 2> /dev/null
    ln -s $dir/.$file ~/.$file 2> /dev/null
done
echo "done..."

echo "Creating symlinks for ~/.config files"
mkdir -p $old_dir/.config
for config in $config_files; do
    mv $config_dir/$config $old_dir/.config
    ln -s $dir/$config $config_dir
done
echo "done..."
