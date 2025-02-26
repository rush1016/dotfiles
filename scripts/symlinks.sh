#!/bin/bash

###############################
# .make.sh
# This script will add the symlinks to each config files
###############################

dir=~/.dotfiles
old_dir=~/.dotfiles-old
user_bin=~/.local/bin

# Files in $HOME
home_config_dirs="zsh tmux"

# Files in ~/.config
config_dir=~/.config
config_files="aerospace nvim lazygit"

mkdir -p $old_dir

cd $dir

echo "Creating symlinks for \$HOME config files"
for home_config_dir in $home_config_dirs; do
    for file in $(ls -A $dir/$home_config_dir); do
        mv ~/.$file $old_dir/ 2> /dev/null
        ln -s $dir/.$file ~/.$file 2> /dev/null
    done
done
echo "done..."

echo "Creating symlinks for ~/.config files"
mkdir -p $old_dir/.config
for config in $config_files; do
    mv $config_dir/$config $old_dir/.config
    ln -s $dir/$config $config_dir
done
echo "done..."

echo "Creating symlinks for other bin scripts"
mkdir -p $user_bin
mkdir -p $old_dir/.local/bin
for binary in $(ls $dir/.local/bin); do
    mv $user_bin/$binary $old_dir/.local/bin/
    ln -s $dir/.local/bin/$binary $user_bin/$binary
done
