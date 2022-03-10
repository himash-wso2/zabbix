#!/bin/sh

apt-get update

apt-get install libcurl3 zabbix-agent -y

cd /etc/zabbix/

################################
## Configure the zabbix agent ##
################################

sed -i 's/127.0.0.1/prod-zabbix-lk.wso2.com/g' zabbix_agentd.conf

HOSTNAME=$(cat /etc/hostname)

sed -i 's/Zabbix server/'"$HOSTNAME"'/g' zabbix_agentd.conf

###########################################
## Edit localhost file & start the agent ##
###########################################

echo "192.168.8.95 prod-zabbix-lk.wso2.com" >> /etc/hosts

/etc/init.d/zabbix-agent restart

echo "PLEASE MAKE SURE THE HOSTNAME IS CORRECT IN GOOGLE SHEET. INSTALLATION SUCCESSFULL"
