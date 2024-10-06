# syntax=docker/dockerfile:1

FROM ros:humble-ros-core-jammy

RUN apt-get update && apt-get install -y \
    ros-humble-foxglove-bridge \
    && rm -rf /var/lib/apt/lists/

    
EXPOSE 8765
CMD bash -c "source /opt/ros/humble/setup.bash && ros2 launch foxglove_bridge foxglove_bridge_launch.xml port:=8765 address:=127.0.0.1"