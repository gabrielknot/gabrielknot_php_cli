FROM php:7.3-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
build-essential \
libpng-dev \
libjpeg62-turbo-dev \
libfreetype6-dev \
locales \
zip \
jpegoptim optipng pngquant gifsicle \
unzip \
curl 

RUN docker-php-ext-install pdo mbstring gd pdo_mysql # this line is changed
RUN docker-php-ext-enable gd

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

## Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


## Add user for laravel application
#RUN groupadd -g 1000 nginx
#RUN useradd -u 1000 -ms /bin/bash -g nginx nginx
#
#
## Copy existing application directory permissions
#COPY --chown=nginx:nginx . /
#
## Change current user to nginx
#USER nginx
#
## Expose port 9000 and start php-fpm server
##EXPOSE 9000
