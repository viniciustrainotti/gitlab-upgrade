#!/bin/bash

UPGRADE_VERSION=$1

echo $UPGRADE_VERSION

echo "-- upgrade --"
docker exec -u root gitlab2 bash -c "apt install gitlab-ce=$UPGRADE_VERSION -y"

echo "-- restart gitlab --"
docker exec -u root gitlab2 bash -c "gitlab-ctl restart"
