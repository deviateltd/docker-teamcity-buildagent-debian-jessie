#!/usr/bin/bash
cd /tmp
wget $TEAMCITY_SERVER/update/buildAgent.zip

mkdir -p /var/buildagent
unzip -q -d /var/buildagent buildAgent.zip
chmod +x /var/buildagent/bin/agent.sh

rm buildAgent.zip

cat > /var/buildagent/conf/buildAgent.properties <<EOF
  serverUrl=${TEAMCITY_SERVER}
  name=${TEAMCITY_BUILDAGENTNAME}
  workDir=../work
  tempDir=../temp
  systemDir=../system
EOF

/var/buildagent/bin/agent.sh run