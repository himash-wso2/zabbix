#!/bin/sh

mkdir /home/zabbixagent

cd /home/zabbixagent

##############################################
# Download & Install zabbix agent for Ubuntu #
##############################################

wget https://repo.zabbix.com/zabbix/6.1/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.1-1+ubuntu20.04_all.deb

dpkg -i zabbix-release_6.1-1+ubuntu20.04_all.deb

apt update

apt install zabbix-agent -y

cd /etc/zabbix/

################################
## Configure the zabbix agent ##
################################

sed -i 's/127.0.0.1/172.30.129.9/g' zabbix_agentd.conf

HOSTNAME=$(cat /etc/hostname)

sed -i 's/Zabbix server/'"$HOSTNAME"'/g' zabbix_agentd.conf

sed -i '139,139 s/^/#/' zabbix_agentd.conf

echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf

echo "LogRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf

rm -fr /home/zabbixagent

##############################
## Start & enable the agent ##
##############################

systemctl restart zabbix-agent

systemctl enable zabbix-agent

echo "INSTALLATION SUCCESSFULL"
