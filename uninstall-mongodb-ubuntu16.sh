# uninstall mongodb 3.2 on ubuntu 16.04 LTS
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

sudo apt-get purge mongodb-org*

# 如果安装时自定义了数据和日志目录，需要重写下面的路径
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb