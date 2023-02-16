#sudo apt-get install -y apache2
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_7.0.6_arm64.deb
sudo dpkg -i grafana-enterprise_7.0.6_arm64.deb
service grafana-server restart
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.5_arm64.deb
sudo dpkg -i influxdb_1.8.5_arm64.deb
service influxdb restart
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
