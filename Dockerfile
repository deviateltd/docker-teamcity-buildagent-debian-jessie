FROM debian:jessie

MAINTAINER Russell Michell <russell.michell@deviate.net.nz>

#
# Base
#

RUN apt-get update

RUN apt-get install -y php5-common php5-cli php5
RUN apt-get install -y wget unzip git

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

# Add Google public key to apt
RUN wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

# Add Google to the apt-get source list
RUN sh -c "echo deb http://dl.google.com/linux/chrome/deb/ stable main >> /etc/apt/sources.list"
RUN apt-get update
RUN apt-get -y install openjdk-7-jre google-chrome-stable xvfb unzip

# Get Selenium
RUN wget -q https://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar

RUN sh -c "echo Starting Xvfb ..."
RUN Xvfb :10 -screen 0 1366x768x24 -ac &

RUN sh -c "echo Starting Google Chrome ..."
RUN google-chrome --remote-debugging-port=9222 &

RUN sh -c "echo Starting Selenium ..."
RUN nohup java -jar ./selenium-server-standalone-2.48.2.jar 2> /dev/null

#
# Provision 
#

#ADD buildagentsetup.sh /tmp/buildagentsetup.sh
ADD NuGet.exe /tmp/NuGet.exe
ADD Microsoft.Build.dll /tmp/Microsoft.Build.dll
ADD docker.config /etc/default/docker

EXPOSE 9090

CMD bash /tmp/buildagentsetup.sh
