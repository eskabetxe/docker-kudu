FROM debian:stretch
MAINTAINER eskabetxe

ENV KUDU_VERSION=1.8.0

RUN set -x \
    && apt-get update \
    && apt-get upgrade --yes \
    && apt-get install -y --no-install-recommends \
        libsasl2-dev libsasl2-modules openjdk-8-jdk \
        lsb-release ntp openssl wget \
    && apt-get autoremove \
    && apt-get autoclean

RUN cd /opt \
 && wget https://github.com/eskabetxe/docker-kudu-deb/releases/download/${KUDU_VERSION}/kudu-${KUDU_VERSION}-x86_64.deb \
 && dpkg -i kudu-${KUDU_VERSION}-x86_64.deb

ADD docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8050 8051 7050 7051
