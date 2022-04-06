#! /bin/sh
if [ -z "$1" ]
then
    docker exec -u app -it php bash -c "composer global require hirak/prestissimo && composer install"
else
docker exec -u app -it php bash -c "composer global require hirak/prestissimo && composer require $1"
fi
