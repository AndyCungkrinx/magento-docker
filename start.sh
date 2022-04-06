#!/bin/bash
# Start Service
service mysql start
service redis-server start
service varnish start
service php7.4-fpm start
service nginx start
service elasticsearch start

# Provisioning mysql user
bash /mysql-injector.sh

# Install magento
bash /magento-installer.sh

echo "magento2 already running"