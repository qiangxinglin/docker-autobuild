
## Wordpress Extended
[![](https://github.com/justin-himself/docker-autobuild/actions/workflows/wordpress_extended.yml/badge.svg)](https://github.com/justin-himself/docker-autobuild/actions/workflows/wordpress_extended.yml)  
![](https://img.shields.io/badge/ARCH-amd64-red)
![](https://img.shields.io/badge/ARCH-arm64-ff69b4)

### Usage

```bash
docker run \
--name wordpress \
--network wordpress \
-p 80:80 \
-p 443:443 \
-e TZ=Europe/London \
-e WORDPRESS_DB_HOST=EXAMPLE_DB \
-e WORDPRESS_DB_USER=EXAMPLE_USER \
-e WORDPRESS_DB_PASSWORD=EXAMPLE_PASSWORD \
-e WORDPRESS_DB_NAME=EXAMPLE_NAME \
-e WORDPRESS_TABLE_PREFIX=EXAMPLE_PREFIX_ \
-e WORDPRESS_DEBUG=0 \
-v EXAMPLE_PATH/wordpress:/var/www/html \
-d ghcr.io/justin-himself/wordpress_extended:master
```


### Environment Variables

