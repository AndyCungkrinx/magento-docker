
#!/bin/bash
MAGENTO_DIR="/var/www/magento2"
SAMPLE_DATA="/var/www/magento2/magento2-sample-data"

# Install magento
composer install; \
php bin/magento setup:install \
--base-url=http://localhost/ \
--db-host=localhost \
--db-name=magentodb \
--db-user=magentouser \
--db-password=magento123 \
--admin-firstname=FirstName \
--admin-lastname=LastName \
--admin-email=your@emailaddress.com \
--admin-user=magentoadmin \
--admin-password=magento123 \
--language=en_US \
--currency=IDR \
--timezone=Asia/Jakarta \
--use-rewrites=1; \
chown -R www-data:www-data $MAGENTO_DIR;

# Config Redis+Varnish
php bin/magento setup:config:set --http-cache-hosts=127.0.0.1:80; \
php php bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-log-level=3 --session-save-redis-db=0

# Disable Elstic
php bin/magento config:set catalog/search/engine none

# Sample data
git clone https://github.com/magento/magento2-sample-data.git; \
cd $SAMPLE_DATA; \
git checkout 2.4; \
cd $MAGENTO_DIR; \
php -f $SAMPLE_DATA/dev/tools/build-sample-data.php -- --ce-source="$MAGENTO_DIR"; \
php bin/magento setup:upgrade; \
php bin/magento setup:di:compile; \
php bin/magento setup:static-content:deploy -f; \
chmod 777 -R {var,pub,generated}; \
php bin/magento cache:flush;
