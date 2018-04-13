FROM debezium/postgres:9.6

MAINTAINER Debezium Community

COPY init.sql .
COPY inventory.sql .

USER postgres
COPY init.sql /docker-entrypoint-initdb.d/
COPY inventory.sql /docker-entrypoint-initdb.d/
COPY start.sh /docker-entrypoint-initdb.d/
