FROM wordpress:latest
ENV TZ=Europe/London
ENV PHP_UPLOAD_MAX_FILESIZE=200M
ENV PHP_POST_MAX_SIZE=200M
ENV PHP_MAX_EXECUTION_TIME=300
ENV PHP_MEMORY_LIMIT=4096M
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN touch /usr/local/etc/php/conf.d/upload.ini \
         && echo 'file_uploads = On' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE=200M}' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'post_max_size = ${PHP_POST_MAX_SIZE=200M}' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'max_execution_time = ${PHP_MAX_EXECUTION_TIME}' >> /usr/local/etc/php/conf.d/upload.ini \
         && echo 'memory_limit = ${PHP_MEMORY_LIMIT}' >> /usr/local/etc/php/conf.d/upload.ini
RUN apt-get update
RUN apt-get install -y zlib1g-dev libmemcached-dev && \
    pecl install memcached && \
    pecl install -o -f redis && \
    docker-php-ext-enable memcached && \
    docker-php-ext-enable redis
RUN rm -rf /tmp/pear && \
         apt-get clean
