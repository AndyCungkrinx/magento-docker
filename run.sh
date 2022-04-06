#! /bin/sh
# Network
docker network create proxy
docker network create internal
docker network create dbserver

# Build
docker-compose --compatibility -f docker-compose.yaml up -d --build --force-recreate --remove-orphans
