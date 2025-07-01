#!/usr/bin/env bash
case $1 in
    "b") tmux neww -n node-build bash -c "npm run build";;
    "d") tmux neww -n node-dev bash -c "npm run dev";;
    "w") tmux neww -n lerna-watch bash -c "npm run watch";;
    "s") 
        working_dir=$(basename $(pwd))
        if [[ $working_dir == 'qstrike-builder' ]]; then
            cmd="cd packages/demo && npm run start"
        else
            cmd="npm run start"
        fi  

        tmux neww -n node-dev bash -c "$cmd"
        ;;
    "r") 
        working_dir=$(basename $(pwd))
        if [[ $working_dir == 'qstrike-builder' ]]; then
            tmux neww -n lerna-watch bash -c "npx nx reset"
        fi
        ;;
esac
