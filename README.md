## Magento Docker
```sh
Dockerize Magento Using docker-compose
```

## How to use
```sh
- update .env for configuration (dont forget change your /etc/hosts for apply domain)
- ./fresh-install.sh (start all container when fresh install. check your browser http://localhost and after finished run ./stop.sh)
- ./run.sh (start all container when magento already installed)
- ./stop.sh (stop all container)
```

##
```sh
- for fresh install just go to folder www then run 'git clone --branch 2.4.6 --single-branch git@github.com:magento/magento2.git www/magento2'
```