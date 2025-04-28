FROM ubuntu:24.04
LABEL maintainer="Andy Cungkrinx <andy.setiawan@sirclo.com>" \
      version.ubuntu="24.04" \
      version.php="8.1" \
      version.composer="2.2.2"

# Declare
ARG DEBIAN_FRONTEND=noninteractive
ARG php_version="8.1"
ARG composer_version="2.2.2"

# Install package
RUN apt update -y; \
    apt --no-install-recommends -y install software-properties-common; \
    apt --no-install-recommends -y install \
    debconf-utils \
    gpg-agent \
    gpg \
    gnupg2 \
    gnupg \
    curl \
    wget \
    redis-tools \
    mysql-client \
    git; \
    apt-key export E5267A6C | gpg --dearmour -o /etc/apt/trusted.gpg.d/ondrejppa.gpg; \
    add-apt-repository -y ppa:ondrej/php; \
    apt update -y
# Install php
RUN apt install -y \
    php${php_version} \
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
    php${php_version}-iconv \
    php${php_version}-opcache \
    php${php_version}-ctype \
    php${php_version}-dom \
    php${php_version}-simplexml \
    php${php_version}-sockets \
    php${php_version}-xdebug \
    php${php_version}-imagick

    # Install composer
RUN cd /tmp; \
    curl -sS https://getcomposer.org/installer | php -- --version=${composer_version} --install-dir=/usr/local/bin --filename=composer;

WORKDIR /var/www

# Cleanup build and cache
RUN apt -y autoremove; \
    apt -y autoclean; \
    rm -rf /var/lib/apt/lists/* /tmp/*; \
    mkdir /run/php; \
    touch /run/php/php8.1-fpm.sock;

EXPOSE 9000
