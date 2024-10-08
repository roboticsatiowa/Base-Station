#! /usr/bin/env bash

docker kill base-station  || true
docker rm base-station || true
ps -ef | grep 'foxglove' | grep -v grep | awk '{print $2}' | xargs -r kill -9