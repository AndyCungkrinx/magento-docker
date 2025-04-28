#! /bin/sh
if [ -z "$1" ]
then
    docker exec -it php bash -c "composer install"
else
docker exec -it php bash -c "composer require $1"
fi
