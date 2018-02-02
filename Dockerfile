# Docker image for LNLS CA Gateway

FROM lnls/epics-base:base-3.15-debian-9-test

MAINTAINER Gustavo Ciotto

ENV CA_GATEWAY_PATH ${EPICS_FOLDER}/ca-gateway

RUN cd /tmp/epics-dev && \
    ./run-all.sh -o -i -c -g yes

COPY run-ca-gateway.sh ${CA_GATEWAY_PATH}

ENTRYPOINT ["/${CA_GATEWAY_PATH}/run-ca-gateway.sh"]
