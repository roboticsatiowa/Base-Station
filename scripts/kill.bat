@echo off
taskkill /f /im "Foxglove Studio.exe" 2> nul > nul && echo Killed Foxglove Studio
docker container kill base-station 2> nul > nul && echo Killed base-station container
docker container rm base-station 2> nul > nul && echo Removed base-station container