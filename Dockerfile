FROM docker.pkg.github.com/turnbros/wireguard-sidecar/wireguard-sidecar:0.1.4

ENV VERSION=7.9.1
ENV PATH_CONFIG="/opt/filebeat"
ENV PATH $PATH:/usr/share/filebeat

RUN apk update && apk upgrade && \
    apk add --no-cache wget libc6-compat

RUN mkdir -p /opt/filebeat
WORKDIR /opt/filebeat

RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-${VERSION}-linux-x86_64.tar.gz &&\
    tar xzvf filebeat-${VERSION}-linux-x86_64.tar.gz &&\
    mv filebeat-${VERSION}-linux-x86_64 /usr/share/filebeat &&\
    mkdir /usr/share/filebeat/logs /usr/share/filebeat/data &&\
    rm -rf ${PATH_CONFIG}/filebeat-${VERSION}-linux-x86_64.tar.gz

CMD filebeat -f --path.home /usr/share/filebeat --path.config ${PATH_CONFIG} --path.data ${PATH_CONFIG}/data --path.logs ${PATH_CONFIG}/logs