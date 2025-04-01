#!/usr/bin/env bash

tput cup $(tput lines)
echo -n "Search Pull Request by hash: "
read hash

gh pr list --search "$hash" --state all --json number,title,url,author,createdAt > /tmp/pr_results.json

tmux neww -n pr-results bash -c "
  jq -r '.[] | \"\(.number): \(.title) (by \(.author.login))\"' /tmp/pr_results.json | 
  fzf --preview 'echo {1} | tr -d \":\" | xargs -I% jq -r \".[] | select(.number == (% | tonumber))\" /tmp/pr_results.json' \
      --bind 'enter:execute(echo {1} | tr -d \":\" | xargs -I% jq -r \".[] | select(.number == (% | tonumber)) | .url\" /tmp/pr_results.json | xargs open)'
"

