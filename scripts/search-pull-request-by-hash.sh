#!/usr/bin/env bash

input="$1"

if [ -z "$input" ]; then
    tput cup $(($(tput lines) - 1)) 0
    echo -n "Search Pull Request by hash: "
    read input
fi

gh pr list --search "$input" --state all --json number,title,url,author,createdAt > /tmp/pr_results.json

jq -r '.[] | "\(.number): \(.title) (by \(.author.login))"' /tmp/pr_results.json | 
    fzf --preview 'echo {1} | tr -d ":" | xargs -I% jq -r ".[] | select(.number == (% | tonumber))" /tmp/pr_results.json' \
    --bind 'enter:execute(echo {1} | tr -d ":" | xargs -I% jq -r ".[] | select(.number == (% | tonumber)) | .url" /tmp/pr_results.json | xargs open)'

