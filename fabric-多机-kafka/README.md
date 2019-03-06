
三个机子， 两个orderer， 两个zookeeper， 两个kafka， 三个peer
No1 : orderer0+zookeeper0+kafka0+peer0
No2 : orderer1+zookeeper1+kafka1+peer1
No3 : peer
如何拓展网络， 新增 peer , 复制NO3代码  修改相应配置
如何拓展网络， 新增 orderer , 复制NO1代码 修改相应配置

111.111.111.111  orderer+zookeeper0+kafka0+peer0
222.222.222.222  orderer1+zookeeper1+kafka1+peer1

要开放端口
7050,7051,7052,7053,9092,2181,2888,3888,9092

节点信息 

机器1 zookeeper1+peer1+couchdb0  114.115.200.251

机器2 orderer0+zookeeper2+kafka0+peer0+couchdb1 

机器3 orderer1+zookeeper3+kafka1+peer2+couchdb2 

机器4 orderer2+zookeeper4+kafka2+peer3+couchdb3 

机器5 orderer3+zookeeper5+kafka3+peer4+couchdb4 

机器6 orderer4++kafka4+peer5+couchdb5 