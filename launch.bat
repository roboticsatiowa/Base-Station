@echo off
echo Connecting to the rover...
ssh robotics@uirover.local "./Rover/launch.sh" || goto :failed_to_connect
timeout /t 1 /nobreak >nul

:end
exit /b 0

:failed_to_connect
set /p CONTINUE=Failed to connect to the rover. Continue? [y/N] 
if /i "%CONTINUE%" neq "y" (
    echo Exiting...
    exit /b 1
)
exit /b 0