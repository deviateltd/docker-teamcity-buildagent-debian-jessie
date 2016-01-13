# Teamcity build agent

    Docker image for Debian Jessie teamcity build agent, no agent install but all the dependencies are.

## Build

    docker build -t deviateltd/teamcitybuildagent-debian-jessie:latest  .

Use --no-cache=true to skip the cache if you want to re-build.

## Push

Assumes you have access to the "deviateltd" account on dockerhub.com and a project called "teamcitybuildagent-debian-jessie" under the "deviateltd" namespace.

    docker push deviateltd/teamcitybuildagent-debian-jessie

## Run

    docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock \
	-e TEAMCITY_SERVER=http://192.168.1.100:8111 \
	-e TEAMCITY_BUILDAGENTNAME=Agent1 \
	-e DISPLAY=:10
	-e BEHAT_PARAMS="extensions[SilverStripe\BehatExtension\MinkExtension][base_url]=http://192.168.1.100:8111/" 
	-dt -p 9090:9090 \
	deviateltd/docker-teamcity-buildagent-debian-jessie
    docker ps (Note the "ContainerID")

## Connect

In order to connect and run shell commands in your container using bash.

    docker start <ContainerID>
    docker attach <ContainerID> 
    docker exec -it <ContainerID> bash

