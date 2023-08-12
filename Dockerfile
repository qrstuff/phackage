ARG baseImageTag=latest

FROM php:${baseImageTag}

# install basic extensions
RUN apt-get update && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install bcmath ctype exif fileinfo opcache pcntl pdo_mysql xml

# install php-curl extension
RUN apt-get update && \
    apt-get install -y libcurl3-dev && \
    docker-php-ext-install curl

# install php-gd extension
RUN apt-get update && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd

# install php-gmp extension
RUN apt-get update && \
    apt-get install -y libgmp-dev && \
    docker-php-ext-install gmp

# install php-imagick extension
RUN apt-get update && \
    apt-get install -y libmagickwand-dev && \
    pecl install imagick && \
    docker-php-ext-enable imagick

# install php-intl extension
RUN apt-get update && \
    apt-get -y install libicu-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

# install php-redis extension
RUN pecl install redis && \
    docker-php-ext-enable redis

ARG xdebugVersion

# install php-xdebug extension (optionally)
RUN if [ ! -z "$xdebugVersion" ]; then pecl install xdebug-$xdebugVersion && docker-php-ext-enable xdebug; fi

# install php-zip extension
RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install -j$(nproc) zip

# install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install basic utilities (for composer)
RUN apt-get update && \
    apt-get install -y curl git zip

# install mysql client
RUN apt-get update && \
    apt-get install -y default-mysql-client

# install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# install Yarn package manager
RUN npm i -g yarn
