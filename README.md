## Magento Docker
```sh
Dockerize Magento Using docker-compose
```

## How to use
```sh
- update .env for configuration (dont forget change your /etc/hosts for apply domain)
- ./run.sh (start all container)
- ./stop.sh (stop all container)
```

## Database
```sh
- You can using root user for full privilage
- Host is 127.0.0.1
- mysqldump -uroot -p[yourpassword] -h127.0.0.1 [your_database] > your_database.sql

