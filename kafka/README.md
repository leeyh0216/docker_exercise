# Kafka Docker Image

Docker 환경에서 Kafka Cluster 테스트가 필요한 경우 사용할 수 있는 Docker Image 입니다.

## Environment Variables

* ${KAFKA_BROKER_ID}: Kafka에서 사용하는 broker.id 값
* ${ZOOKEEPER_SERVERS}: Kafka에 연결할 Zookeeper Cluster 주소. {host}:{port} 형식으로 기록하며, Delimiter는 ,를 사용함
* ${KAFKA_ADVERTISED_HOSTNAME}: Docker 이미지를 실행하는 Host 머신의 IP Address
* ${KAFKA_ADVERTISED_PORT}: Docker 외부에서 Kafka 접근 시 사용할 Port

## How to build

```
docker build -t kafka:0.1 .
```

## How to launch

### `docker run`을 통해 실행하는 경우

docker-compose를 사용하지 않고 `docker run` 명령어를 통해 실행하는 경우에는 미리 Zookeeper Cluster를 실행해놓아야 합니다.

Host 장비의 IP가 1.2.3.4인 경우 아래와 같이 실행합니다.
```
docker run --rm --hostname kafka --name kafka --env KAFKA_BROKER_ID=0 --env ZOOKEEPER_SERVERS=1.2.3.4:2181 --env KAFKA_ADVERTISED_HOSTNAME=1.2.3.4 --env KAFKA_ADVERTISED_PORT=29092 kafka:0.1
```

### docker-compose를 통해 실행하는 경우

docker-compose를 통해 실행할 경우 아래 명령어를 통해 실행합니다.

```
docker-compose up
```
