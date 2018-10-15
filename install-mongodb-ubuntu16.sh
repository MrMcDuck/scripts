# install mongodb 3.2 on ubuntu 16.04 LTS
# 官方参考文档：https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
# 
# 注意：
# 配置mongod（绑定端口、验证、集群等）需要手动进行
# 本脚本的步骤和官方安装文档几乎完全一致，只是官方文档少了systemctl daemon-reload这个步骤，导致安装完成后无法启动

# install mongodb for single host
function installMongodb() {
    # add and update mongodb repo
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    sudo apt-get update

    # install specific version, if need install latest stable version, using "sudo apt-get install -y mongodb-org" instead
    if [ "$1" == "latestStable" ]; then
        echo "You select version is latest stable version"
        sudo apt-get install -y mongodb-org
    else
        echo "You select version is 3.2.11"
        sudo apt-get install -y mongodb-org=3.2.11 mongodb-org-server=3.2.11 mongodb-org-shell=3.2.11 mongodb-org-mongos=3.2.11 mongodb-org-tools=3.2.11
    fi

    # pin version to prevent unintended upgrades
    echo "mongodb-org hold" | sudo dpkg --set-selections
    echo "mongodb-org-server hold" | sudo dpkg --set-selections
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections

    # create systemd service file (Ubuntu 16.04-only)
    # NOTE:
    # A) User and Group can only be "mongodb"
    # B) .service filename can be modified, but service start/restart/stop must use same name as .service file
    # C) save to /etc/systemd/system is the same as /lib/...
    sudo sh -c "echo '[Unit]' > /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'Description=High-performance, schema-free document-oriented database' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'After=network.target' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'Documentation=https://docs.mongodb.org/manual' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo '[Service]' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'User=mongodb' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'Group=mongodb' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo '[Install]' >> /lib/systemd/system/mongod.service"
    sudo sh -c "echo 'WantedBy=multi-user.target' >> /lib/systemd/system/mongod.service"
    
    # reload all .service file, otherwise cannot start mongod right now
    systemctl daemon-reload
    # enable start with boot
    sudo systemctl enable mongod

    # configure bind port / authorization
    echo "please configure bind port and authorization by manual"
    # vi /etc/mongod.conf

    # start daemon
    echo "start mongod serivce -> sudo service mongod start" # same as "sudo systemctl start mongod"
    echo "stop mongod serivce -> sudo service mongod stop"
    echo "restart mongod serivce -> sudo service mongod restart"
}

# remove mongodb app, keep data and log
function uninstallMongodbApp() {
    sudo service mongod stop
    sudo apt-get purge mongodb-org*
}

# remove mongodb data and log
function uninstallMongodbDataLog() {
    # remove log dir
    sudo rm -r /var/log/mongodb

    # remove data dir
    sudo rm -r /var/lib/mongodb
}

# entry
function choice() {
    echo "                             Menu                             "
    echo "  1. install mongodb 3.2.11 on ubuntu 16.04 LTS"
    echo "  2. install mongodb latest stable version on ubuntu 16.04 LTS"
    echo "  3. uninstall mongodb application (keep the data and log) on ubuntu 16.04 LTS"

    read -t 20 -p "Please input your chooise: " jour

    case "$jour" in
        "1")
            installMongodb "3.2.11"
            ;;
        "2")
            installMongodb "latestStable"
            ;;
        "3")
            uninstallMongodbApp
            ;;
        *)
            echo " Your chooise Error ！"
            ;;
    esac
}

choice
