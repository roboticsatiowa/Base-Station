#!/bin/bash

# Kill the local session
tmux kill-session -t ros2

# Kill the remote session (TODO if the tmux session, this will falsely say "Failed to connect to remote host")
ssh robotics@uirobotics.local "tmux kill-session -t ros2"