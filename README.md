# create-django-app #
 

### --- Installation command ###

First check this bellow command:
One line download script copy paste your terminal
```
#!
$ git clone https://github.com/munisisazade/create-django-app.git && cd create-django-app/ && python3 install.py && cd .. && rm -rf create-django-app/
```

### --- Set up synced folders ###
Create new Django app with bellow command:
```
#!

$ create-django-app talasemia
```

# Documentations #

### First Installation step ###
![](https://raw.githubusercontent.com/munisisazade/create-django-app/master/doc/img/installation.gif)

----------------------------------------------------------------------------------------------------------------------------------------------------------------
# Django #


### --- Activate Virtualenviroment Python 3 ###

Change into the directory, you want create virtual environment:
```
#!

$ source .venv/bin/activate
```

### --- The development server ###

Change into the outer mysite directory, if you havenâ€™t already, and run the following commands:
```
#!

$ python manage.py runserver
```

### --- Creating a project / app ###

Project: 
```
#!

$ django-admin startproject <myproject>
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
