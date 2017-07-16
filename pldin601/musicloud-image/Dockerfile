FROM pldin601/web-php-media

MAINTAINER Roman Lakhtadyr <roman.lakhtadyr@gmail.com>

# Install node.js, npm, web server and media applications
RUN (curl -sL https://deb.nodesource.com/setup_8.x | bash) && \
    apt-get install -y nodejs && \
    apt-get clean && \

    mkdir -m 0777 -p /var/tmp/musicloud/files && \
    mkdir -m 0777 -p /var/tmp/musicloud/temp

VOLUME /var/tmp/musicloud
