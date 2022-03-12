FROM php:7.2-apache

COPY SSPanel-Uim/. /var/www/html
WORKDIR /var/www/html

RUN apt-get update \
    &&     apt-get install         zlib1g-dev         libzip-dev         libcurl4-openssl-dev         libpng-dev         libjpeg62-turbo-dev         libfreetype6-dev         cron         git         supervisor         -y \
    &&     docker-php-ext-install         pdo         pdo_mysql         mbstring         bcmath         zip         curl         mysqli         gd         opcache \
    &&     docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    &&     apt clean autoclean -y \
    &&     apt autoremove -y \
    &&     apt-get remove --purge \
    &&     rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN cp config/.config.example.php config/.config.php && \
    cp config/appprofile.example.php config/appprofile.php && \
    chmod -R 755 storage && \
    chmod -R 777 /var/www/html/storage/framework/smarty/compile/ && \
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
