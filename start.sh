#!/bin/bash
# Start Service
service mysql start
service elasticsearch start
service redis start
service varnish start

# Provisioning mysql user
bash /mysql-injector.sh

# Install magento
bash /magento-installer.sh

# Start Web Server
service php7.4-fpm start
service nginx start