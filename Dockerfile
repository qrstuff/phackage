ARG baseImageTag=latest

FROM php:${baseImageTag}

# install basic utilities
RUN apt-get update && \
    apt-get install -y curl git zip

# install additional PHP extensions not already bundled in the base image
RUN apt-get install -y libxml2-dev && \
    docker-php-ext-install bcmath pcntl pdo_mysql

# install php-curl extension
RUN apt-get install -y libcurl3-dev && \
    docker-php-ext-install curl

# install php-gd extension
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install -j$(nproc) gd

# install php-gmp extension
RUN apt-get install -y libgmp-dev && \
    docker-php-ext-install gmp

# install php-imagick extension
RUN apt-get install -y libmagickwand-dev && \
    git clone https://github.com/Imagick/imagick.git --single-branch /tmp/imagick && \
    cd /tmp/imagick && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    docker-php-ext-enable imagick

# install php-intl extension
RUN apt-get -y install libicu-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

# install php-redis extension
RUN printf "\n" | curl 'https://pecl.php.net/get/redis-6.3.0.tgz' -o redis-6.3.0.tgz && \
    pecl install redis-6.3.0.tgz && \
    rm -rf redis-6.3.0.tgz && \
    docker-php-ext-enable redis

ARG xdebugVersion

# install php-xdebug extension (optionally)
RUN if [ ! -z "$xdebugVersion" ]; then \
        printf "\n" | curl "https://pecl.php.net/get/xdebug-$xdebugVersion.tgz" -o xdebug-$xdebugVersion.tgz && \
        pecl install xdebug-$xdebugVersion.tgz && \
        rm -rf xdebug-$xdebugVersion.tgz && \
        docker-php-ext-enable xdebug; \
    fi

# install php-zip extension
RUN apt-get install -y libzip-dev && \
    docker-php-ext-install -j$(nproc) zip

# install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# install mysql client
RUN apt-get install -y default-mysql-client

# install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs

# install Yarn package manager
RUN npm i -g yarn
