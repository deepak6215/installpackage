#!/bin/bash

cd /home/iplon/repos
wget https://github.com/deepak6215/iot_6/raw/master/iot6_ubuntu14.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/report_docker.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/serverData.tar.xz

wget https://dl.grafana.com/oss/release/grafana_9.0.7_amd64.deb
sudo dpkg -i grafana_9.0.7_amd64.deb
service grafana-server restart

wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.0-1_amd64.deb
sudo dpkg -i telegraf_1.12.0-1_amd64.deb
service telegraf restart

wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.5_amd64.deb
sudo dpkg -i influxdb_1.8.5_amd64.deb
service influxdb restart

tar -xJf serverData.tar.xz -C /

sudo apt update -y
sleep 5;
sudo usermod -aG docker $USER
service docker restart
sleep 10;
sudo docker load -i iot6_ubuntu14.tar.gz
sleep 5;
sudo docker run --name iot6_ubuntu14.04 --net host -v /var/www/:/var/www/ -v /var/run/mysqld/:/var/run/mysqld/ -v /var/lib/mysql/:/var/lib/mysql/ -v /var/lib/snmp/:/var/lib/snmp/ -v /opt/iplon/:/opt/iplon/ -itd iot6_php5.5:2.0

#report docker container installation
docker load -i report_docker.tar.gz
sleep 5;
docker run -d --name report-api --restart on-failure:5 -p 83:83 --network="host" report_docker:latest
sleep 5;
sudo docker update --restart unless-stopped $(docker ps -q)

curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE "iSolar"'
chown -R iplonftp:ftpaccess /home/iplonftp/csvbackup/
chown -R iplonftp:ftpaccess /home/iplonftp/Scheduled_Report
mount --bind /var/www/csvbackup /home/iplonftp/csvbackup
mount --bind /var/www/report/export/Scheduled_Report /home/iplonftp/Scheduled_Report
#sed -i "s/anlagen_id=0000/anlagen_id=$SERVER_ID/g" $IPLON_PACKAGE_PATH/scripts/vpn.sh
#sed -i "s/xxx/$PLANT_NAME/g" /var/www/iSolar/fetchDDT/data.json
#sed -i "s/XXX/$MYSQL_PASS/g" /var/www/iSolar/fetchDDT/data.json
#sed -i "s/xxx/$MYSQL_PASS/g" /var/www/DO/db_config.php
#sed -i "s/xxx/$MYSQL_PASS/g" /var/www/iSolar/powercontrol/db_config.php
#sed -i "s/xxx/$MYSQL_PASS/g" /var/www/alarmlist/db_config.php
chown -R iplonshare:shareaccess /home/iplonshare/Scheduled_Report
mount --bind /var/www/report/export/Scheduled_Report /home/iplonshare/Scheduled_Report

service ssh restart
service ntp restart
systemctl enable scaback
service readDDT start
systemctl enable readDDT
service scaback restart
service scabackFast start
systemctl enable scabackFast
service readDDTFast start
systemctl enable readDDTFast
service vsftpd restart
