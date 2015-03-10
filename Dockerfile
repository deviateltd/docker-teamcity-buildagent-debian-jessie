FROM ubuntu:latest

MAINTAINER Magnus Bengtsson <magnus.bengtsson@deviate.net.nz>

RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless
RUN apt-get install -y wget unzip sudo

ENV JAVA_HOME /usr/java/default

RUN adduser buildagent
ADD buildagentsetup.sh /tmp/buildagentsetup.sh

EXPOSE 9090
CMD sudo -u buildagent -s -- sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER TEAMCITY_BUILDAGENTNAME=$TEAMCITY_BUILDAGENTNAME bash /tmp/buildagentsetup.sh run"