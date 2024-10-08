<p align="center">
  <a href="" rel="noopener">
 <img width=600px src="https://github.com/roboticsatiowa/Documents-and-Resources/raw/main/Media/Banner.png?raw=true" alt="Project logo"></a>
</p>

<h3 align="center">Robotics at Iowa Mars Rover Challenge</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/roboticsatiowa/Base-Station.svg)](https://github.com/roboticsatiowa/Base-Station/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/roboticsatiowa/Base-Station.svg)](https://github.com/roboticsatiowa/Base-Station/pulls)
[![License](https://img.shields.io/badge/license-GPL_3.0-blue.svg)](/LICENSE)

</div>

---

### Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Authors](#authors)

### About

Our rover uses ROS2 as it's core technology for teleoperation and data collection. It runs entirely within lightweight docker containers. The Base Station consists only of Foxglove Studio (GUI), foxglove_bridge, and ROS2 Joy_node. All other processing is handled locally on the rover. foxglove_bridge and the joy_node are both hosted within the docker container. Foxglove Studio can either be installed locally or run within the browser.

### Dependencies:
  - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - Any web browser (Tested with chrome)
  - [Foxglove Studio](https://foxglove.dev/download) (optional)

### Running the code

1. Download depencies (see above)
2. Clone the code `git clone https://github.com/roboticsatiowa/Base-Station`
3. Enter workspace `cd Base-Station`
4. Run launch script 
   - MacOS/Linux: `./launch.sh`   
   - Windows: `.\launch.bat`


### Authors
- [@ethanholter](https://github.com/ethanholter) - Responsible for this mess :\)