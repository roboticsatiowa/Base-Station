<p align="center">
  <a href="" rel="noopener">
 <img width=600px src="images/logo.jpg" alt="Project logo"></a>
</p>

<h3 align="center">Robotics at Iowa Mars Rover Challenge</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/roboticsatiowa/Base-Station.svg)](https://github.com/roboticsatiowa/Base-Station/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/roboticsatiowa/Base-Station.svg)](https://github.com/roboticsatiowa/Base-Station/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> 
    This repository contains the code for our base station from which our mars rover is controlled.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [TODO](../TODO.md)
- [Contributing](../CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## About <a name = "about"></a>

Our rover uses 6 wheeled rocker bogie suspension system along with a 5 DOF custom arm. The onboard computing is handled by an Nvidia Jetson Xavier coupled with a Teensy 4.1 microcontroller to assist with IO. The rover is equipped with an Intel Realsense depth camera, 3 Cameras, and GPS.

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

- [ ] ROS2 Humble installed and sourced (Instructions [here](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html))
- [ ] x86 Ubuntu LTS 20.04

### Dependencies
- [ ] ```sudo apt install python3-colcon-common-extensions```

### Installing

Clone the repository into your workspace.
```bash
git clone https://github.com/roboticsatiowa/Base-Station.git
cd Base-Station
```

Check for missing dependencies and install them using rosdep.
```bash
rosdep install --from-paths src --ignore-src -r -y
```

Build and source the workspace.
```bash
colcon build
source install/setup.bash
```

### Running the code

Always make sure the workspace is sourced before running the code.
```bash
source install/setup.bash 
```


Option 1 (Recommended): Run the launch file using the launch script. This will automatically launch the rover.
```bash
source launch.sh
```
Option 2: Run the launch file directly.
```bash
ros2 launch base_station base_station.launch.py
```
Note: rover will need to be launched separately.

## Roadmap

- [ ] Moveit2 inverse kinematics
- [ ] Moveit2 motion planning
- [ ] Foxglove custom control/gui options