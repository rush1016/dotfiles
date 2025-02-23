#!/bin/bash

selected=`ls | fzf`

if [ $selected ]; then
    tmux neww bash -c "nvim $selected & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "nvim & while [ : ]; do sleep 1; done"
fi
