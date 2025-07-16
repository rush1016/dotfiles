#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quit Docker Desktop
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🐳
# @raycast.packageName Docker

echo "Stopping Docker containers..."
running_containers=$(docker ps -q)

if [ -n "$running_containers" ]; then
    echo "Stopping running containers..."
    docker stop $running_containers
else
    echo "No running containers found. Skipping stop."
fi

echo "Attempting to quit Docker Desktop..."
osascript -e 'quit app "Docker"'

# Wait a few seconds to allow graceful exit
sleep 3

# Check if Docker is still running
if pgrep -f "Docker Desktop" > /dev/null; then
    echo "Docker Desktop still running. Forcing shutdown..."
    pkill -f "Docker Desktop"
else
    echo "Docker Desktop exited cleanly."
fi
