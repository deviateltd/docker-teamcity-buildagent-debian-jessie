FROM ubuntu:latest

MAINTAINER Magnus Bengtsson <magnus.bengtsson@deviate.net.nz>

RUN apt-get install -y php5-common php5-cli php5
RUN apt-get install -y wget unzip git
RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"

RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get -y install lxc-docker
RUN apt-get -y install php5-mysql

ADD buildagentsetup.sh /tmp/buildagentsetup.sh
ADD docker.config /etc/default/docker

EXPOSE 9090

CMD bash /tmp/buildagentsetup.sh