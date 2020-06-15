FROM ubuntu
# Based on dockerfile by Joseph M. "joe@teneleven.co.uk"
ENV DEBIAN_FRONTEND noninteractive

# Install base utilities
RUN apt-get -y update && apt-get -y -q install wget ca-certificates

# Prepare sources
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add -
RUN echo "deb http://security.ubuntu.com/ubuntu precise-security main" >> /etc/apt/sources.list
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN apt-get -y update

# Install utilities from sources
RUN apt-get -y install libnss3-1d libnss3-tools dbus dpkg openjdk-8-jre google-chrome-stable xvfb unzip apparmor-utils
RUN apt-get -y update

# # Download and copy the test jar to /usr/local/bin
RUN cd /usr/local/bin
RUN wget "https://github.com/sbgabrio/gs2020/archive/master.zip"
RUN unzip master.zip


# Forward ports
EXPOSE 4444 9222

CMD ["/usr/local/bin/start.sh"]
