#!/usr/bin/bash
mkdir -p /home/buildagent/download
cd /home/buildagent/download
wget $TEAMCITY_SERVER/update/buildAgent.zip
mkdir -p /home/buildagent/buildagent
unzip -q -d /home/buildagent/buildagent buildAgent.zip
chmod +x /home/buildagent/buildagent/bin/agent.sh

rm buildAgent.zip

cat > /home/buildagent/buildagent/conf/buildAgent.properties <<EOF
  serverUrl=${TEAMCITY_SERVER}
  name=${TEAMCITY_BUILDAGENTNAME}
  workDir=../work
  tempDir=../temp
  systemDir=../system
EOF

/usr/sbin/service docker start

/home/buildagent/buildagent/bin/agent.sh run