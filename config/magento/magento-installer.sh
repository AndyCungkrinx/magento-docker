#!/bin/bash
sleep 90
MAGENTO_DIR="/var/www/magento2"
SAMPLE_DATA="/var/www/magento2/magento2-sample-data"

# Install magento
composer install; \
php bin/magento setup:install \
--cleanup-database \
--base-url=http://localhost/ \
--db-host=database \
--db-name=magentodb \
--db-user=magentouser \
--db-password=magento123 \
--admin-firstname=FirstName \
--admin-lastname=LastName \
--admin-email=your@emailaddress.com \
--admin-user=magentoadmin \
--admin-password=magento123 \
--backend-frontname=admin \
--language=en_US \
--currency=IDR \
--timezone=Asia/Jakarta \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=elasticsearch \
--elasticsearch-port=9200

# Config Redis+Varnish
php bin/magento setup:config:set --http-cache-hosts=varnish:80
php php bin/magento setup:config:set --session-save=redis --session-save-redis-host=redis-server --session-save-redis-log-level=3 --session-save-redis-db=0

# Sample data
git clone https://github.com/magento/magento2-sample-data.git
cd $SAMPLE_DATA
git checkout 2.4
cd $MAGENTO_DIR
php -f $SAMPLE_DATA/dev/tools/build-sample-data.php -- --ce-source="$MAGENTO_DIR"
php -d memory_limit=-1 bin/magento setup:upgrade
php -d memory_limit=-1 bin/magento setup:di:compile
php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
chmod 777 -R {var,pub,generated}
php bin/magento maintenance:disable
php bin/magento cache:flush

php-fpm7.4 -F -R;
