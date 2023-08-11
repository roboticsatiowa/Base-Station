# Find and kill instances of run_video.py and run.py

# Search and kill run_video.py instances
$videoProcesses = Get-Process | Where-Object { $_.ProcessName -eq "python" -and $_.MainWindowTitle -match "run_video.py" }
if ($videoProcesses.Count -gt 0) {
    Write-Host "Killing run_video.py instances..."
    $videoProcesses | ForEach-Object { Stop-Process -Id $_.Id -Force }
    Write-Host "Killed run_video.py instances."
} else {
    Write-Host "No run_video.py instances found."
}

# Search and kill run.py instances
$runProcesses = Get-Process | Where-Object { $_.ProcessName -eq "python" -and $_.MainWindowTitle -match "run.py" }
if ($runProcesses.Count -gt 0) {
    Write-Host "Killing run.py instances..."
    $runProcesses | ForEach-Object { Stop-Process -Id $_.Id -Force }
    Write-Host "Killed run.py instances."
} else {
    Write-Host "No run.py instances found."
}
