# Fluxter PHP Container
This container support Symfony with your desired PHP version

# NOTE: For older versions
If you are looking for older php version, checkout the other branches at https://github.com/Fluxter/docker-web-php/branches  
Active Supported: 7.4, 7.3

## Environments
### Prod
`docker pull fluxter/web-php:<PHP Version>`
### Dev
`docker pull fluxter/web-php-dev:<PHP Version>`


## Environment Variables
You can configure the container with the following environment variables
| Variable name  | Description                                        | Default value         |
| -------------- | -------------------------------------------------- | --------------------- |
| APP_ROOT       | The base app path, note this is mostly for symfony | /var/www/html         |
| WEBSPACE_ROOT  | The base url ($APP_ROOT/public is the entry point) | /var/www/html/public  |
| FILE_CRONTAB   | A crontab file that should be importet             | /crontab              |
| SF_APP_ENV     | The symfony app env                                | /                     |
| FXPHP_BUILD    | A file to indicate if the system builds. It wont wait for database then | / |

## How to handle own environment variables in Symfony?
Symfony now uses the Environment component.
1. Create the .env.local.dist file
2. Now you can add [Key]=$KEY this would replace Your SYMFONY Environment Variable named "Key" with the DOCKER Environment Variable "Key"

### Example:
.env.local.dist
```
APP_ENV=$SF_APP_ENV
TESTVAR=$TESTVAR
```
Docker .env file (or environment Variables)
``` 
SF_APP_ENV=test
```
The resulting .env file
```
APP_ENV=test
TESTVAR=$TESTVAR
``` 

## How to use
Check out the examples directory for example configurations ;)

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


## Advanced Configuration
### Starting Indicator
You can check if the file /tmp/CONTAINER_STARTING (e.g. in your index.php) exists to see if the container is still starting

### Custom SSL Certificate for nginx
Just mount your .key and crt file to  
- /home/www-data/ssl/nginx-app.key
- /home/www-data/ssl/nginx-app.crt