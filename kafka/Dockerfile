FROM ubuntu:16.04

LABEL Maintainer="leeyh0216@gmail.com"

# Change default mirror to kakao.
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y openjdk-8-jre wget

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    KAFKA_HOME=/usr/local/kafka_2.12-2.5.0

RUN wget http://mirror.navercorp.com/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz -O /usr/local/kafka.tgz && tar -xvf /usr/local/kafka.tgz -C /usr/local/ && rm /usr/local/kafka.tgz

COPY start-kafka.sh ${KAFKA_HOME}/bin/start-kafka.sh

ENV ZOOKEEPER_SERVERS=localhost:2181

# Change user and start airflow process
RUN useradd -ms /bin/bash kafka && chown -R kafka:kafka ${KAFKA_HOME}
USER kafka

EXPOSE 29092

ENTRYPOINT ["/usr/local/kafka_2.12-2.5.0/bin/start-kafka.sh"] 
