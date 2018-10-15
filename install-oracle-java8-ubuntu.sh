# this script will install oracle-java8 LTS for ubuntu 14/16

set -e

source shlib.sh

shlibCheckUbuntu_14_16

#安装add-apt-repository命令
sudo apt-get install python-software-properties
sudo apt-get install software-properties-common

#添加ppa
sudo add-apt-repository ppa:webupd8team/java

#安装oracle-java
sudo apt-get update
sudo apt-get install oracle-java8-installer

#检查java版本
java -version
