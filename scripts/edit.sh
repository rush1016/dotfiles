#!/bin/bash

dotfiles=~/.dotfiles
selected=`ls $dotfiles | grep -v edit | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

cd $dotfiles
tmux neww -n config bash -c "nvim $dotfiles/$selected & while [ : ]; do sleep 1; done"
