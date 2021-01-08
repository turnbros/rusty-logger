FROM docker.pkg.github.com/turnbros/wireguard-sidecar/wireguard-sidecar:0.1.0

ENV VERSION=7.10.1

RUN mkdir -p /opt/filebeat
WORKDIR /opt/filebeat
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${VERSION}-x86_64.rpm &&\
    rpm -vi filebeat-${VERSION}-x86_64.rpm &&\
    rm -rf /opt/filebeat/filebeat*.rpm &&\
    echo "filebeat --path.config /opt/filebeat" >> /etc/rc.local