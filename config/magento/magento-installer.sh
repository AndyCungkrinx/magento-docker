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
--elasticsearch-port=9200 \
--http-cache-hosts=varnish:80 \
--session-save=redis \
--session-save-redis-host=redis-server \
--session-save-redis-log-level=3 \
--session-save-redis-db=0

# Enable varnish
php bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2

# Sample data
php -d memory_limit=-1 bin/magento setup:perf:generate-fixtures setup/performance-toolkit/profiles/ce/small.xml
php -d memory_limit=-1 bin/magento setup:upgrade
php -d memory_limit=-1 bin/magento setup:di:compile
php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
chmod 777 -R var/ pub/ generated/
php bin/magento maintenance:disable
php bin/magento indexer:reindex
php bin/magento cache:flush

php-fpm7.4 -F -R;
