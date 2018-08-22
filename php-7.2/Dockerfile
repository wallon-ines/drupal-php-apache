FROM php:7.2-apache

ENV DEBIAN_FRONTEND noninteractive
ENV DRUSH_LAUNCHER_VERSION 0.4.3

ADD bin/docker-php-pecl-install /usr/local/bin/

RUN apt-get update && apt-get install -y \
        git \
        imagemagick \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libjpeg-turbo-progs \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        mysql-client \
        pngquant \
        python \
        ssmtp \
        sudo \
        unzip \
        wget \
        zlib1g-dev

RUN docker-php-ext-install \
        bcmath \
        curl \
        exif \
        mbstring \
        mysqli \
        opcache \
        pcntl \
        pdo_mysql \
        soap \
        zip \
    && apt-get clean && apt-get autoremove -q \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/* \
    && a2enmod deflate expires headers mime rewrite proxy proxy_http ssl \
    && a2dissite 000-default \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/conf-sendmail.ini \
    && echo "date.timezone='Europe/Paris'\n" > /usr/local/etc/php/conf.d/conf-date.ini

# Install Uploadprogress
RUN git clone https://git.php.net/repository/pecl/php/uploadprogress.git \
    && cd uploadprogress \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf uploadprogress \
    && echo "extension=uploadprogress.so" > /usr/local/etc/php/conf.d/conf-uploadprogress.ini

# Install PhpRedis.
RUN git clone https://github.com/phpredis/phpredis.git \
    && cd phpredis \
    && phpize \
    && ./configure \
    && make && make install \
    && cd .. \
    && rm -rf phpredis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/conf-redis.ini

# Install Composer.
RUN cd /usr/local \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x /usr/local/composer.phar \
    && ln -s /usr/local/composer.phar /usr/local/bin/composer \
    && echo 'PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc

# Install Drush Launcher.
RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/$DRUSH_LAUNCHER_VERSION/drush.phar \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
&& drush self-update

# Install hirak/prestissimo
RUN composer global require "hirak/prestissimo" --prefer-dist --no-progress --no-suggest --classmap-authoritative

RUN composer clear-cache

# Add some bash aliases.
RUN echo 'alias ll="ls -l"' >> $HOME/.bashrc \
    && echo 'alias lll="ls -al"' >> $HOME/.bashrc

WORKDIR /project/

COPY ./bin/entrypoint.sh /bin/
RUN chmod a+x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["apache2-foreground"]
