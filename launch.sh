#!/bin/bash

echo "Attempting to connect to remote host"
ssh robotics@uirover.local "source ~/Code/Rover/remote_launch.sh" || (echo "WARNING: Failed to connect to remote host")

source install/setup.bash
ros2 launch base_station base_station.launch.py
