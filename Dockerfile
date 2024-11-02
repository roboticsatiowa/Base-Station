# syntax=docker/dockerfile:1

FROM ros:humble-ros-core-jammy

SHELL [ "/bin/bash", "-c" ]

RUN apt-get update && apt-get install -y \
    ros-humble-foxglove-bridge \
    ros-humble-joy \
    ros-humble-rosbridge-server \
    && rm -rf /var/lib/apt/lists/

COPY ./entrypoint /entrypoint

# 8765: foxglove-bridge
# 7492: rosbridge
EXPOSE 8765
EXPOSE 7492
ENTRYPOINT ["/entrypoint"]