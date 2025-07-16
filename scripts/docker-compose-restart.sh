#!/usr/bin/env bash

if ! docker info > /dev/null 2>&1; then
    echo "Docker daemon is not running. Attempting to start Docker Desktop on macOS..."

    open -a Docker

    echo "Waiting for Docker daemon to start..."
    while ! docker info > /dev/null 2>&1; do
        sleep 1
    done

    echo "Docker daemon is now running."
else
    echo "Docker daemon is already running."
fi

running_containers=$(docker ps -q)

if [ -n "$running_containers" ]; then
    echo "Stopping running containers..."
    docker stop $running_containers
else
    echo "No running containers found. Skipping stop."
fi

echo "Starting containers via docker-compose..."
docker compose start

