#! /usr/bin/env bash
set -eo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

LAYOUT_1="5faa9223-f6d8-408d-a2f4-30302bfc3b9b"
LAYOUT_2="3cc814f4-b002-4cb1-8d6b-ea2dee8e2fc2"

FOXGLOVE_URL_1="https://app.foxglove.dev/uiowarobotics/view?openIn=desktop&ds=foxglove-websocket&ds.url=ws%3A%2F%2Flocalhost%3A8765&layoutId=$LAYOUT_1"
FOXGLOVE_URL_2="https://app.foxglove.dev/uiowarobotics/view?openIn=desktop&ds=foxglove-websocket&ds.url=ws%3A%2F%2Flocalhost%3A8765&layoutId=$LAYOUT_2"

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

docker buildx build -t base-station:latest $SCRIPT_DIR || (echo "Failed to build the base station." && exit 1)

# Check if the base station is already running
docker container kill base-station
docker container rm base-station
docker run --detach -p 8765:8765 --name base-station base-station:latest

# Open the browser with foxglove
echo "Opening the browser..."
sleep 1
echo
xdg-open $FOXGLOVE_URL_1 || echo "Failed to open the browser automatically. Telemetry: $FOXGLOVE_URL_1"
xdg-open $FOXGLOVE_URL_2 || echo "Failed to open the browser automatically. Cameras:   $FOXGLOVE_URL_2"