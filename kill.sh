#! /usr/bin/env bash

echo "Stopping container..."
docker stop base-station > /dev/null 2>&1 || true
echo "Removing container..."
docker rm base-station > /dev/null 2>&1 || true
echo "Done"