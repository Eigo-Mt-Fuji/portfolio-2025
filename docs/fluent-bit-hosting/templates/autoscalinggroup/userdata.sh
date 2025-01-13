#!/bin/bash

# kernel parameter turning
cat <<EOL >> /etc/sysctl.conf
net.core.rmem_default=262144
net.core.wmem_default=262144
net.core.rmem_max=262144
net.core.somaxconn=16000
net.ipv4.tcp_max_syn_backlog=16000
net.ipv4.tcp_tw_reuse=1
net.core.wmem_max=262144
vm.swappiness=10
net.core.netdev_max_backlog=2048
net.ipv4.tcp_fin_timeout=30
net.ipv4.ip_local_port_range=16384 65535
EOL
sysctl -p

# ulimit setting
touch /etc/security/limits.d/50-default.conf
cat <<EOL >> /etc/security/limits.d/50-default.conf
#<domain>      <type>  <item>         <value>
#

*               -       nofile          65535
EOL

# ecs setting
echo ECS_CLUSTER=${ecs_cluster} >> /etc/ecs/ecs.config
echo ECS_LOGLEVEL=error >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"json-file\",\"awslogs\",\"fluentd\"] >> /etc/ecs/ecs.config
echo ECS_ENABLE_SPOT_INSTANCE_DRAINING=true >> /etc/ecs/ecs.config

dnf install -y aws-cfn-bootstrap
/opt/aws/bin/cfn-signal --stack ${stack_name} --resource AutoScalingGroup --region ap-northeast-1