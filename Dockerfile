FROM debian:jessie

MAINTAINER Russell Michell <russell.michell@deviate.net.nz>

#
# Base
#

RUN apt-get update

RUN apt-get install -y php5-common php5-cli php5
RUN apt-get install -y wget unzip git
RUN apt-get install -y openjdk-7-jre-headless

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D 
RUN sh -c "echo deb https://apt.dockerproject.org/repo debian-jessie main > /etc/apt/sources.list.d/docker.list"

RUN apt-cache policy docker-engine
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get -y install docker-engine
RUN apt-get -y install php5-mysql

#
# For Behat testing
#

#===============
# Google Chrome
#===============
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

#==================
# Chrome webdriver
#==================
ENV CHROME_DRIVER_VERSION 2.20
RUN wget --no-verbose -O /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

#========================
# Selenium Configuration
#========================
COPY config.json /opt/selenium/config.json

#=================================
# Chrome Launch Script Modication
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

#
# Provision 
#

ADD buildagentsetup.sh /tmp/buildagentsetup.sh
ADD NuGet.exe /tmp/NuGet.exe
ADD Microsoft.Build.dll /tmp/Microsoft.Build.dll
ADD docker.config /etc/default/docker

EXPOSE 9090

CMD bash /tmp/buildagentsetup.sh
