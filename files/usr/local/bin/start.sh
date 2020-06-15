#!/bin/bash

export DISPLAY=:10
# /etc/init.d/xvfb start
Xvfb :10 -screen 0 1400x1200x24 -ac &
echo "Launching Test Jar ..."
java -jar /usr/local/bin/gs2020.jar
