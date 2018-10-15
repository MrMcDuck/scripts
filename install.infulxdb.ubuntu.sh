# stop service
systemctl stop influxdb
systemctl stop telegraf
systemctl stop kapacitor
systemctl stop chronograf

# install influxdb
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.2.4_amd64.deb
sudo dpkg -i influxdb_1.2.4_amd64.deb
systemctl start influxdb
# default service port 8086

# install telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.3.2-1_amd64.deb
sudo dpkg -i telegraf_1.3.2-1_amd64.deb
# configure /etc/telegraf/telegraf.conf if needed
systemctl start telegraf

# install kapacitor (optional)
wget https://dl.influxdata.com/kapacitor/releases/kapacitor_1.3.1_amd64.deb
sudo dpkg -i kapacitor_1.3.1_amd64.deb
systemctl start kapacitor

# install chronograf
wget https://dl.influxdata.com/chronograf/releases/chronograf_1.3.3.4_amd64.deb
sudo dpkg -i chronograf_1.3.3.4_amd64.deb
systemctl start chronograf
# default service port 8888

# visit ip:8888 to access web admin ui