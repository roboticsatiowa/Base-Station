#!/bin/bash

# ros2 launch base_station base_station.launch.py
# ssh ethan@raspberrypi.local 

if ! tmux has-session -t ros2
    then tmux new-session -d -s ros2
    tmux send-keys -t ros2 "echo test" C-m
    echo balls;
fi
