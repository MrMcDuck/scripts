# this script will install nodejs 4.6 LTS for ubuntu 14/16

source shlib.sh

shlibCheckUbuntu_14_16

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
