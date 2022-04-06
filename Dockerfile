FROM ubuntu:20.04

LABEL maintainer="Andy Cungkrinx <andy.setiawan@sirclo.com>" \
      version.ubuntu="20.04" \
      version.mysql="8" \
      version.php="7.4" \
      version.ioncube="10.4.5" \
      version.composer="1.10.20" \
      version.nginx="1.18.0" \
      version.mysql="8.0" \
      version.redis="5.0.7" \
      version.varnish="6.2.1"

# Declare
ARG DEBIAN_FRONTEND=noninteractive
ARG php_version="7.4"
ARG composer_version="1.10.20"

# Install package
RUN apt update -y; \
    apt --no-install-recommends -y install software-properties-common; \
    add-apt-repository -y ppa:nginx/stable; \
    apt update -y; \
    apt --no-install-recommends -y install \
    debconf-utils \
    curl \
    wget \
    git \
    supervisor \
    unzip \
    nano

# Install php
RUN apt install -y php${php_version} \
    php${php_version}-common \
    php${php_version}-cli \
    php${php_version}-fpm \
    php${php_version}-mysql \
    php${php_version}-soap \
    php${php_version}-bcmath \
    php${php_version}-xml \
    php${php_version}-mbstring \
    php${php_version}-gd \
    php${php_version}-common \
    php${php_version}-curl \
    php${php_version}-intl \
    php${php_version}-zip \
    php${php_version}-xsl \
    php${php_version}-dev \
    php${php_version}-xmlrpc \
    php${php_version}-pdo \
    php${php_version}-json \
    php${php_version}-iconv \
    php${php_version}-opcache \
    php${php_version}-ctype \
    php${php_version}-dom \
    php${php_version}-simplexml \
    php${php_version}-sockets
COPY php/magento.ini /etc/php/${php_version}/cli/conf.d/magento.ini
COPY php/magento.ini /etc/php/${php_version}/fpm/conf.d/magento.ini

# Install composer
RUN cd /tmp; \
    curl -sS https://getcomposer.org/installer | php -- --version=${composer_version} --install-dir=/usr/local/bin --filename=composer;
# Install Mysql
RUN apt install -y mysql-client mysql-server

# Install Nginx
RUN apt install -y nginx;
COPY nginx/magento.conf /etc/nginx/sites-enabled/default

# Install Redis
RUN apt install -y redis redis-tools

# Install Varnish
RUN apt install -y varnish
COPY varnish/default.vcl /etc/varnish/default.vcl
COPY varnish/varnish /etc/default/varnish

# Install Elasticsearch
RUN cd /tmp; \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.1-amd64.deb; \
    dpkg -i elasticsearch-7.6.1-amd64.deb;

# Magento Clone
WORKDIR /var/www/
RUN git clone https://github.com/magento/magento2.git;


# Set Entrypoint
COPY mysql-injector.sh /mysql-injector.sh
COPY magento-installer.sh /magento-installer.sh
COPY start.sh /start.sh
RUN chmod u+x /mysql-injector.sh /magento-installer.sh /start.sh

WORKDIR /var/www/magento2
ENTRYPOINT /start.sh
EXPOSE 80 3306 8080 6082 9000 6379 9200

