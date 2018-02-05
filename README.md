# Docker image and compose files for the CA Gateway

A docker image embedding the [EPICS Channel Access Gateway](https://epics.anl.gov/extensions/gateway/) application.

## Deployment

Container deployment can be achieved either by executing `docker-compose -f compose/docker-compose.yml` or `docker stack deploy -c swarm/docker-swarm.yml gateway`. Both require that the network's mode
used by the containers be `host`. This requirement comes from the fact that the EPICS protocol chooses its communication ports randomically, so we cannot predict which ones we need to expose.

For the first option, a systemd service file is provided. It should be installed by executing `make install` in the project main folder. Remember to update `lnls-ca-gateway.env` with your environment variables!

## Base images

The base image `lnls/epics-base` used by this project is specified in [this repository](https://github.com/lnls-sirius/docker-epics-base).

