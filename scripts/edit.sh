#!/bin/bash

dotfiles=~/.dotfiles
selected=`ls $dotfiles | grep -v edit | fzf`

if [ $selected ]; then
    tmux neww -n config bash -c "nvim $dotfiles/$selected & while [ : ]; do sleep 1; done"
else
    tmux neww -n config bash -c "nvim $dotfiles & while [ : ]; do sleep 1; done"
fi
