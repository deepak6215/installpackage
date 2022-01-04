#!/bin/bash

cd /home/iplon/repos
wget https://github.com/deepak6215/iot_6/raw/master/iot6_ubuntu14.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/report_docker.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/serverData.tar.xz

wget https://dl.grafana.com/oss/release/grafana_7.0.6_amd64.deb
sudo dpkg -i grafana_7.0.6_amd64.deb
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
