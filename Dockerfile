# syntax=docker/dockerfile:1

FROM ros:humble-ros-core-jammy
#From repository
ARG RMW_ZENOH_REPO=https://github.com/ZettaScaleLabs/rmw_zenoh.git
ARG RMW_ZENOH_BRANCH=dev/1.0.0
#
RUN apt-get update && apt-get install -y \
    ros-humble-foxglove-bridge \
    && rm -rf /var/lib/apt/lists/
#From Repository
RUN apt update -y
RUN apt upgrade -y

RUN apt install -y \
    curl \
    ros-humble-demo-nodes-cpp \
    ros-humble-ament-cmake-vendor-package

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
ENV PATH="/root/.cargo/bin:$PATH"
RUN rustup toolchain install 1.75.0
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

RUN mkdir ~/ws_rmw_zenoh/src -p \
&& cd ~/ws_rmw_zenoh/src \
&& git clone ${RMW_ZENOH_REPO} --branch ${RMW_ZENOH_BRANCH} \
&& cd ~/ws_rmw_zenoh \
&& rosdep update \
&& rosdep install --from-paths src --ignore-src --rosdistro humble -y \
&& . /opt/ros/humble/setup.sh \
&& colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN cargo binstall zellij -y 

EXPOSE 8765
CMD bash -c "source /opt/ros/humble/setup.bash && ros2 launch foxglove_bridge foxglove_bridge_launch.xml port:=8765"