FROM php:7.2-apache

COPY SSPanel-Uim/. /usr/src/sspanel/
COPY 000-default.conf /etc/apache2/sites-enabled
COPY .config.php /usr/src/sspanel/config
COPY docker-entrypoint.sh /usr/local/bin/
ENV DB_DATABASE=sspanel
ENV DB_USERNAME=root
ENV DB_PORT=3306
WORKDIR /usr/src/sspanel/

RUN apt-get update \
    &&     apt-get -y install zlib1g-dev default-mysql-client libzip-dev libcurl4-openssl-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev cron git supervisor \
    &&     docker-php-ext-install pdo pdo_mysql mbstring bcmath zip curl mysqli gd opcache \
    &&     docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    &&     apt clean autoclean -y \
    &&     apt autoremove -y \
    &&     apt-get remove --purge \
    &&     rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN cp config/appprofile.example.php config/appprofile.php && \
    chmod -R 755 /usr/src/sspanel/storage && \
    chmod -R 777 /usr/src/sspanel/storage/framework/smarty/compile/ && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    curl -SL https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php && \
    php composer.phar install && \
    php xcat initQQWry && \
    php xcat ClientDownload && \
    crontab -l | { cat; echo "30 22 * * * php /var/www/html/xcat SendDiaryMail"; } | crontab - && \
    crontab -l | { cat; echo "0 0 * * * php /var/www/html/xcat Job DailyJob"; } | crontab - && \
    crontab -l | { cat; echo "*/1 * * * * php /var/www/html/xcat Job CheckJob"; } | crontab - && \
    { \
        echo '[program:crond]'; \
        echo 'command=cron -f'; \
        echo 'autostart=true'; \
        echo 'autorestart=true'; \
        echo 'killasgroup=true'; \
        echo 'stopasgroup=true'; \
    } | tee /etc/supervisor/crond.conf

WORKDIR /var/www/html
ENTRYPOINT "docker-entrypoint.sh"
