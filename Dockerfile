FROM alpine:3.22

LABEL description="Simple forum software for building great communities" \
      maintainer="kitbur <https://github.com/kitbur>"

ARG FLARUM_VERSION="v1.8.1"

ENV GID=991 \
    UID=991 \
    UPLOAD_MAX_SIZE=50M \
    PHP_MEMORY_LIMIT=128M \
    OPCACHE_MEMORY_LIMIT=128M \
    DB_HOST=mariadb \
    DB_USER=flarum \
    DB_NAME=flarum \
    DB_PORT=3306 \
    FLARUM_TITLE="Docker-Flarum" \
    DEBUG=false \
    LOG_TO_STDOUT=false \
    GITHUB_TOKEN_AUTH=false \
    FLARUM_PORT=8888

RUN apk add --no-progress --no-cache \
    curl \
    git \
    icu-data-full \
    libcap \
    nginx \
    php82 \
    php82-ctype \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-fpm \
    php82-gd \
    php82-gmp \
    php82-iconv \
    php82-intl \
    php82-mbstring \
    php82-mysqlnd \
    php82-opcache \
    php82-pecl-apcu \
    php82-openssl \
    php82-pdo \
    php82-pdo_mysql \
    php82-phar \
    php82-session \
    php82-tokenizer \
    php82-xmlwriter \
    php82-zip \
    php82-zlib \
    su-exec \
    s6 \
    s6-overlay

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN cd /tmp \
  && curl --progress-bar https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && chmod +x /usr/local/bin/composer

RUN sed -i "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/" /etc/php82/php.ini \
  && mkdir -p /run/php /flarum/app

RUN COMPOSER_CACHE_DIR="/tmp" composer create-project flarum/flarum:${FLARUM_VERSION} /flarum/app --stability=beta \
  && composer clear-cache \
  && rm -rf /flarum/.composer /tmp/*

RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/sbin/nginx

COPY rootfs /

RUN chmod +x /usr/local/bin/* /etc/s6.d/*/run /etc/s6.d/.s6-svscan/*

VOLUME /flarum/app/public/assets \
       /flarum/app/storage/logs \
       /flarum/app/packages

CMD ["/usr/local/bin/startup"]