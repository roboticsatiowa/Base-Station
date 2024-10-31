# syntax=docker/dockerfile:1

FROM ros:humble-ros-core-jammy

RUN apt-get update && apt-get install -y \
    ros-humble-foxglove-bridge \
    ros-humble-joy \
    && rm -rf /var/lib/apt/lists/

COPY ./entrypoint /entrypoint
    
EXPOSE 8765
ENTRYPOINT ["/entrypoint"]