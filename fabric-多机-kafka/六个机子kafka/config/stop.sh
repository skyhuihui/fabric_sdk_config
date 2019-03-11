docker-compose -f docker-compose-peer.yaml down
docker-compose -f docker-compose-orderer.yaml down
docker-compose -f docker-kafka.yaml down
docker-compose -f docker-zk.yaml down

docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker-compose -f docker-zk.yaml  up -d
docker-compose -f docker-kafka.yaml up -d
docker-compose -f docker-compose-orderer.yaml up -d
docker-compose -f docker-compose-peer.yaml up -d