FROM base

MAINTAINER Jeremy Seago "seagoj@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install base utilities
RUN apt-get -y -q install wget ca-certificates

# Prepare sources
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
RUN echo "deb http://security.ubuntu.com/ubuntu precise-security main" >> /etc/apt/sources.list
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN apt-get update
# RUN dpkg --configure -a
# RUN apt-get install -f

# Upstart workaround
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# Install utilities from sources
RUN apt-get -y install libnss3-1d dbus dpkg openjdk-7-jre google-chrome-stable xvfb unzip

# # Download and copy the ChromeDriver to /usr/local/bin
RUN cd /tmp
RUN wget "http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip"
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/local/bin
RUN wget "http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar"
RUN mv selenium-server-standalone-2.42.2.jar /usr/local/bin

# # Start Xvfb, Chrome, and Selenium in the background
RUN export DISPLAY=:10
RUN Xvfb :10 -screen 0 1366x768x24 -ac &
RUN google-chrome --remote-debugging-port=9222 &
RUN nohup java -jar /usr/local/bin/selenium-server-standalone-2.42.2.jar &

# Forward ports
EXPOSE 4444
EXPOSE 9222
