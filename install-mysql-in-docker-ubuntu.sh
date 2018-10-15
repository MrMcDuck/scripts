# installl mysql docker image

set -e

if [ $(which docker | wc -l | grep -c 1) == 0 ]; then
  echo "ERROR: please install docker first"
  exit
fi

# install/pull lastest mysql docker
sudo docker pull mysql:5.7

# start mysql
# username:root password:admin port 3307
sudo docker run -d -e MYSQL_ROOT_PASSWORD=admin --name mysql-master -p 3307:3306 mysql
