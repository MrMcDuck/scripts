# functions
influxdb(required): Kernel Database
chronograf(recommend): Time-Series Data Visualization, Web Admin
telegraf(optional): Time-Series Data Collector, Collect CPU/MEM...
kapacitor(optional): Time-Series Data Processing, Alerting

# stop services if exits
systemctl stop influxdb
systemctl stop chronograf
systemctl stop telegraf
systemctl stop kapacitor


# start service when os < ubuntu 15.04
sudo service influxdb start
sudo service chronograf start
sudo service telegraf start
sudo service kapacitor start

# start service when os < ubuntu 15.04
sudo systemctl start influxdb
sudo systemctl start chronograf

# default service address
influxdb (http api) localhost:8086
chronograf (web admin) localhost:8888

# install influxdb from .deb installer
# https://docs.influxdata.com/chronograf/v1.6/introduction/getting-started/
wget https://dl.influxdata.com/influxdb/releases/influxdb_1.6.4_amd64.deb
sudo dpkg -i influxdb_1.6.4_amd64.deb
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.8.2-1_amd64.deb
sudo dpkg -i telegraf_1.8.2-1_amd64.deb
wget https://dl.influxdata.com/chronograf/releases/chronograf_1.6.2_amd64.deb
sudo dpkg -i chronograf_1.6.2_amd64.deb
wget https://dl.influxdata.com/kapacitor/releases/kapacitor_1.5.1_amd64.deb
sudo dpkg -i kapacitor_1.5.1_amd64.deb

# config files
/etc/telegraf/telegraf.conf



# if you want to install using source, continue to read it

# add influxdb source
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

# install from source when os < ubuntu 15.04
sudo apt-get update && sudo apt-get install influxdb
sudo apt-get update && sudo apt-get install telegraf

# install from source when os > ubuntu 15.04
sudo apt-get update && sudo apt-get install influxdb
sudo systemctl unmask influxdb.service
sudo apt-get update && sudo apt-get install telegraf
sudo systemctl start telegraf