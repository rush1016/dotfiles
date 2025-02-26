#!/usr/bin/env bash

selected=`echo 'dev build' | tr ' ' '\n' | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

tmux neww -n node-${selected} bash -c "npm run ${selected}"
