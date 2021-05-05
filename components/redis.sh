#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install redis server"
sudo apt install redis-server >>"${LOG}"

Head "Change ip address in redis config file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf

Head "Restart redis server"
systemctl restart redis