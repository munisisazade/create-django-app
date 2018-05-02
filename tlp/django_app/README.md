# README #

# #{PROJ_NAME} Project #

### --- Create project with create-django-app module ###

First you need to install create-django-app module with bellow credentials
```sh
$ git clone https://github.com/munisisazade/create-django-app.git
$ cd create-django-app/
$ python3 install.py
```

### --- Set up new project with create-django-app module ###
Create new django project with docker container :
```sh
$ create-django-app app_name
```

This module automaticly create `app_name` file and inside the configured `docker-compose.yml` and `Dockerfile`. 
`docker-compose.py`:
```yaml
version: '3'

services:

  postgres:
    container_name:  postgres-db
    image:           postgres:9.6
    ports:
      - 5432:5432 # Bind host port 5432 to PostgreSQL port 5432
    volumes:
      - ./pgdb:/var/lib/postgresql/data
    env_file: .env
    environment:
      - LC_ALL=C.UTF-8


# redis:
#   image: redis:latest
#   restart: "on-failure"
#   container_name: redis
#   ports:
#     - 6379:6379
#   volumes:
#     - ./redisdb:/var/lib/redis


# celery:
#   restart: "always"
#   build:
#     context: .
#     dockerfile: celery.dockerfile
#   container_name: celery
#   env_file: .env
#   command: celery --app=#{PROJ_NAME}.celery:app worker -B --loglevel=INFO
#   volumes:
#     - .:/src
#   links:
#     - redis
#     - postgres
#   depends_on:
#     - "redis"
#     - "postgres"


  web:
    container_name: #{PROJ_NAME}
    build: .
    restart: "always"
    env_file: .env
    environment:
      - DEBUG=True
      - TIMEOUT=300
      - HTTP_PORT=#{DOCKER_PORT}
      - STATS_PORT=#{DOCKER_PORT}
    volumes:
      - .:/code
    ports:
      - "#{DOCKER_PORT}:#{DOCKER_PORT}"
    links:
      - postgres
    depends_on:
      - "postgres"
# networks:
#   default:
#     external:
#       name: nginx-proxy
```
And `Dockerfile`:
```yaml
FROM python:3.5

# Ensure that Python outputs everything that's printed inside
# the application rather than buffering it.
ENV PYTHONUNBUFFERED 1
ENV APP_ROOT /code

# Copy in your requirements file
ADD requirements.txt /requirements.txt

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step. Correct the path to your production requirements file, if needed.
RUN pip install virtualenvwrapper
RUN python3 -m venv /venv
RUN /venv/bin/pip install -U pip
RUN /venv/bin/pip install --no-cache-dir -r /requirements.txt

# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)
RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}
COPY mime.types /etc/mime.types

# uWSGI will listen on this port
EXPOSE #{DOCKER_PORT}

# Call collectstatic (customize the following line with the minimal environment variables needed for manage.py to run):
RUN if [ -f manage.py ]; then /venv/bin/python manage.py collectstatic --noinput; fi

# Start uWSGI
CMD [ "/venv/bin/uwsgi", "--ini", "/code/uwsgi.ini"]

```

### --- Build Docker ###
After successfuly created Django app you need to Build docker bellow command:
```sh
$ cd app_name/
$ docker-compose build -d
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------
# Django inside Container #


### --- Migrate new Postgres Database ###

First you need to install Docker Helper commands
```sh
$ curl -LO https://raw.githubusercontent.com/munisisazade/docker-helper-commands/master/install.sh && bash install.sh
$ connect-docker sh app_name
Command Created by Munis
Connecting with sh  inside app_name container with docker command
/code # source /venv/bin/activate
/code # ./manage.py migrate 
```

### --- Backup database ###

If you want to backup database:
```sh
$ backup-database-docker <postgres-db-container-name>
```

### --- Restore database from dump Sql file ###

Restore database: 
```sh 
$ restore-database-docker <dump_file> <postgres-db-container-name>
```
To create your **app**, make sure youâ€™re in the same directory as manage.py and type this command: 
```
#!

$ python manage.py startapp <appname>
```



### --- Superuser ###

Create superusers using the createsuperuser command:
```
#!

$ python manage.py createsuperuser --username=joe --email=joe@example.com
```



### --- Migrate ###

By running **makemigrations**, youâ€™re telling Django that youâ€™ve made some changes to your models (in this case, youâ€™ve made new ones) and that youâ€™d like the changes to be stored as a *migration*.


```
#!

$ python manage.py makemigrations <appname>
```

Now, run **migrate** again to create those model tables in your database:


```
#!

$ python manage.py migrate
```


### --- Running tests ###

In the terminal, we can run our test:
```
#!
$ python manage.py test <appname>
```






### --- Shell ###

To invoke the Python shell, use this command:
```
#!
$ python manage.py shell
```


### --- Install dependencies ###

Installing required dependencies on virtual environment:
```
#!
$ pip freeze > requirements.txt
$ pip install -r requirements.txt
```



----------------------------------------------------------------------------------------------------------------------------------------------------------------

### --- Credits & Helpers ###
1. Extend your RAM by adding a swap file - http://stackoverflow.com/a/18335151/968751
1. Make ffmpeg executable everywhere - http://askubuntu.com/a/613799
1. FFMpeg permission denied error - http://askubuntu.com/a/478019
1. One liner ffmpeg (or other) to get only resolution? - http://askubuntu.com/a/577431 / http://stackoverflow.com/a/29585066 (json)
1. Revert to a commit by a SHA hash in Git? - http://stackoverflow.com/a/1895095

----------------------------------------------------------------------------------------------------------------------------------------------------------------

### --- Used modules & Apps ###
1. Media server: [ngnix RMTP](https://github.com/arut/nginx-rtmp-module)
1. Video edit: [ffmpeg](https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu)
