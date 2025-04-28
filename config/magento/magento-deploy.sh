#!/bin/bash
MAGENTO_DIR="/var/www/magento2"

# deploy magento
php bin/magento maintenance:enable
rm -rf var/cache var/composer_home var/di var/generation var/page_cache var/session var/tmp var/view_preprocessed pub/static/* generated/* pub/static/frontend/* pub/static/_cache/merged pub/static/_requirejs pub/static/adminhtml
php -d memory_limit=-1 bin/magento setup:upgrade
php -d memory_limit=-1 bin/magento setup:di:compile
php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
chmod 777 -R var/ pub/ generated/
php bin/magento maintenance:disable
php bin/magento indexer:reindex
php bin/magento cache:flush
