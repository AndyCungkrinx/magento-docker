
#!/bin/bash
WEBROOT_DIR="/var/www"
MAGENTO_DIR="/var/www/magento2"
SAMPLE_DATA="/var/www/magento2/magento2-sample-data"

# Install magento
cd $WEBROOT_DIR; \
git clone https://github.com/magento/magento2.git; \
cd $MAGENTO_DIR; \
composer install; \
php $MAGENTO_DIR/bin/magento setup:install \
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
php $MAGENTO_DIR/bin/magento setup:config:set --http-cache-hosts=127.0.0.1:80; \
php $MAGENTO_DIR/php bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-log-level=3 --session-save-redis-db=0

# Sample data
cd $MAGENTO_DIR; \
git clone https://github.com/magento/magento2-sample-data.git; \
cd $SAMPLE_DATA; \
git checkout 2.4; \
cd $MAGENTO_DIR; \
php -f $SAMPLE_DATA/dev/tools/build-sample-data.php -- --ce-source="/home/mage2user/site/releases/magento2"; \
php $MAGENTO_DIR/bin/magento setup:upgrade; \
php $MAGENTO_DIR/bin/magento setup:di:compile; \
php $MAGENTO_DIR/bin/magento setup:static-content:deploy -f; \
chmod 777 -R $MAGENTO_DIR/{var,pub,generated}; \
php $MAGENTO_DIR/bin/magento cache:flush; \
