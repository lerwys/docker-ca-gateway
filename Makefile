PREFIX ?= /usr/local

# Docker files
SRC_DOCKER_COMPOSE_FILE = compose/docker-compose.yml
SERVICE_NAME = lnls-ca-gateway
ENV_FILE = lnls-ca-gateway.env

# Service files
SRC_SERVICE_FILE = ${SERVICE_NAME}.service
SERVICE_FILE_DEST = /etc/systemd/system
DOCKER_FILES_DEST = ${SERVICE_FILE_DEST}/${SRC_SERVICE_FILE}.d/

.PHONY: install uninstall

install:
	mkdir -p ${DOCKER_FILES_DEST}
	cp --preserve=mode ${SRC_DOCKER_COMPOSE_FILE} ${DOCKER_FILES_DEST}
	cp --preserve=mode ${ENV_FILE} ${DOCKER_FILES_DEST}
	cp --preserve=mode ${SRC_SERVICE_FILE} ${SERVICE_FILE_DEST}
	sed -i "s#/etc/systemd/system/lnls-ca-gateway.d/#${DOCKER_FILES_DEST}#g" ${SERVICE_FILE_DEST}/${SRC_SERVICE_FILE}
	sed -i "s#/home/gciotto/repository/docker-pvgateway/#${DOCKER_FILES_DEST}#g" ${DOCKER_FILES_DEST}/docker-compose.yml
	systemctl daemon-reload
	systemctl stop ${SERVICE_NAME}
	systemctl start ${SERVICE_NAME}

uninstall:
	systemctl stop ${SERVICE_NAME}
	rm -f ${SERVICE_FILE_DEST}/${SRC_SERVICE_FILE}
	rm -f -R ${DOCKER_FILES_DEST}
	systemctl daemon-reload
