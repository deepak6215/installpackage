cd /home/iplon/repos
wget https://github.com/deepak6215/iot_6/raw/master/iot6_ubuntu14.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/report_docker.tar.gz
wget https://github.com/deepak6215/iot_6/raw/master/serverData.tar.xz
wget https://dl.grafana.com/oss/release/grafana_7.0.6_amd64.deb
sudo dpkg -i grafana_7.0.6_amd64.deb
service grafana-server restart
#service grafana-server status
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.12.0-1_amd64.deb
sudo dpkg -i telegraf_1.12.0-1_amd64.deb# Install Required (openssh-server openssh-client openvpn ntp) Packages
37
installPackage openssh-server openssh-client ntp curl git
service telegraf restart
#service telegraf status
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.5_amd64.deb
sudo dpkg -i influxdb_1.8.5_amd64.deb
service influxdb start
#service influxdb status
service influxdb restart

sudo apt-get install vim -y
sudo apt-get install tcpdump -y
sudo apt-get install screen -y
sudo apt-get install unrar -y
sudo apt-get install htop -y
sudo apt-get install dos2unix -y
sudo apt-get install expect -y
sudo apt-get install ncdu -y
sudo apt-get install sshpass -y
sudo apt-get install net-tools -y
sudo apt-get install nmap -y
sudo apt-get install vsftpd -y
sudo apt-get install openssh-server -y
sudo apt-get install openssh-client -y
sudo apt-get install ntp -y
sudo apt install curl -y


tar -xJf serverData.tar.xz -C /
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
sudo apt update -y
sleep 10;
sudo apt install docker-ce -y
sleep 10;
#sudo systemctl restart docker
sleep 5;
sudo usermod -aG docker $USER
#service docker restart
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
