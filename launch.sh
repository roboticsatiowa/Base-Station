#! /usr/bin/env bash
set -eo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function failed_to_connect {
    read  -r -p "Failed to connect to the rover. Continue? [y/N] " REPLY
    if [[ ${REPLY:="n"} =~ [Nn] ]]; then
        echo "Exiting..."
        exit 1
    fi
}

# ========================



echo "Connecting to the rover..."
ssh robotics@uirover.local "./Rover/launch.sh" || failed_to_connect
sleep 1

# ensure docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Visit https://docs.docker.com/get-docker/ to install Docker."
    exit 1
fi

# ensure docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if the base station is already built
if [ "$(docker image ls -q base-station:latest)" == "" ]; then
    echo "Building the base station..."
    docker buildx build -t base-station:latest $SCRIPT_DIR || (echo "Failed to build the base station." && exit 1)
fi


# Check if the base station is already running
if [ "$(docker container ls -aqf name=base-station)" ]; then
    read -r -p "Base station is already running. Do you want to restart it? [Y/n] " REPLY
    if [[ ${REPLY:='y'} =~ [Yy] ]]; then
        echo "Killing base station..."
        docker stop base-station > /dev/null 2>&1
        docker rm base-station > /dev/null 2>&1
        echo "Launching base station..."
        docker run --detach -p 8765:8765 --name base-station base-station:latest
    fi
else
    echo "Launching the base station..."
    docker run --detach -p 8765:8765 --name base-station base-station:latest > /dev/null 2>&1
fi


# Open the browser with foxglove
sleep 1
xdg-open https://app.foxglove.dev/ > /dev/null 2>&1 || echo "Failed to open the browser. Please navigate to https://app.foxglove.dev/ to view the base station."