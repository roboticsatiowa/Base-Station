# Stop and delete any previous jobs before starting new ones
Get-Job -Command "*python*" | Remove-Job

python .\run_video.py 192.168.1.13 55555 cam1 &
python .\run_video.py 192.168.1.13 55556 cam2 &
python .\run_video.py 192.168.1.13 55558 cam3 &

python .\run.py 192.168.1.13 55559 &