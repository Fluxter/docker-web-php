# Fluxter PHP Container
This container support Symfony with your desired PHP version

## Environments
### Prod
`docker pull fluxter/web-php:7.4`  
`docker pull fluxter/web-php:7.3`  
`docker pull fluxter/web-php:7.2`
### Dev
`docker pull fluxter/web-php-dev:7.4`  
`docker pull fluxter/web-php-dev:7.3`  
`docker pull fluxter/web-php-dev:7.2`

## Environment Variables
You can configure the container with the following environment variables
| Variable name  | Description                                       | Default value  |
| -------------- | ------------------------------------------------- | -------------- |
| USER_ID        | The user id www-data should be mapped to          | NULL           |
| GROUP_ID       | The group id www-data should be mapped to         | NULL           |
| APP_DIR        | The base url ($APP_DIR/public is the entry point) | /app           |
| FILE_CRONTAB   | A crontab file that should be importet            | /app/crontab   |
| DOCKER_HOST_IP | The host ip of the docker container               | Set in Startup |

## How to handle own environment variables in Symfony?
Symfony now uses the Environment component.
1. Create the .env.local.dist file
2. Now you can add [Key]=$KEY this would replace Your SYMFONY Environment Variable named "Key" with the DOCKER Environment Variable "Key"

### Example:
.env.local.dist
```
APP_ENV=$APP_ENV
TESTVAR=$TESTVAR
```
Docker .env file (or environment Variables)
``` 
APP_ENV=test
```
The resulting .env file
```
APP_ENV=test
TESTVAR=$TESTVAR
``` 

## How to use
1. Copy the .env.dist to .env (Same directory as docker-compose file)
1. Create a docker-compose file
    For example use this docker-compose.dev.yml
    ```
    # Use root/example as user/password credentials
    version: "3"

    services:
      db:
        image: mysql
        command: --default-authentication-plugin=mysql_native_password
        env_file: ./.env
        ports:
          - 3363:3363
        volumes:
          - ./data/mysql:/var/lib/mysql
          
      web:
        image: fluxter/symfony-web-dev
        env_file: ../.env
        volumes:
          - ./app:/app
        ports:
          - 8080:80
        depends_on:
          - db

      pma:
        image: phpmyadmin/phpmyadmin
        ports:
          - 8081:80
        environment:
          - PMA_HOST=db
          - UPLOAD_LIMIT=2G

    ```

2. You should also change the cache directory to the unmapped folder. Edit the Kernel.php file like that:
   ```php
    public function getCacheDir()
    {
        return "/var/cache/app/" . $this->getEnvironment();
    }
    ```