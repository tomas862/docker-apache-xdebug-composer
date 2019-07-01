# docker-apache-xdebug-composer
This repository combines basic usage of docker in apache environment with composer and xdebug


## Prerequisites

1. Install docker on your local machine

## Development environment preparation

### Basic environment preparation

1. Run `docker-compose -f docker-compose.yml -f docker-compose.local.yml up `
2. In order to have fully functional application you need to execute `composer install` or `composer update` within docker image container -  
   to do that:
   * list available docker images `docker ps`
   * find name of the image - in my case its called `docker-hello-world_web_1`
   * ssh to it. (On windows its command `winpty docker.exe exec -it docker-hello-world_web_1 sh`)
   * cd to project dir `cd /var/www/html`
   * execute `composer install` or `composer update` depending on your situation!
3. Go to `localhost:8002` and you will see that your app is launched

### Xdebug apache configuration for ide (PHPStorm)

Note - this configuration is step by step guide which targets PHPStorm only but it should
be very similar approach for other ide's.

1. Go to `File -> settings -> PHP -> debug` and make sure xdebug is on port **9000**
2. Go to `File -> settings -> PHP -> Servers` and create a new server:
    * Add any name you like
    * Make sure it listens on url `localhost` and port 8002
    * make sure your local folder is mapped with absolute path on server - enter `/var/www/html`
3. On top right corner of PHPStorm click "edit configuration"  and add new "PHP remote debug" script:
    * select a server you have mapped before - you can enter PHPSTORM as ide key but this is optional for now.
4. By applying the steps above your xdebug should be configured with the server.

### PHP-cli

`/usr/local/bin/php` - php executable

### Mysql

If you changed your root user password and mysql connection failed to be established:
docker-compose does extra work to preserve volumes between runs (thus preserving the database); you may want to try `docker-compose rm -v` to delete everything and try starting it up again.

## Production

1. run `docker-compose -f docker-compose.yml up`
2. go to `localhost:8002` - you should you app up and running