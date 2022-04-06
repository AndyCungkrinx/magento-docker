#! /bin/sh
if [ -z "$1" ]
then
    docker exec -u app -it php bash -c "cd public_html && composer global require hirak/prestissimo && composer update no-dev"
else
docker exec -u app -it php bash -c "cd public_html && composer global require hirak/prestissimo && composer update $1"
fi
