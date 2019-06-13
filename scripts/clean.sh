#!/usr/bin/env bash

## Remove all containers related to metricbeat
CONTAINERS=`docker ps | grep elk-lab | awk '{print $1}'`
[ ! -z "${CONTAINERS}" ] && docker rm -f ${CONTAINERS}
echo "All elk-lab containers removed !"
docker network rm elk-lab 2>&1 > /dev/null || true
exit 0
