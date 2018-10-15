#!/bin/sh
#mongodb 3.2安装分片和副本的sh脚本和解析
sudo wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-3.2.10.tgz
sudo tar -zxvf  mongodb-linux-x86_64-ubuntu1604-3.2.10.tgz
sudo mkdir /mongo/
sudo mkdir /mongo/shards
sudo mkdir /mongo/shards/shard1
sudo mkdir /mongo/logs
sudo cp -rf mongodb-linux-x86_64-ubuntu1604-3.2.10 /mongo/
cd /mongo
sudo mv mongodb-linux-x86_64-ubuntu1604-3.2.10 mongodb
sudo rm -rf /home/metal/mongodb-linux-x86_64-ubuntu1604-3.2.10.tgz
sudo rm -rf /home/metal/mongodb-linux-x86_64-ubuntu1604-3.2.10
sudo chmod -R 777 /mongo/shards/shard1
cd /home/metal
#打开用户目录下，已经生成的密钥
#sudo openssl rand -base64 100 > /mongo/keyfile0 --文件内容采base64编码，一共100个字符  用于认证    各个服务器都统一用一个keyfile0
#sudo chmod 600 /mongo/keyfile0
sudo mv keyfile0 /mongo/keyfile0
# 启动程序 测试是否正常
sudo /mongo/mongodb/bin/mongod -configsvr -dbpath=/mongo/data/config -port 20000 -logpath=/mongo/logs/config.log --fork  --keyFile=/mongo/keyfile0
sudo /mongo/mongodb/bin/mongos --port 30000 --configdb 192.168.9.31:20000 --chunkSize 100 --logpath=/mongo/logs/mongos.log --fork  --keyFile=/mongo/keyfile0
#开启三个端口
#sudo /mongo/mongodb/bin/mongod -shardsvr -port 10001 --replSet rs1 -dbpath=/mongo/shards/replset1 --storageEngine wiredTiger -logpath=/mongo/shards/replset1.log --fork --keyFile=/mongo/keyfile0
#sudo /mongo/mongodb/bin/mongod -shardsvr -port 10002 --replSet rs2 -dbpath=/mongo/shards/replset2 --storageEngine wiredTiger -logpath=/mongo/shards/replset2.log --fork --keyFile=/mongo/keyfile0
#sudo /mongo/mongodb/bin/mongod -shardsvr -port 10003 --replSet rs3 -dbpath=/mongo/shards/replset3 --storageEngine wiredTiger -logpath=/mongo/shards/replset3.log --fork --keyFile=/mongo/keyfile0
#测试进程是否正常运行
sudo ps aux | grep mongo

#各个主服务器配置
#  sudo /mongo/mongodb/bin/mongo 192.168.9.14:10002/admin
#     use admin
#      db.runCommand(  
#     {  
#         "replSetInitiate":  
#         {  
#             "_id":"rs5",  
#             "members":  
#             [  
#                 {  
#                     "_id":1,  
#                     "host":"192.168.9.14:10002"  
#                 },  
#                 {  
#                     "_id":2,  
#                     "host":"192.168.9.15:10002"  
#                 },  
#                 {  
#                     "_id":3,  
#                     "host":"192.168.9.16:10002"  
#                 }  
#             ]  
#         }  
#     })

#     sudo /mongo/mongodb/bin/mongo 192.168.9.14:10003/admin
#         use admin
#      db.runCommand(  
#     {  
#         "replSetInitiate":  
#         {  
#             "_id":"rs6",  
#             "members":  
#             [  
#                 {  
#                     "_id":1,  
#                     "host":"192.168.9.14:10003" 
#                 },  
#                 {  
#                     "_id":2,  
#                     "host":"192.168.9.15:10003"  
#                 },  
#                 {  
#                     "_id":3,  
#                     "host":"192.168.9.16:10003"  
#                 }  
#             ]  
#         }  
#     })

#192.168.9.31 作为配置服务器分片配置进去就可以了。
# sudo /mongo/mongodb/bin/mongod --configsvr --dbpath=/mongo/data/config --port 20000 --logpath=/mongo/logs/config.log --fork --keyFile=/mongo/keyfile0
# sudo /mongo/mongodb/bin/mongos --port 30000 --configdb 192.168.9.31:20000 --                  chunkSize 100 --logpath=/mongo/logs/mongos.log --fork --keyFile=/mongo/keyfile0
#mongo 192.168.9.31:30000
#mongos> use admin  
#switched to db admin  
#db.runCommand({"addShard":"rs1/192.168.9.11:10001"})  
#db.runCommand({"addShard":"rs2/192.168.9.11:10002"})  
#db.runCommand({"addShard":"rs3/192.168.9.11:10003"})
#db.runCommand({"addShard":"rs4/192.168.9.14:10001"})  
#db.runCommand({"addShard":"rs5/192.168.9.14:10002"})  
#db.runCommand({"addShard":"rs6/192.168.9.14:10003"})


# 3.认证配置
#  （1）mongo 192.168.9.31:30000
#   mongos> use admin
#   db.addUser( { user: "superman", pwd: "superman",roles: [ "clusterAdmin","userAdminAnyDatabase","dbAdminAnyDatabase","readWriteAnyDatabase" ] } )
#   mongos> db.auth("superman","superman")
#  （2）用上面建立的管理员帐号登录mongos进程，对数据库（比如test）启用分片，设置集合片键。
#  （3）用管理员账户登录，建立新账户，让他可以读写数据库test
#   mongo localhost:30000/admin -u superman -p superman
#   mongos> use admin
#   switched to db admin
#   mongos> db.addUser("test","test"){"user" : "test","readOnly" : false,"pwd" : "a6de521abefc2fed4f5876855a3484f5","_id" : ObjectId("51fb5d4ecaa5917203f37f63")}
#   mongos> db.auth("test","test")