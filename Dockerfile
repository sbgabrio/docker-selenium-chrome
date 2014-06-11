FROM ubuntu

MAINTAINER Jeremy Seago "seagoj@gmail.com"

# add security package sources so that we have the latest version of libnss ( required from google-chrome )

RUN echo deb http://security.ubuntu.com/ubuntu quantal-security main restricted >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu quantal-security main restricted >> /etc/apt/sources.list
RUN echo deb http://security.ubuntu.com/ubuntu quantal-security universe >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu quantal-security universe >> /etc/apt/sources.list
RUN echo deb http://security.ubuntu.com/ubuntu quantal-security multiverse >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu quantal-security multiverse >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y -q wget unzip dpkg libnss3-1d
RUN wget --no-check-certificate -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
ADD http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip /selenium/
RUN unzip /selenium/chromedriver_linux64.zip -d /selenium
RUN echo deb http://dl.google.com/linux/chrome/deb/ stable main >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN apt-get install  libfontenc1 libfreetype6 libxfont1 x11-common xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-encodings xfonts-scalable xfonts-utils
RUN apt-get install -q -y default-jre google-chrome-stable xvfb

ADD http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar /selenium/

EXPOSE 4444
EXPOSE 9222

CMD ["/usr/local/bin/start-selenium-server.sh"]
