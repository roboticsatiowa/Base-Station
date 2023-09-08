# kill processes from previous launch
killall python
killall python3

# Begin camera feeds
python .\run_video.py 192.168.1.13 55555 cam1 &
python .\run_video.py 192.168.1.13 55556 cam2 &
python .\run_video.py 192.168.1.13 55558 cam3 &

# Begin control feed
python .\run.py 192.168.1.13 55559 &