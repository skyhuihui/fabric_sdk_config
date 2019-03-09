docker-compose -f docker-compose-peer.yaml down
docker-compose -f docker-compose-orderer.yaml down
docker-compose -f docker-kafka.yaml down
docker-compose -f docker-zk.yaml down

docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)