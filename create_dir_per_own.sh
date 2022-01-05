#!/bin/bash

sudo mkdir -p /var/www/csvbackup
sudo mkdir -p /var/www/report/export/Scheduled_Report
sudo mkdir -p /var/www/iSolar/fetchDDT/csv
sudo mkdir -p /var/log/scaback_csv_influx_ingestor
sudo mkdir -p /var/log/prometheus
sudo mkdir -p /var/log/iGate_log
sudo mkdir -p /home/iplonshare/Scheduled_Report
sudo mkdir -p /home/iplonftp/csvbackup
sudo mkdir -p /home/iplonftp/Scheduled_Report


sudo chown www-data:www-data -R /var/www/*
sudo chown www-data:www-data -R /var/www/.config/

sudo chmod 755 -R /var/www/*
sudo chmod 755 -R /var/www/.config/
sudo chmod 777 -R /var/www/report/export/Scheduled_Report/
sudo chmod 777 -R /var/www/iSolar/fetchDDT/csv

sudo chown root:crontab /var/spool/cron/crontabs/root
sudo chmod 600 /var/spool/cron/crontabs/root

sudo chown root:root /etc/ntp.conf
sudo chown root:root /etc/samba/smb.conf
sudo chown root:root /etc/vsftpd.conf

sudo chmod 644 /etc/ntp.conf
sudo chmod 644 /etc/samba/smb.conf
sudo chmod 644 /etc/vsftpd.conf
sudo chmod 777 /var/log/report.log
