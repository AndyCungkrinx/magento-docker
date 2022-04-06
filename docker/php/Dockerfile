FROM ubuntu:20.04
LABEL maintainer="Andy Cungkrinx <andy.setiawan@sirclo.com>" \
      version.ubuntu="20.04" \
      version.php="7.4" \
      version.composer="1.10.20"

# Declare
ARG DEBIAN_FRONTEND=noninteractive
ARG php_version="7.4"
ARG composer_version="1.10.20"

# Install package
RUN apt update -y; \
    apt --no-install-recommends -y install software-properties-common; \
    apt --no-install-recommends -y install \
    debconf-utils \
    curl \
    wget \
    redis-tools \
    mysql-client \
    git
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
# Install composer
RUN cd /tmp; \
    curl -sS https://getcomposer.org/installer | php -- --version=${composer_version} --install-dir=/usr/local/bin --filename=composer;

WORKDIR /var/www

# Cleanup build and cache
RUN apt -y autoremove; \
    apt -y autoclean; \
    rm -rf /var/lib/apt/lists/* /tmp/*; \
    mkdir /run/php; \
    touch /run/php/php7.4-fpm.sock;

CMD ["php-fpm7.4", "-F", "-R"]
EXPOSE 9000