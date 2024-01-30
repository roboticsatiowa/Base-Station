#!/bin/bash

ssh robotics@uirover.local "source ~/Code/Rover/remote_launch.sh" || (echo "Failed to connect to remote host" && return 1)

source install/setup.bash
ros2 launch base_station base_station.launch.py
