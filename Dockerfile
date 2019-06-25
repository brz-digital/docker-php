FROM phpdockerio/php73-fpm:latest

MAINTAINER "Hugo Fabricio" <hugo@brzdigital.com.br>

# Set workdir
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    locales \
    php-memcached \
    php7.3-mysql \
    php7.3-pgsql \
    php-redis \
    php7.3-sqlite3 \
    php-xdebug \
    php7.3-bcmath \
    php7.3-bz2 \
    php7.3-dba \
    php7.3-enchant \
    php7.3-gd \
    php-gearman \
    php7.3-gmp \
    php-igbinary \
    php-imagick \
    php7.3-imap \
    php7.3-interbase \
    php7.3-intl \
    php7.3-ldap \
    php-mongodb \
    php-msgpack \
    php7.3-odbc \
    php7.3-phpdbg \
    php7.3-pspell \
    php-raphf \
    php7.3-recode \
    php7.3-snmp \
    php7.3-soap \
    php-ssh2 \
    php7.3-sybase \
    php-tideways \
    php7.3-tidy \
    php7.3-xmlrpc \
    php7.3-xsl \
    php-yaml \
    php-zmq && \
    apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Configure PHP
RUN sed -i "/post_max_size = .*/c\post_max_size = 100M" /etc/php/7.3/fpm/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 108M" /etc/php/7.3/fpm/php.ini

# Update locale
RUN locale-gen "pt_BR.UTF-8"
RUN update-locale LANG="pt_BR.UTF-8" LANGUAGE="pt_BR.UTF-8" LC_ALL="pt_BR.UTF-8"

# Update timezone
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Recife /etc/localtime