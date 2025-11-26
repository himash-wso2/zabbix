#!/bin/sh

mkdir /home/zabbixagent

cd /home/zabbixagent

##############################################
# Download & Install zabbix agent for Ubuntu #
##############################################

wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb

dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb

apt update

apt install zabbix-agent -y

cd /etc/zabbix/

################################
## Configure the zabbix agent ##
################################

sed -i 's/127.0.0.1/192.168.8.95/g' zabbix_agentd.conf

HOSTNAME=$(cat /etc/hostname)

sed -i 's/Zabbix server/'"$HOSTNAME"'/g' zabbix_agentd.conf

echo "AllowKey=system.run[*]" >> /etc/zabbix/zabbix_agentd.conf

echo "LogRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf

rm -fr /home/zabbixagent

##############################
## Start & enable the agent ##
##############################

systemctl restart zabbix-agent

systemctl enable zabbix-agent

echo "INSTALLATION SUCCESSFULL"
