#!/bin/bash

if [[ "${KAFKA_BROKER_ID}" == "" ]];
then
    KAFKA_BROKER_ID=-1
fi
sed -i "s/broker.id=0/broker.id=${KAFKA_BROKER_ID}/g" ${KAFKA_HOME}/config/server.properties

if [[ "${ZOOKEEPER_SERVERS}" == "" ]];
then
    echo "\${ZOOKEEPER_SERVERS} cannot be empty string"
    exit 1;
fi
sed -i "s/localhost:2181/${ZOOKEEPER_SERVERS}/g" ${KAFKA_HOME}/config/server.properties 

if [[ "${KAFKA_ADVERTISED_HOSTNAME}" == "" ]];
then
    echo "listeners=PLAINTEXT://`hostname`:9092" >> ${KAFKA_HOME}/config/server.properties
    echo "advertised.listeners=PLAINTEXT://`hostname`:9092" >> ${KAFKA_HOME}/config/server.properties
else
    if [[ "${KAFKA_ADVERTISED_PORT}" == "" ]];
    then
       KAFKA_ADVERTISED_PORT=29092
    fi
    echo "listener.security.protocol.map=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT" >> ${KAFKA_HOME}/config/server.properties 
    echo "listeners=PLAINTEXT://`hostname`:9092,PLAINTEXT_HOST://:${KAFKA_ADVERTISED_PORT}" >> ${KAFKA_HOME}/config/server.properties
    echo "advertised.listeners=PLAINTEXT://`hostname`:9092,PLAINTEXT_HOST://${KAFKA_ADVERTISED_HOSTNAME}:${KAFKA_ADVERTISED_PORT}" >> ${KAFKA_HOME}/config/server.properties
    echo "inter.broker.listener.name=PLAINTEXT" >> ${KAFKA_HOME}/config/server.properties
fi

exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties
