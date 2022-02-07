FROM wordpress:latest
RUN touch /usr/local/etc/php/conf.d/upload.ini \
         && echo 'file_uploads = On' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'upload_max_filesize = 200M' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'post_max_size = 200M' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'max_execution_time = 10000' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'memory_limit = 4096M' >> /usr/local/etc/php/conf.d/upload.ini \
RUN apt-get update
RUN apt-get install -y libz-dev libmemcached-dev && \
    pecl install memcached && \
    pecl install -o -f redis && \
    docker-php-ext-enable memcached && \
    docker-php-ext-enable redis
RUN rm -rf /tmp/pear && \
         apt-get clean
