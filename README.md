# Teamcity build agent
Docker image for teamcity build agent, no agent install but all the dependencies are.

## Build
docker build -t deviateltd/teamcitybuildagent:latest  .

## Push
docker push deviateltd/teamcitybuildagent

##Run
docker run --privileged -v /var/run/docker.sock:/var/run/docker.sock -e TEAMCITY_SERVER=http://192.168.1.100:8111 -e TEAMCITY_BUILDAGENTNAME=Agent1 -dt -p 9090:9090 deviateltd/teamcitybuildagent

