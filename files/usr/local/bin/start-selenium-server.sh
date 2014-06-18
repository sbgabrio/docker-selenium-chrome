#!/bin/bash

export DISPLAY=:99
# /etc/init.d/xvfb start
Xvfb :10 -screen 0 1366x768x24 -ac &
echo "Starting Google Chrome ..."
sudo google-chrome --remote-debugging-port=9222 &
java -Dwebdriver.chrome.driver=/usr/local/bin/chromedriver -jar /usr/local/bin/selenium-server-standalone-2.42.2.jar
