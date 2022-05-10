#!/bin/bash

INSTALL_VERSION=$1
EXTERNAL_URL=$2
echo $INSTALL_VERSION
echo $EXTERNAL_URL

echo "-- delete container --"
docker rm -f gitlab2
echo "-- create container --"
docker run -td --name gitlab2 -p 80:80  ubuntu:20.04

echo "-- update --"
docker exec -u root gitlab2 bash -c "apt update -y"
echo "-- upgrade --"
docker exec -u root gitlab2 bash -c "apt upgrade -y"
echo "-- install curl --"
docker exec -u root gitlab2 bash -c "apt install -y curl"
echo "-- configure localtime --"
docker exec -u root gitlab2 bash -c "ln -snf /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime"
echo "-- install openssh-server ca-certificates tzdate perl --"
docker exec -u root gitlab2 bash -c "DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server ca-certificates tzdata perl"
echo "-- date dentro do container --"
docker exec -u root gitlab2 bash -c "echo $(date)"
echo "-- gitlab script deb --"
docker exec -u root gitlab2 bash -c "curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash"

echo "-- install gitlab --"
(
    docker exec -u root gitlab2 bash -c "EXTERNAL_URL="$EXTERNAL_URL" apt install gitlab-ce=$INSTALL_VERSION -y"
) &

sleep 60

echo "-- runsvdir --"
( 
    docker exec -u root gitlab2 bash -c "/opt/gitlab/embedded/bin/runsvdir-start &"
)
