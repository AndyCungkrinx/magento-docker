#!/bin/bash
sleep 30
MAGENTO_DIR="/var/www/magento2"
SAMPLE_DATA="/var/www/magento2/magento2-sample-data"

# Install magento
composer install; \
php bin/magento setup:install \
--cleanup-database \
--base-url=http://localhost/ \
--db-host=database \
--db-name=m2_database \
--db-user=magentouser \
--db-password=kthnwqDyYg82e5rH \
--admin-firstname=Infra \
--admin-lastname=Icube \
--admin-email=infra@sirclo.com \
--admin-user=magentovanilla \
--admin-password=Uq4yKvrMfXtbeHFu \
--backend-frontname=backoffice \
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

# Elasticsearch 
bin/magento module:enable Magento_Elasticsearch7 Magento_Elasticsearch

# Sample data
git clone --branch 2.4.6 --single-branch https://github.com/magento/magento2-sample-data

# Enable varnish
php bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2

# Sample data
php -d memory_limit=-1 -f magento2-sample-data/dev/tools/build-sample-data.php -- --command=unlink --ce-source="magento2-sample-data"
php bin/magento config:set dev/static/sign 1
php -d memory_limit=-1 bin/magento setup:upgrade
php -d memory_limit=-1 bin/magento setup:di:compile
php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
chmod 777 -R var/ pub/ generated/
php bin/magento maintenance:disable
php bin/magento indexer:reindex
php bin/magento cache:flush

php-fpm8.1 -F -R;
