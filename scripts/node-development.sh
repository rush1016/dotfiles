#!/usr/bin/env bash
case $1 in
    "b") tmux neww -n node-build bash -c "npm run build";;
    "d") tmux neww -n node-dev bash -c "npm run dev";;
    "w") tmux neww -n node-dev bash -c "npm run watch";;
    "s") tmux neww -n node-dev bash -c "npm run start";;
esac
