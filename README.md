# Teamcity build agent
Docker image for Debian Jessie teamcity build agent, no agent install but all the dependencies are.

## Build
docker build -t deviateltd/teamcitybuildagent-debian-jessie:latest  .

## Push
docker push deviateltd/teamcitybuildagent-debian-jessie

##Run
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e TEAMCITY_SERVER=http://192.168.1.100:8111 -e TEAMCITY_BUILDAGENTNAME=Agent1 -dt -p 9090:9090 deviateltd/teamcitybuildagent-debian-jessie

