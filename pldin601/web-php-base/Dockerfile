FROM debian:jessie-backports

MAINTAINER Roman Lakhtadyr <roman.lakhtadyr@gmail.com>

ARG MAX_UPLOAD_FILESIZE=100

ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION=7.1
ENV PHP_ENV=production

# Install utilities
RUN apt-get update && \
    apt-get install -y curl apt-transport-https nginx supervisor lsb-release && \

    # Install php and composer
    (curl -sL https://packages.sury.org/php/apt.gpg | apt-key add -) && \
    (echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list) && \
    apt-get update && \
    apt-get install -y \
        php$PHP_VERSION-fpm \
        php$PHP_VERSION-cli \
        php$PHP_VERSION-mbstring \
        php$PHP_VERSION-pgsql \
        php$PHP_VERSION-xml \
        php$PHP_VERSION-gd \
        php$PHP_VERSION-mcrypt \
        php$PHP_VERSION-curl \
        php$PHP_VERSION-zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    mkdir -p /var/run/php && \

    (curl -sL https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer) && \

    # Patch configuration files
    sed -i "s/^upload_max_filesize\s=.*/upload_max_filesize = ${MAX_UPLOAD_FILESIZE}M/" /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i "s/^post_max_size\s=.*/post_max_size = ${MAX_UPLOAD_FILESIZE}M/" /etc/php/$PHP_VERSION/fpm/php.ini && \
    sed -i 's/^variables_order\s=.*/variables_order = "EGPCS"/' /etc/php/$PHP_VERSION/fpm/php.ini && \
    echo "client_max_body_size ${MAX_UPLOAD_FILESIZE}m;" > /etc/nginx/conf.d/nginx-upload.conf

# Copy configuration files
COPY ./fpm-docker.conf /etc/php/$PHP_VERSION/fpm/pool.d/
COPY ./supervisord.conf /etc/supervisor/supervisord.conf
COPY ./nginx-fpm.conf /etc/nginx/sites-available/nginx-fpm.conf
COPY ./index.php /usr/app/public/

# Configure nginx
RUN rm -f /etc/nginx/sites-enabled/* && \
    ln -s /etc/nginx/sites-available/nginx-fpm.conf /etc/nginx/sites-enabled/nginx-fpm.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

EXPOSE 8080
