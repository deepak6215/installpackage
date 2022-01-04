

mkdir -p /var/www/csvbackup
mkdir -p /var/www/report/export/Scheduled_Report
mkdir -p /var/www/iSolar/fetchDDT/csv
mkdir -p /var/log/scaback_csv_influx_ingestor
mkdir -p /var/log/prometheus
mkdir -p /var/log/iGate_log
mkdir -p /home/iplonshare/Scheduled_Report
mkdir -p /home/iplonftp/csvbackup
mkdir -p /home/iplonftp/Scheduled_Report

adduser iplon www-data

chown www-data:www-data -R /var/www/*
chown www-data:www-data -R /var/www/.config/

chmod 755 -R /var/www/*
chmod 755 -R /var/www/.config/
chmod 777 -R /var/www/report/export/Scheduled_Report/
chmod 777 -R /var/www/iSolar/fetchDDT/csv

chown root:crontab /var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root

chown root:root /etc/ntp.conf
chown root:root /etc/samba/smb.conf
chown root:root /etc/vsftpd.conf

chmod 644 /etc/ntp.conf
chmod 644 /etc/samba/smb.conf
chmod 644 /etc/vsftpd.conf
chmod 777 /var/log/report.log
