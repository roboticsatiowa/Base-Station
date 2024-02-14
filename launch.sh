#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Attempting to connect to remote host"
ssh robotics@uirobotics.local "source ~/Rover/remote_launch.sh" || (echo "WARNING: Failed to connect to remote host")


if tmux has-session -t ros2
    then tmux kill-session -t ros2
fi

tmux new-session -d -s ros2
tmux send-keys -t ros2 "source ${SCRIPT_DIR}/install/setup.sh && ros2 launch base_station base_station.launch.py" C-m
