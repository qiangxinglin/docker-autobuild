<img src="https://cdn.jsdelivr.net/npm/skx@0.1.3/img/uim-logo-round.png" alt="logo" width="130" height="130" align="left" />

<h1>SSPanel UIM</h1>

> Across the Great Wall we can reach every corner in the world

<br/>

![](https://img.shields.io/badge/ARCH-x86-9cf) 
![](https://img.shields.io/badge/ARCH-x86_64-red) 
![](https://img.shields.io/badge/ARCH-ARM_64-ff69b4) 
![](https://img.shields.io/badge/ARCH-ARM_v7-yellow) 
![](https://img.shields.io/badge/ARCH-ARM_v6-green) 
![](https://img.shields.io/badge/ARCH-PowerPC_64_le-blueviolet) 
![](https://img.shields.io/badge/ARCH-IBM_Z-blue) 

### Description

构建自 [SSPanel-UIM](https://github.com/Anankke/SSPanel-Uim), 添加了以下功能:
  - 多架构支持
  - 傻瓜化配置 (无需任何多余设置开箱即用!)
  - 自动初始化数据库
  - 自动更新 IP 数据库、下载客户端、初始化管理员账户
  - 自豪地使用 Apache 作为服务器程序

Todo List:
  - [ ] 解决 “流媒体解锁” 页面的 Error 问题
  - [ ] 新增时区设置, 新增用户权限设置
  - [ ] 允许变量控制 php 内存大小设置
  - [ ] 增加更多主题的镜像


### Usage


> 通过 docker-compose 创建容器 (推荐)

```.env
# .env

PATH_TO_SITE="/var/sspanel"
SSPANEL_KEY="PANEL_KEY"
SSPANEL_BASEURL="https://www.example.com"
SSPANEL_MUKEY="PANEL_MUKEY"
SSPANEL_ADMIN_EMAIL="admin@example.com"
SSPANEL_ADMIN_PASSWORD="ADMIN_PASSWORD"
SSPANEL_APPNAME="SSPanel-UIM" 
SSPANEL_DEBUG="0"
DB_HOST="sspaneldb"
DB_PORT="3306"
DB_DATABASE="sspanel"
DB_USERNAME="root"
DB_PASSWORD="DB_PASSWORD"
```

```yml
# docker-compose.yml
version: '3'

services:

    sspanel:
        image: justinhimself/sspanel-uim:latest
        container_name: sspanel
        restart: always
        ports:
            - 80:80
        networks:
            - sspanel
        volumes:
            - ${PATH_TO_SITE}/web:/var/www/html
        environment:
            SSPANEL_KEY: ${SSPANEL_KEY}
            SSPANEL_BASEURL: ${SSPANEL_BASEURL}
            SSPANEL_MUKEY: ${SSPANEL_MUKEY}
            SSPANEL_APPNAME: ${SSPANEL_APPNAME}
            SSPANEL_ADMIN_EMAIL: ${SSPANEL_ADMIN_EMAIL}
            SSPANEL_ADMIN_PASSWORD: ${SSPANEL_ADMIN_PASSWORD}
            SSPANEL_DEBUG: ${SSPANEL_DEBUG}
            DB_HOST: ${DB_HOST}
            DB_PORT: ${DB_PORT}
            DB_DATABASE: ${DB_DATABASE}
            DB_USERNAME: ${DB_USERNAME}
            DB_PASSWORD: ${DB_PASSWORD}

    sspaneldb:
        image: mariadb:latest
        container_name: sspaneldb
        restart: always
        networks:
            - sspanel
        volumes:
            - ${PATH_TO_SITE}/db:/var/lib/mysql
        environment:
            MARIADB_MYSQL_LOCALHOST_USER: ${DB_USERNAME}
            MARIADB_ROOT_PASSWORD: ${DB_PASSWORD}

networks:
    sspanel:
        
```

> 通过命令行创建容器

```bash
PATH_TO_SITE="/var/sspanel"
SSPANEL_KEY="PANEL_KEY"
SSPANEL_BASEURL="https://www.example.com"
SSPANEL_MUKEY="PANEL_MUKEY"
SSPANEL_APPNAME="SSPanel-UIM" 
SSPANEL_ADMIN_EMAIL="admin@example.com"
SSPANEL_ADMIN_PASSWORD="ADMIN_PASSWORD"
SSPANEL_DEBUG="0"
DB_HOST="sspaneldb"
DB_PORT="3306"
DB_DATABASE="sspanel"
DB_USERNAME="root"
DB_PASSWORD="DB_PASSWORD"

docker network create sspanel

docker run \
  --name sspaneldb \
  --restart always \
  --net=sspanel \
  --hostname=sspaneldb \
  -v $PATH_TO_SITE/db:/var/lib/mysql \
  -e MARIADB_MYSQL_LOCALHOST_USER=$DB_USERNAME \
  -e MARIADB_ROOT_PASSWORD=$DB_PASSWORD \
  -d mariadb:latest

docker run \
  --name sspanel \
  --restart always \
  --net=sspanel \
  --hostname="sspanel" \
  -p 80:80 \
  -v $PATH_TO_SITE/web:/var/www/html \
  -e SSPANEL_KEY=$SSPANEL_KEY \
  -e SSPANEL_BASEURL=$SSPANEL_BASEURL \
  -e SSPANEL_MUKEY=$SSPANEL_MUKEY \
  -e SSPANEL_APPNAME=$SSPANEL_APPNAME  \
  -e SSPANEL_ADMIN_EMAIL=$SSPANEL_ADMIN_EMAIL \
  -e SSPANEL_ADMIN_PASSWORD=$SSPANEL_ADMIN_PASSWORD \
  -e SSPANEL_DEBUG=$SSPANEL_DEBUG \
  -e DB_HOST=$DB_HOST \
  -e DB_PORT=$DB_PORT \
  -e DB_DATABASE=$DB_DATABASE \
  -e DB_USERNAME=$DB_USERNAME \
  -e DB_PASSWORD=$DB_PASSWORD \
  -d justinhimself/sspanel-uim:latest
```

### Parameters

| **Parameter**          | **Function**                                                 |
| ---------------------- | ------------------------------------------------------------ |
| PATH_TO_SITE           | SSPanel 以及数据库存放路径                                   |
| SSPANEL_KEY            | 修改此字符串到一随机数值以保证网站安全                       |
| SSPANEL_BASEURL        | 用于外部访问的网站域名                                       |
| SSPANEL_MUKEY          | 用于校验魔改后端请求，可以随意修改，但请保持前后端一致，否则节点不能工作 |
| SSPANEL_APPNAME        | 站点名称, 默认为 `SSPanel-UIM`                               |
| SSPANEL_ADMIN_EMAIL    | 管理员账户邮箱, 用于脚本自动创建账户<br />除非你已经手动创建过账户, 否则强烈建议填写! |
| SSPANEL_ADMIN_PASSWORD | 管理员账户密码, 用于脚本自动创建账户<br />除非你已经手动创建过账户, 否则强烈建议填写! |
| SSPANEL_DEBUG          | 可选, 默认为 0<br />生产环境请保持为 0                       |
| DB_HOST                | 数据库地址                                                   |
| DB_PORT                | 数据库端口, 默认为 `3306`                                    |
| DB_DATABASE            | 数据库名称, 默认为 `sspanel`<br />建议修改以保证安全         |
| DB_USERNAME            | 数据库用户名, 默认为 `root`                                  |
| DB_PASSWORD            | 数据库密码                                                   |









