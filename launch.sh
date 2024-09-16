#! /usr/bin/env bash

function failed_to_connect {
    read  -r -p "Failed to connect to the rover. Continue? [y/N] " CONTINUE
    if [ "$CONTINUE" != "y" ]; then
        echo "Exiting..."
        exit 1
    fi
}

echo "Connecting to the rover..."
ssh robotics@uirover.local "./Rover/launch.sh" || failed_to_connect
sleep 1

if [ "$(docker container ls -aqf name=base-station)" ]; then
    read -r -p "Base station is already running. Do you want to restart it? [Y/n] " RESTART
    if [ "${RESTART:-'y'}" == "y" ]; then
        echo "Launching the base station..."
        docker stop base-station
        docker rm base-station
        docker run --detach --expose 8765 --name base-station base-station:latest > /dev/null 2>&1
    fi
else
    echo "Launching the base station..."
    docker run --detach --expose 8765 --name base-station base-station:latest > /dev/null 2>&1
fi
sleep 1
xdg-open https://app.foxglove.dev/ > /dev/null 2>&1 || echo "Failed to open the browser. Please navigate to https://app.foxglove.dev/ to view the base station."