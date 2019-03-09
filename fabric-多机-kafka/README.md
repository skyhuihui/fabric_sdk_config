
三个机子， 两个orderer， 两个zookeeper， 两个kafka， 三个peer
No1 : orderer0+zookeeper0+kafka0+peer0
No2 : orderer1+zookeeper1+kafka1+peer1
No3 : peer
如何拓展网络， 新增 peer , 复制NO3代码  修改相应配置
如何拓展网络， 新增 orderer , 复制NO1代码 修改相应配置

111.111.111.111  orderer+zookeeper0+kafka0+peer0
222.222.222.222  orderer1+zookeeper1+kafka1+peer1

要开放端口
7050,7051,7052,7053,9092,2181,2888,3888

节点信息 

机器1 peer1+couchdb0+cli0  114.115.200.251   机器配置， 8G内存 40G 硬盘，数据存挂载盘

机器2 orderer0+zookeeper1+kafka0+peer0+couchdb1+cli1  作为创建通道实例化链码的节点，其他节点加入通道

机器3 orderer1+zookeeper2+kafka1+peer2+couchdb2+cli2 

机器4 orderer2+zookeeper3+kafka2+peer3+couchdb3+cli3

机器5 orderer3+zookeeper4+kafka3+peer4+couchdb4+cli4

机器6 orderer4+zookeeper5+kafka4+peer5+couchdb5+cli5

如升级fabric 版本（镜像） couchdb也要调整

新增节点 ：

  机器要求： （每次invoke量10000左右） 8G 内存+ 500G 硬盘内存+ 3.0GHZ cpu
		节点部署 orderer+peer+cli+couchdb+zookeeper+kafka+ca
		
  
  配置文件更改：（全部节点）
	（创建证书， 通道配置文件）
	先修改configtx.yaml 更改 orderer  kafka 组织等 
	修改config-crypto.yaml 更改组织orderer 等
	
	（修改yaml文件） 
	
	（新增zookeeper）
	 修改 全部文件docker_zk.yaml 配置 extra_hosts，ZOO_SERVERS，ZOO_MY_ID，volumes，hostname，container_name，
	
	 （新增kafka）
	 修改 全部文件docker_kafka.yaml 配置 extra_hosts,volumes,KAFKA_BROKER_ID,KAFKA_MIN_INSYNC_REPLICAS,KAFKA_DEFAULT_REPLICATION_FACTOR,KAFKA_ZOOKEEPER_CONNECT,hostname,container_name
	  KAFKA_BROKER_ID  		kafkaid 
	  KAFKA_MIN_INSYNC_REPLICAS	小于 KAFKA_DEFAULT_REPLICATION_FACTOR 小于kafka节点数
	  
	  
	  （新增orderer）
	  修改 全部文件docker-compose-orderer.yaml，配置 extra_hosts，volumes，container_name，extends service
	  修改 docker-compose-base.yaml文件 新增orderer 参照例子增肌orderer peer同理
	  
	  (新增peer)
	  修改 全部文件docker-compose-peer.yaml，配置 extra_hosts，container_name，extends service
	  修改 docker-compose-base.yaml文件 新增peer 参照例子增肌peer orderer同理
	  
	  couchdb， cli， ca配置在 docker-compose-peer.yaml
	  
	  代码 需根据节点不同来写不同代码，只需一个节点进行 创建创建通道， 实例化链码得操作 
	启动
	
	先启动zookeeper，然后kafka， orderer ，peer
	
	
	
	测试kafka集群
	[root@c69 ~]# docker exec -ti  d15 bash    --> 进入到kafka4容器, d15  要根据实际变化
		bash-4.4# 
		bash-4.4# bash-4.4# cd /opt/kafka         --> kafka安装包在 /opt/kafka目录下
		bash-4.4# bin/kafka-topics.sh --create --zookeeper zoo1:2181 --replication-factor 1 --partitions 1 --topic test123  
		Created topic "test123".
		bash-4.4# bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test123
		>this a message #1  --> 输入消息
		>hello , fabric
		>^C
		bash-4.4# 
		bash-4.4# 
		bash-4.4#   bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test123 --from-beginning
		this a message #1  --> 看到输入消息了，说明kafka部署成功了
		hello , fabric          
		^C
		Processed a total of 2 messages


	  