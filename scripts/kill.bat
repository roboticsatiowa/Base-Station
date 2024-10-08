@echo off
taskkill /f /im "Foxglove Studio.exe"
docker container kill base-station > nul
docker container rm base-station > nul