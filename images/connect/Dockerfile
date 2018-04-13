FROM debezium/connect-base:0.8

MAINTAINER Debezium Community

ENV DEBEZIUM_VERSION=0.7.3 \
    MAVEN_CENTRAL="https://repo1.maven.org/maven2" \
    MD5SUMS="MONGODB_MD5=6e70c567e2e928ea3bec9fccf978ea50 MYSQL_MD5=f4243572e157505588049cba42d51b98 POSTGRES_MD5=f5aa03b82e2bdb364ecd7aa73cba5b33" \
    KAFKA_JARS=/kafka/connect/kafka-connect-jdbc
#
# Download connectors, verify the contents, and then install into the `$KAFKA_CONNECT_PLUGINS_DIR/debezium` directory...
#
RUN eval $MD5SUMS &&\
    for CONNECTOR in {mysql,mongodb,postgres}; do \
    curl -fSL -o /tmp/plugin.tar.gz \
                 $MAVEN_CENTRAL/io/debezium/debezium-connector-$CONNECTOR/$DEBEZIUM_VERSION/debezium-connector-$CONNECTOR-$DEBEZIUM_VERSION-plugin.tar.gz &&\
    declare MD5_PARAM_NAME="${CONNECTOR^^}_MD5" &&\
    echo "${!MD5_PARAM_NAME}  /tmp/plugin.tar.gz" | md5sum -c - &&\
    tar -xzf /tmp/plugin.tar.gz -C $KAFKA_CONNECT_PLUGINS_DIR &&\
    rm -f /tmp/plugin.tar.gz; \
    done;

RUN mkdir -p ${KAFKA_JARS} && \
    curl -fSL -o ${KAFKA_JARS}/confluent.tar.gz \
        http://packages.confluent.io/archive/4.0/confluent-oss-4.0.0-2.11.tar.gz

RUN cd ${KAFKA_JARS} && tar -zxvf confluent.tar.gz && \
    mv ${KAFKA_JARS}/confluent-4.0.0/share/java/kafka-connect-jdbc/postgresql-9.4-1206-jdbc41.jar ${KAFKA_JARS} && \
    mv ${KAFKA_JARS}/confluent-4.0.0/share/java/kafka-connect-jdbc/kafka-connect-jdbc-4.0.0.jar v ${KAFKA_JARS} && \
    rm -rf confluent-4.0.0 confluent.tar.gz