ssh robotics@uirobotics.local "tmux kill-session -t ros2" || (echo "WARNING: Failed to connect to remote host")