@echo off

set "SCRIPT_DIR=%~dp0"

set "LAYOUT_1=5faa9223-f6d8-408d-a2f4-30302bfc3b9b"
set "LAYOUT_2=3cc814f4-b002-4cb1-8d6b-ea2dee8e2fc2"

set "FOXGLOVE_URL_1=https://app.foxglove.dev/uiowarobotics/view?openIn=desktop^&ds=foxglove-websocket^&ds.url=ws%%3A%%2F%%2Flocalhost%%3A8765^&layoutId=%LAYOUT_1%"
set "FOXGLOVE_URL_2=https://app.foxglove.dev/uiowarobotics/view?openIn=desktop^&ds=foxglove-websocket^&ds.url=ws%%3A%%2F%%2Flocalhost%%3A8765^&layoutId=%LAYOUT_2%"

echo Connecting to the rover...
ssh robotics@uirover.local "./Rover/launch.sh" && goto :success
timeout /t 1 /nobreak > nul

set /p CONTINUE=Failed to connect to the rover. Continue? [y/N] 
if /i "%CONTINUE%" neq "y" (
    echo Exiting...
    exit /b 1
)

@REM ensure docker is installed
docker -v > nul || (
    echo Docker is not installed. Please install Docker and try again.
    exit /b 1
)

@REM ensure python is installed
python3 -V > nul || (
    echo Python is not installed. Please install Python and try again.
    exit /b 1
)

@REM ensure docker is running
docker ps > nul || (
    echo Docker is not running. Please start Docker and try again.
    exit /b 1
)

@REM Build the base station
docker buildx build -t base-station:latest %SCRIPT_DIR%

:run
@REM Run the base station
echo Creating docker container...
docker container kill base-station 2> nul
docker container rm base-station 2> nul
docker run -d -p 8765:8765 -p 7492:7492 --name base-station base-station:latest > nul

@REM open the base station in the brow  ser. kill foxglove if it's already running
taskkill /f /im "Foxglove Studio.exe" 2> nul > nul && echo "Foxglove Studio was already running. Restarting..."
start "" %FOXGLOVE_URL_1% || echo "Failed to open the browser automatically. Telemetry: %FOXGLOVE_URL_1%"
start "" %FOXGLOVE_URL_2% || echo "Failed to open the browser automatically. Cameras:   %FOXGLOVE_URL_2%"

python3 %SCRIPT_DIR%/gamepad/gamepad.py
  
