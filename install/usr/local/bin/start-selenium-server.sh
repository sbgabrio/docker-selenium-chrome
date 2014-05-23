#!/bin/bash

export DISPLAY=:99
/etc/init.d/xvfb start
echo "Starting Google Chrome ..."
google-chrome --remote-debugging-port=9222 &
java -Dwebdriver.chrome.driver=/selenium/chromedriver -jar /selenium/selenium-server-standalone-2.41.0.jar 
