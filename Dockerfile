# EventStore (geteventstore.com)
#
# VERSION               4.0.0-alpha1

FROM ubuntu:16.04
MAINTAINER Event Store LLP <ops@geteventstore.com>

ENV ES_VERSION=4.0.0-alpha1

RUN apt-get update && apt-get install curl -y &&\
    curl -s https://packagecloud.io/install/repositories/EventStore/EventStore-OSS-PreRelease/script.deb.sh | bash &&\
    apt-get install eventstore-oss=$ES_VERSION -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1113
EXPOSE 2113

VOLUME /var/lib/eventstore
VOLUME /data/logs

CMD ./usr/bin/eventstored --ext-http-prefixes=http://*:2113/ --ext-ip=0.0.0.0 \
    --db /var/lib/eventstore --log /data/logs --run-projections=all
