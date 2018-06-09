#!/bin/bash
# Author Munis Isazade Django developer
VERSION="1.6.7"
ERROR_STATUS=0
ROOT_DIRECTION=$(pwd)
GIT_DIRECTORY=~/.create-django-app/
ISSUE_URL="https://github.com/munisisazade/create-django-app/issues"
PACKAGE_CHANGE="#pkg-resources"

#usage: ChangeColor $COLOR text/background
function ChangeColor()
{
	TYPE=""
	case "$2" in
	"text") TYPE="setaf"
	;;
	"back") TYPE="setab"
	;;
	*) TYPE="setaf"
	esac



	case "$1" in
	"red") tput "$TYPE" 1
	;;
	"orange") tput "$TYPE" 3
	;;
	"blue") tput "$TYPE" 4
	;;
	"green") tput "$TYPE" 2
	;;
	"black") tput "$TYPE" 0
	;;
	"white") tput "$TYPE" 7
	;;
	"magenta") tput "$TYPE" 5
	;;
	"cyan") tput "$TYPE" 7
	;;
	*) tput "$TYPE" 0
	esac
}

# echo -e "$(ChangeColor red text) RED $(ChangeColor white text)"
# echo -e "$(ChangeColor orange text) Orange $(ChangeColor white text)"
# echo -e "$(ChangeColor blue text) Blue $(ChangeColor white text)"
# echo -e "$(ChangeColor green text) Green $(ChangeColor white text)"
# echo -e "$(ChangeColor black text) Black $(ChangeColor white text)"
# echo -e "$(ChangeColor white text) White $(ChangeColor white text)"
# echo -e "$(ChangeColor magenta text) Magenta $(ChangeColor white text)"
# echo -e "$(ChangeColor cyan text) Cyan $(ChangeColor white text)"

function usage {
    echo -e "Please specify the project directory:"
    echo -e "$(ChangeColor blue text)  create-django-app $(ChangeColor green text)<project-directory>$(ChangeColor white text)"
    echo -e "\n"
    echo -e "For example:"
    echo -e "$(ChangeColor blue text)  create-django-app $(ChangeColor green text)my-django-app$(ChangeColor white text)"
    echo -e "\n"
	echo -e "Run $(ChangeColor blue text)create-django-app --help$(ChangeColor white text) to see all options."

    exit 1
}

function helping {
	echo -e "\n"
	echo -e " Usage: create-react-app $(ChangeColor green text)<project-directory>$(ChangeColor white text) [options]"
  	echo -e "\n"
  	echo -e " Options:"
  	echo -e "\n"
  	echo -e "  -V, --version                            output the version number"
  	echo -e "  --verbose                                print additional logs"
  	echo -e "  -h, --help                               output usage information"
  	echo -e "  -a, --author                             about author information"
  	echo -e "  -g, git                                  add git repository to current project"
  	echo -e "  -u, --update, -U                         update package new version"
  	echo -e "  --alphine                                create project small docker container with linux Alphine"
  	echo -e "  --no-posgres                             create project without Postgres database only Sqlite3"
  	echo -e "  --oscar-app                             	create project django-oscar ecommerce"
  	echo -e "  --django-downgrade                       create project django==1.11.9 version"
  	echo -e "  Only $(ChangeColor green text)<project-directory>$(ChangeColor white text) is required."
  	echo -e "\n"
  	echo -e "  If you have any problems, do not hesitate to file an issue:"
  	echo -e "    $(ChangeColor blue text)$ISSUE_URL$(ChangeColor white text)"


}

function options_usage {
	echo -e "\n"
	echo -e " Options usage example: create-react-app $(ChangeColor green text)$FILE$(ChangeColor white text) --no-posgres"
  	echo -e "\n"
  	echo -e " Options:"
  	echo -e "\n"
  	echo -e "  -V, --version                            output the version number"
  	echo -e "  --verbose                                print additional logs"
  	echo -e "  -h, --help                               output usage information"
  	echo -e "  -a, --author                             about author information"
  	echo -e "  --no-posgres                             if dont want use postgres db"
  	echo -e "  --oscar-app                             	add django-oscar ecommerce"
  	echo -e "  Only $(ChangeColor green text)$FILE$(ChangeColor white text) is required."
  	echo -e "\n"
  	echo -e "  If you have any problems, do not hesitate to file an issue:"
  	echo -e "    $(ChangeColor blue text)$ISSUE_URL$(ChangeColor white text)"	
}


#function Get version
function get_version {
	echo -e "$VERSION"
}

function get_author {
	echo -e "Munis Isazade       <munisisazade@gmail.com>"
}

function base_script {
	FILE=$1
	OPTIONS=$2

	if [[ -v OPTIONS ]];then
		case ${OPTIONS} in

			-a | --author)
				get_author
			;;

			-V | --version)
				get_version
			;;

		    -h | --help)

				helping

			;;
			--no-posgres)
				NOT_POSGRES="No postgres"
			;;

			--oscar-app )
				OSCAR_APP="with Oscar app"
			;;

			--django-downgrade ) 
				DJANGO_VERSİON="download with 1.11.9 version django"
			;;
            --alphine )
                ALPHINE_LINUX="with small project"
            ;;
			
		esac		
	fi
	if [ -d $FILE ]; then
	   echo "The directory $(ChangeColor green text)$FILE$(ChangeColor white text) contains files that could conflict:$(ChangeColor red text)"
	   cd $FILE
	   ls
	   echo -e "\n"
	   echo -e "$(ChangeColor white text)Either try using a new directory name, or remove the files listed above"
	   exit 1
	else
	    if [[ $FILE = *"-"* ]]; then
            helping
            exit 1
        fi
        weebhook
	    echo "Creating File ... $NOT_POSGRES $OSCAR_APP $ALPHINE_LINUX"
	    sleep 3
	    mkdir $ROOT_DIRECTION/$FILE
	    echo -e "Get into $FILE"
	    cd $FILE
	    echo -e "First create virtual enviroment"
	    progress30
	    echo -e "$(ChangeColor red text)"
		python3 -m venv .venv
		if [ $? -eq 0 ]; then
		    echo "$(ChangeColor white text)OK"
		else
		    echo "FAIL $(ChangeColor white text)"
		    echo "Install python3 virtualenviroment created"
		    sudo apt-get -y install python3-pip python3-dev libpq-dev python3-venv
		    sudo apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
		    python3.5 -m venv .venv
		fi
		echo -e "Swich virtualenviroment"
		source .venv/bin/activate
		echo -e "Installing Django and Pillow with pip library"
		pip install django pillow gunicorn uwsgi psycopg2 django-ckeditor django-widget-tweaks
		if [[ -v OSCAR_APP ]];then
		echo "(ChangeColor green text)Installing Oscar app ...$(ChangeColor white text)"
		pip install django-oscar django-modeltranslation django-ckeditor
		fi
		echo -e "Updating pip library .."
		pip install -U pip
		read -p "Do you want to install aditional package (y,n)?" aditional
		if [ "$aditional" == y ] ; then
		    echo -e "Aditional package install"
		    read -p "Package name or names: " packages_list
		    pip install $packages_list
		fi

		echo -e "Create requirement.txt"
		# touch requirements.txt
		# echo "Django" >> requirements.txt
		# echo "psycopg2" >> requirements.txt
		# echo "uwsgi" >> requirements.txt
		pip freeze > requirements.txt
		sed -i -e 's|pkg-resources|'$PACKAGE_CHANGE'|g' requirements.txt
		AUTHOR_NAME="Munis Isazade      <munisisazade@gmail.com>    Senior Django developer"
		echo $AUTHOR_NAME >> contributors.txt
		echo "Creating .gitignore file"
		echo "pgdb/" >> .gitignore
		echo ".idea/" >> .gitignore
		echo "media/" >> .gitignore
		echo ".venv" >> .gitignore
		echo "db.sqlite3" >> .gitignore
		echo "Creating .dockerignore file"
		touch .dockerignore
		echo ".idea/" >> .dockerignore
		echo ".venv/" >> .dockerignore
		echo "contributors.txt" >> .dockerignore
		echo "*.pyc" >> .dockerignore
		echo ".git/" >> .dockerignore
		read -p "Project name: " PROJ_NAME
		django-admin startproject $PROJ_NAME .
		echo -e "Create app"
		read -p "Django app name : " APP_NAME
		python manage.py startapp $APP_NAME
		echo -e "Creating Database .."
		python manage.py migrate
		echo "STATIC_ROOT='static'" >> $PROJ_NAME/settings.py
		progress30
		docker_container
		if [[ -v OSCAR_APP ]];then
			echo "$(ChangeColor green text)Oscar files configurations ...$(ChangeColor white text)"
			oscar_configuration
		else
			echo "$(ChangeColor green text)Django2 files configurations ...$(ChangeColor white text)"
			django_2_configuration
		fi
		ask_git
		finish
	fi
}

# Check webhook tool updates
function weebhook {
    cd $GIT_DIRECTORY
    GIT_FETCH=$(git fetch)
    WEBHOOK=$(git status)
    if [[ $WEBHOOK = *"git pull"* ]]; then
        webhook_message=$(curl https://raw.githubusercontent.com/munisisazade/create-django-app/master/message.txt)
        echo -e "Opps This tool might be update"
        echo -e "$(ChangeColor green text)$webhook_message $(ChangeColor white text)"
        exit 1
#        read -p "Do you want to update create-django-app(y,n)?" update_status
#		if [ "$update_status" == y ] ; then
#		    echo -e "If you want to update package"
#		    read -p "Package name or names: " packages_list
#		    pip install $packages_list
#		fi
    else
        echo -e " "
    fi
    cd $ROOT_DIRECTION
}

function progress30 {
	echo -ne '                    (0%)\r'
	sleep 0.5
	echo -ne '##                  (10%)\r'
	sleep 0.5
	echo -ne '####                (20%)\r'
	sleep 0.5
	echo -ne '######              (30%)\r'
	sleep 0.5
	echo -ne '########            (40%)\r'
	sleep 0.5
	echo -ne '##########          (50%)\r'
	sleep 0.5
	echo -ne '############        (60%)\r'
	sleep 0.5
	echo -ne '##############      (70%)\r'
	sleep 0.5
	echo -ne '################    (80%)\r'
	sleep 0.5
	echo -ne '##################  (90%)\r'
	sleep 0.5
	echo -ne '####################(100%)\r'
	echo -ne '\n'
}

function docker_container {
	if [[ -v NOT_POSGRES ]];then
		echo "Not create env_file $(ChangeColor red text)FAIL$(ChangeColor white text)"
	else
		env_file
		echo -e "Creating env_file...  $(ChangeColor green text)OK$(ChangeColor white text)"
	fi
	
	echo -e "Creating mime_types...  $(ChangeColor green text)OK$(ChangeColor white text)"
	mime_types
	echo -e "Creating docker_file...  $(ChangeColor green text)OK$(ChangeColor white text)"
	if [[ -v ALPHINE_LINUX ]];then
	    docker_alphine_linux
	else
	    docker_file
	fi
	echo -e "Creating docker_compose... $(ChangeColor green text)OK$(ChangeColor white text)"
	docker_compose
	echo -e "Creating celery_dockerfile...  $(ChangeColor green text)OK$(ChangeColor white text)"
	celery_dockerfile
	echo -e "Creating uwsgi_ini...  $(ChangeColor green text)OK$(ChangeColor white text)"
	uwsgi_ini
}

function env_file {
	touch .env
	echo "# PostgreSQL" >> .env
	read -p "PostgreSQL Database name " POSGRES_DB_NAME
	if [ "$POSGRES_DB_NAME" == '' ] ; then
	    POSGRES_DB_NAME=db_rds
	fi
	echo "POSTGRES_DB=$POSGRES_DB_NAME" >> .env
	read -p "PostgreSQL Database Username " POSGRES_DB_USER
	if [ "$POSGRES_DB_USER" == '' ] ; then
	    POSGRES_DB_USER=db_user
	fi
	echo "POSTGRES_USER=$POSGRES_DB_USER" >> .env
	read -p "PostgreSQL Database Password " POSGRES_DB_PASSWORD
	if [ "$POSGRES_DB_PASSWORD" == '' ] ; then
	    POSGRES_DB_PASSWORD=jBQjMFqxTSGTk6iT
	fi
	echo "POSTGRES_PASSWORD=$POSGRES_DB_PASSWORD" >> .env
	echo "POSTGRES_HOST=postgres" >> .env
	echo "POSTGRES_PORT=5432" >> .env
}

function mime_types {
	touch mime.types
	echo "# mime type definition extracted from nginx" >> mime.types
	echo "# https://github.com/nginx/nginx/blob/master/conf/mime.types" >> mime.types
	echo "" >> mime.types
	echo "text/html                             html htm shtml" >> mime.types
	echo "text/css                              css" >> mime.types
	echo "text/xml                              xml" >> mime.types
	echo "image/gif                             gif" >> mime.types
	echo "image/jpeg                            jpeg jpg" >> mime.types
	echo "application/javascript                js" >> mime.types
	echo "application/atom+xml                  atom" >> mime.types
	echo "application/rss+xml                   rss" >> mime.types
	echo "" >> mime.types
	echo "text/mathml                           mml" >> mime.types
	echo "text/plain                            txt" >> mime.types
	echo "text/vnd.sun.j2me.app-descriptor      jad" >> mime.types
	echo "text/vnd.wap.wml                      wml" >> mime.types
	echo "text/x-component                      htc" >> mime.types
	echo "" >> mime.types
	echo "image/png                             png" >> mime.types
	echo "image/tiff                            tif tiff" >> mime.types
	echo "image/vnd.wap.wbmp                    wbmp" >> mime.types
	echo "image/x-icon                          ico" >> mime.types
	echo "image/x-jng                           jng" >> mime.types
	echo "image/x-ms-bmp                        bmp" >> mime.types
	echo "image/svg+xml                         svg svgz" >> mime.types
	echo "image/webp                            webp" >> mime.types
	echo "" >> mime.types
	echo "application/font-woff                 woff" >> mime.types
	echo "application/java-archive              jar war ear" >> mime.types
	echo "application/json                      json" >> mime.types
	echo "application/mac-binhex40              hqx" >> mime.types
	echo "application/msword                    doc" >> mime.types
	echo "application/pdf                       pdf" >> mime.types
	echo "application/postscript                ps eps ai" >> mime.types
	echo "application/rtf                       rtf" >> mime.types
	echo "application/vnd.apple.mpegurl         m3u8" >> mime.types
	echo "application/vnd.ms-excel              xls" >> mime.types
	echo "application/vnd.ms-fontobject         eot" >> mime.types
	echo "application/vnd.ms-powerpoint         ppt" >> mime.types
	echo "application/vnd.wap.wmlc              wmlc" >> mime.types
	echo "application/vnd.google-earth.kml+xml  kml" >> mime.types
	echo "application/vnd.google-earth.kmz      kmz" >> mime.types
	echo "application/x-7z-compressed           7z" >> mime.types
	echo "application/x-cocoa                   cco" >> mime.types
	echo "application/x-java-archive-diff       jardiff" >> mime.types
	echo "application/x-java-jnlp-file          jnlp" >> mime.types
	echo "application/x-makeself                run" >> mime.types
	echo "application/x-perl                    pl pm" >> mime.types
	echo "application/x-pilot                   prc pdb" >> mime.types
	echo "application/x-rar-compressed          rar" >> mime.types
	echo "application/x-redhat-package-manager  rpm" >> mime.types
	echo "application/x-sea                     sea" >> mime.types
	echo "application/x-shockwave-flash         swf" >> mime.types
	echo "application/x-stuffit                 sit" >> mime.types
	echo "application/x-tcl                     tcl tk" >> mime.types
	echo "application/x-x509-ca-cert            der pem crt" >> mime.types
	echo "application/x-xpinstall               xpi" >> mime.types
	echo "application/xhtml+xml                 xhtml" >> mime.types
	echo "application/xspf+xml                  xspf" >> mime.types
	echo "application/zip                       zip" >> mime.types
	echo "" >> mime.types
	echo "application/octet-stream              bin exe dll" >> mime.types
	echo "application/octet-stream              deb" >> mime.types
	echo "application/octet-stream              dmg" >> mime.types
	echo "application/octet-stream              iso img" >> mime.types
	echo "application/octet-stream              msi msp msm" >> mime.types
	echo "" >> mime.types
	echo "application/vnd.openxmlformats-officedocument.wordprocessingml.document    docx" >> mime.types
	echo "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet          xlsx" >> mime.types
	echo "application/vnd.openxmlformats-officedocument.presentationml.presentation  pptx" >> mime.types
	echo "" >> mime.types
	echo "audio/midi                            mid midi kar" >> mime.types
	echo "audio/mpeg                            mp3" >> mime.types
	echo "audio/ogg                             ogg" >> mime.types
	echo "audio/x-m4a                           m4a" >> mime.types
	echo "audio/x-realaudio                     ra" >> mime.types
	echo "" >> mime.types
	echo "video/3gpp                            3gpp 3gp" >> mime.types
	echo "video/mp2t                            ts" >> mime.types
	echo "video/mp4                             mp4" >> mime.types
	echo "video/mpeg                            mpeg mpg" >> mime.types
	echo "video/quicktime                       mov" >> mime.types
	echo "video/webm                            webm" >> mime.types
	echo "video/x-flv                           flv" >> mime.types
	echo "video/x-m4v                           m4v" >> mime.types
	echo "video/x-mng                           mng" >> mime.types
	echo "video/x-ms-asf                        asx asf" >> mime.types
	echo "video/x-ms-wmv                        wmv" >> mime.types
	echo "video/x-msvideo                       avi" >> mime.types
}

function docker_file {
	touch Dockerfile
	echo "FROM python:3.5" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Ensure that Python outputs everything that's printed inside" >> Dockerfile
	echo "# the application rather than buffering it." >> Dockerfile
	echo "ENV PYTHONUNBUFFERED 1" >> Dockerfile
	echo "ENV APP_ROOT /code" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Copy in your requirements file" >> Dockerfile
	echo "ADD requirements.txt /requirements.txt" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Install build deps, then run \`pip install\`, then remove unneeded build deps all in a single step. Correct the path to your production requirements file, if needed." >> Dockerfile
	echo "RUN pip install virtualenvwrapper" >> Dockerfile
	echo "RUN python3 -m venv /venv" >> Dockerfile
	echo "RUN /venv/bin/pip install -U pip" >> Dockerfile
	echo "RUN /venv/bin/pip install --no-cache-dir -r /requirements.txt" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)" >> Dockerfile
	echo "RUN mkdir \${APP_ROOT}" >> Dockerfile
	echo "WORKDIR \${APP_ROOT}" >> Dockerfile
	echo "ADD . \${APP_ROOT}" >> Dockerfile
	echo "COPY mime.types /etc/mime.types" >> Dockerfile
	echo "" >> Dockerfile
	echo "# uWSGI will listen on this port" >> Dockerfile
	read -p "Which port do you want to use(choose range 8000~8999)?" DOCKER_PORT
	if [ "$DOCKER_PORT" == '' ] ; then
	    DOCKER_PORT=8050
	fi
	echo "EXPOSE $DOCKER_PORT" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Call collectstatic (customize the following line with the minimal environment variables needed for manage.py to run):" >> Dockerfile
	echo "RUN if [ -f manage.py ]; then /venv/bin/python manage.py collectstatic --noinput; fi" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Start uWSGI" >> Dockerfile
	echo "CMD [ \"/venv/bin/uwsgi\", \"--ini\", \"/code/uwsgi.ini\"]" >> Dockerfile
}


function docker_alphine_linux {
	touch Dockerfile
	echo "FROM python:3.5-alpine" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Ensure that Python outputs everything that's printed inside" >> Dockerfile
	echo "# the application rather than buffering it." >> Dockerfile
	echo "ENV PYTHONUNBUFFERED 1" >> Dockerfile
	echo "ENV APP_ROOT /code" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Copy in your requirements file" >> Dockerfile
	echo "ADD requirements.txt /requirements.txt" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Install build deps, then run \`pip install\`, then remove unneeded build deps all in a single step. Correct the path to your production requirements file, if needed." >> Dockerfile
	echo "RUN set -ex \\" >> Dockerfile
	echo "    && apk add --no-cache --virtual .build-deps \\" >> Dockerfile
	echo "              gcc g++ \\" >> Dockerfile
	echo "              make \\" >> Dockerfile
	echo "              libc-dev \\" >> Dockerfile
	echo "              musl-dev \\" >> Dockerfile
	echo "              linux-headers \\" >> Dockerfile
	echo "              pcre-dev \\" >> Dockerfile
	echo "              postgresql-dev \\" >> Dockerfile
	echo "              jpeg-dev \\" >> Dockerfile
	echo "              zlib-dev \\" >> Dockerfile
	echo "              freetype-dev \\" >> Dockerfile
	echo "              lcms2-dev \\" >> Dockerfile
	echo "              openjpeg-dev \\" >> Dockerfile
	echo "              tiff-dev \\" >> Dockerfile
	echo "              tk-dev \\" >> Dockerfile
	echo "              tcl-dev \\" >> Dockerfile
	echo "              harfbuzz-dev \\" >> Dockerfile
	echo "              fribidi-dev \\" >> Dockerfile
	echo "    && pyvenv /venv \\" >> Dockerfile
	echo "    && /venv/bin/pip install -U pip \\" >> Dockerfile
	echo '    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "/venv/bin/pip install --no-cache-dir -r /requirements.txt" \' >> Dockerfile
	echo '    && runDeps="$( \' >> Dockerfile
	echo "            scanelf --needed --nobanner --recursive /venv \\" >> Dockerfile
	echo "                    | awk '{ gsub(/,/, \"\nso:\", \$2); print \"so:\" \$2 }' \\" >> Dockerfile
	echo "                    | sort -u \\" >> Dockerfile
	echo "                    | xargs -r apk info --installed \\" >> Dockerfile
	echo "                    | sort -u \\" >> Dockerfile
	echo "    )\" \\" >> Dockerfile
	echo "    && apk add --virtual .python-rundeps \$runDeps \\" >> Dockerfile
	echo "    && apk del .build-deps" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)" >> Dockerfile
	echo "RUN mkdir \${APP_ROOT}" >> Dockerfile
	echo "WORKDIR \${APP_ROOT}" >> Dockerfile
	echo "ADD . \${APP_ROOT}" >> Dockerfile
	echo "COPY mime.types /etc/mime.types" >> Dockerfile
	echo "" >> Dockerfile
	echo "# uWSGI will listen on this port" >> Dockerfile
	read -p "Which port do you want to use(choose range 8000~8999)?" DOCKER_PORT
	if [ "$DOCKER_PORT" == '' ] ; then
	    DOCKER_PORT=8050
	fi
	echo "EXPOSE $DOCKER_PORT" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Call collectstatic (customize the following line with the minimal environment variables needed for manage.py to run):" >> Dockerfile
	echo "RUN if [ -f manage.py ]; then /venv/bin/python manage.py collectstatic --noinput; fi" >> Dockerfile
	echo "" >> Dockerfile
	echo "# Start uWSGI" >> Dockerfile
	echo "CMD [ \"/venv/bin/uwsgi\", \"--ini\", \"/code/uwsgi.ini\"]" >> Dockerfile
}

function docker_compose {
	touch docker-compose.yml
	echo "version: '3'" >> docker-compose.yml
	if [[ -v NOT_POSGRES ]];then
		echo "" >> docker-compose.yml	
	else
		echo "" >> docker-compose.yml
		echo "services:" >> docker-compose.yml
		echo "" >> docker-compose.yml
		echo "  postgres:" >> docker-compose.yml
		echo "    container_name:  postgres-db" >> docker-compose.yml
		echo "    image:           postgres:9.6" >> docker-compose.yml
		echo "    ports:" >> docker-compose.yml
		echo "      - 5432:5432 # Bind host port 5432 to PostgreSQL port 5432" >> docker-compose.yml
		echo "    volumes:" >> docker-compose.yml
		echo "      - ./pgdb:/var/lib/postgresql/data" >> docker-compose.yml
		echo "    env_file: .env" >> docker-compose.yml
		echo "    environment:" >> docker-compose.yml
		echo "      - LC_ALL=C.UTF-8" >> docker-compose.yml
		echo "" >> docker-compose.yml
		echo "" >> docker-compose.yml
		echo "# redis:" >> docker-compose.yml
    	echo "#   image: redis:latest" >> docker-compose.yml
    	echo "#   restart: \"on-failure\"" >> docker-compose.yml
    	echo "#   container_name: redis" >> docker-compose.yml
    	echo "#   ports:" >> docker-compose.yml
     	echo "#     - 6379:6379" >> docker-compose.yml
    	echo "#   volumes:" >> docker-compose.yml
      	echo "#     - ./redisdb:/var/lib/redis" >> docker-compose.yml
      	echo "" >> docker-compose.yml
      	echo "" >> docker-compose.yml
  		echo "# celery:" >> docker-compose.yml
    	echo "#   restart: \"always\"" >> docker-compose.yml
    	echo "#   build:" >> docker-compose.yml
      	echo "#   context: ." >> docker-compose.yml
      	echo "#   dockerfile: celery.dockerfile" >> docker-compose.yml
    	echo "#   container_name: celery" >> docker-compose.yml
    	echo "#   env_file: .env" >> docker-compose.yml
    	echo "#   command: celery --app=$PROJ_NAME.celery:app worker -B --loglevel=INFO" >> docker-compose.yml
    	echo "#   volumes:" >> docker-compose.yml
      	echo "#     - .:/src" >> docker-compose.yml
    	echo "#   links:" >> docker-compose.yml
      	echo "#     - redis" >> docker-compose.yml
      	echo "#     - postgres" >> docker-compose.yml
    	echo "#   depends_on:" >> docker-compose.yml
      	echo "#     - \"redis\"" >> docker-compose.yml
      	echo "#     - \"postgres\"" >> docker-compose.yml
      	echo "" >> docker-compose.yml
      	echo "" >> docker-compose.yml
	fi
	echo "  web:" >> docker-compose.yml
	echo "    container_name: $PROJ_NAME" >> docker-compose.yml
	echo "    build: ." >> docker-compose.yml
	echo "    restart: \"always\"" >> docker-compose.yml
	if [[ -v NOT_POSGRES ]];then
		:
	else
		echo "    env_file: .env" >> docker-compose.yml
	fi
	echo "    environment:" >> docker-compose.yml
	echo "      - DEBUG=True" >> docker-compose.yml
	echo "      - TIMEOUT=300" >> docker-compose.yml
	echo "      - HTTP_PORT=$DOCKER_PORT" >> docker-compose.yml
	OTHERPORT=`expr $DOCKER_PORT + 1`
	echo "      - STATS_PORT=$OTHERPORT" >> docker-compose.yml
	echo "    volumes:" >> docker-compose.yml
	echo "      - .:/code" >> docker-compose.yml
	echo "    ports:" >> docker-compose.yml
	echo "      - \"$DOCKER_PORT:$DOCKER_PORT\"" >> docker-compose.yml
	if [[ -v NOT_POSGRES ]];then
		echo "" >> docker-compose.yml
	else
		echo "    links:" >> docker-compose.yml
		echo "      - postgres" >> docker-compose.yml
		echo "    depends_on:" >> docker-compose.yml
		echo "      - \"postgres\"" >> docker-compose.yml
	fi
	echo "# networks:" >> docker-compose.yml
  	echo "#   default:" >> docker-compose.yml
    echo "#     external:" >> docker-compose.yml
    echo "#       name: nginx-proxy" >> docker-compose.yml
}

function celery_dockerfile {
	touch celery.dockerfile
	echo "FROM python:latest" >> celery.dockerfile
	echo "ENV PYTHONUNBUFFERED 1" >> celery.dockerfile
	echo "" >> celery.dockerfile
	echo "#ENV C_FORCE_ROOT true" >> celery.dockerfile
	echo "" >> celery.dockerfile
	echo "ENV APP_USER myapp" >> celery.dockerfile
	echo "ENV APP_ROOT /src" >> celery.dockerfile
	echo "RUN mkdir /src;" >> celery.dockerfile
	echo "RUN groupadd -r \${APP_USER} \\" >> celery.dockerfile
	echo "    && useradd -r -m \\" >> celery.dockerfile
	echo "    --home-dir \${APP_ROOT} \\" >> celery.dockerfile
	echo "    -s /usr/sbin/nologin \\" >> celery.dockerfile
	echo "    -g \${APP_USER} \${APP_USER}" >> celery.dockerfile
	echo "" >> celery.dockerfile
	echo "WORKDIR \${APP_ROOT}" >> celery.dockerfile
	echo "" >> celery.dockerfile
	echo "RUN mkdir /config" >> celery.dockerfile
	echo "ADD requirements.txt /config/" >> celery.dockerfile
	echo "RUN pip install --no-cache-dir -r /config/requirements.txt" >> celery.dockerfile
	echo "" >> celery.dockerfile
	echo "USER \${APP_USER}" >> celery.dockerfile
	echo "ADD . \${APP_ROOT}" >> celery.dockerfile
}

function uwsgi_ini {
	touch uwsgi.ini
	echo "[uwsgi]" >> uwsgi.ini
	echo "env = DJANGO_SETTINGS_MODULE=$PROJ_NAME.settings" >> uwsgi.ini
	echo "env = UWSGI_VIRTUALENV=/venv" >> uwsgi.ini
	echo "env = IS_WSGI=True" >> uwsgi.ini
	echo "env = LANG=en_US.UTF-8" >> uwsgi.ini
	echo "workdir = /code" >> uwsgi.ini
	echo "chdir = /code" >> uwsgi.ini
	echo "module = $PROJ_NAME.wsgi:application" >> uwsgi.ini
	echo "master = True" >> uwsgi.ini
	echo "pidfile = /tmp/app-master.pid" >> uwsgi.ini
	echo "vacuum = True" >> uwsgi.ini
	echo "max-requests = 5000" >> uwsgi.ini
	echo "processes = 5" >> uwsgi.ini
	echo "cheaper = 2" >> uwsgi.ini
	echo "cheaper-initial = 5" >> uwsgi.ini
	echo "gid = root" >> uwsgi.ini
	echo "uid = root" >> uwsgi.ini
	echo "http-socket = 0.0.0.0:\$(HTTP_PORT)" >> uwsgi.ini
	echo "stats = 0.0.0.0:\$(STATS_PORT)" >> uwsgi.ini
	echo "harakiri = \$(TIMEOUT)" >> uwsgi.ini
	echo "print = Your timeout is %(harakiri)" >> uwsgi.ini
	echo "static-map = /static=%(workdir)/static" >> uwsgi.ini
	echo "static-map = /media=%(workdir)/media" >> uwsgi.ini
	# echo "if-exists = %(workdir)/media" >> uwsgi.ini
	# echo "route = /media/(.*) media:%(workdir)/media/\$1" >> uwsgi.ini
	# echo "endif =" >> uwsgi.ini
}

# Oscar configuration add project
function oscar_configuration {
	echo -e "Get Django application SECRET_KEY"
	SECRET_KEY=$(python manage.py diffsettings | grep 'SECRET_KEY' | cut -d' ' -f 3)
	DJANGO_UP_APP_NAME=$(python3 -c 'a="'$APP_NAME'";d=[x.capitalize() for x in a.split("_")];print("".join(d))')
	echo -e "configuration files add"
	cp -r ~/.local/share/django_app/middleware/ $PROJ_NAME/
	cp -r ~/.local/share/django_app/settings.py $PROJ_NAME/
	cp -r ~/.local/share/django_app/urls.py $PROJ_NAME/
	cp -r ~/.local/share/django_app/app/management/ $APP_NAME/
	cp -r ~/.local/share/django_app/app/options/ $APP_NAME/
	cp -r ~/.local/share/django_app/app/forms.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/signals.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/tasks.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/urls.py $APP_NAME/
	echo -e "settings.py changed."
	sed -i -e 's|#{SECRET_KEY}|'$SECRET_KEY'|g' -e 's|#{PROJ_NAME}|'$PROJ_NAME'|g' -e 's|#{APP_NAME}|'$APP_NAME'|g' -e 's|#{DJANGO_UP_APP_NAME}|'$DJANGO_UP_APP_NAME'|'g $PROJ_NAME/settings.py
	echo -e "Urls py changed"
	sed -i -e 's|#{PROJ_NAME}|'$PROJ_NAME'|g' -e 's|#{APP_NAME}|'$APP_NAME'|g' $PROJ_NAME/urls.py
	sed -i -e 's|#{APP_NAME}|'$APP_NAME'|g' $APP_NAME/management/commands/ovveride_templates.py
	python manage.py migrate
	mkdir $APP_NAME/templates
	python manage.py ovveride_templates .venv
	echo -e "Successfuly done [OK]"

}

function django_2_configuration {
	echo -e "Get Django application SECRET_KEY"
	SECRET_KEY=$(python manage.py diffsettings | grep 'SECRET_KEY' | cut -d' ' -f 3)
	DJANGO_UP_APP_NAME=$(python3 -c 'a="'$APP_NAME'";d=[x.capitalize() for x in a.split("_")];print("".join(d))')
	echo -e "configuration files add"
	cp -r ~/.local/share/django_app/middleware/ $PROJ_NAME/
	cp -r ~/.local/share/django_app/settings_django2.py $PROJ_NAME/settings.py
	cp -r ~/.local/share/django_app/urls_django2.py $PROJ_NAME/urls.py
	cp -r ~/.local/share/django_app/app/management/ $APP_NAME/
	cp -r ~/.local/share/django_app/app/options/ $APP_NAME/
	cp -r ~/.local/share/django_app/app/forms.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/signals.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/tasks.py $APP_NAME/
	cp -r ~/.local/share/django_app/app/urls.py $APP_NAME/
    cp -r ~/.local/share/django_app/README.md $FILE/
    sed -i -e 's|#{PROJ_NAME}|'$PROJ_NAME'|g' -e 's|#{DOCKER_PORT}|'$DOCKER_PORT'|g' $FILE/README.md
	echo -e "Readme change."
	echo -e "settings.py changed."
	sed -i -e 's|#{SECRET_KEY}|'$SECRET_KEY'|g' -e 's|#{PROJ_NAME}|'$PROJ_NAME'|g' -e 's|#{APP_NAME}|'$APP_NAME'|g' -e 's|#{DJANGO_UP_APP_NAME}|'$DJANGO_UP_APP_NAME'|'g $PROJ_NAME/settings.py
	echo -e "Urls py changed"
	sed -i -e 's|#{PROJ_NAME}|'$PROJ_NAME'|g' -e 's|#{APP_NAME}|'$APP_NAME'|g' $PROJ_NAME/urls.py
	sed -i -e 's|#{APP_NAME}|'$APP_NAME'|g' $APP_NAME/management/commands/ovveride_templates.py
	python manage.py migrate
	echo -e "Successfuly done [OK]"

}


function ask_git { 
	read -p "Do you have a github or bitbucket repository (y,n)?" check_git
	if [ "$check_git" == y ] ; then
	    echo -e "Add new repo to project"
	    read -p "Repository Url (https/git): " REPO_URL
	    if [ "$REPO_URL" != '' ] ; then
	    	echo -e "Create Empty Git repository"
	    	git init
	    	echo -e "Add $REPO_URL repository to $FILE"
	    	git remote add origin $REPO_URL
	    	echo -e "If repository not Empty git pull to fetch master"
	    	git pull origin master
	    	echo -e "Add new files to repo"
	    	git add .
	    	echo -e "Add new files to repo"
	    	git commit -am "First commit $FILE"
	    	git push -u origin master
	    	git fetch
	    	echo -e "Check git status"
	    	git status
	    	echo -e "Check git branch"
	    	git branch
	    fi
	fi
}

function update_package {
    read -p "Do you want to update create-django-app tool(y,n)?" updates
	if [ "$updates" == y ] ; then
	    echo -e "Starting to update tool"
	    cd $GIT_DIRECTORY
	    git pull origin master
	    python3 install.py update
	else
	    exit 1
	fi
}


function finish {
	echo -e "\n"
	echo -e " Successfuly created $(ChangeColor green text)$FILE$(ChangeColor white text) "
  	echo -e "\n"
  	echo -e " Django runserver project :"
  	echo -e "\n"
  	echo -e "  cd $(ChangeColor green text)$FILE$(ChangeColor white text)"
  	echo -e "  source .venv/bin/activate"
  	echo -e "  python manage.py runserver"
  	echo -e "\n"
  	echo -e "  If you have any problems, do not hesitate to file an issue:"
  	echo -e "    $(ChangeColor blue text)$ISSUE_URL$(ChangeColor white text)"


}

function test_elemek {
	FILE=$1
	OPTIONS=$2

	if [[ -v OPTIONS ]];then
		case ${OPTIONS} in

			-a | --author)
				get_author
			;;

			-V | --version)
				get_version
			;;

			-h | --help)

				helping

			;;
			*)
				usage 
			;;

			
		esac
	else
		echo "Noo"
	fi
	
}

function unit_test {
	echo -e "Test starting...$(ChangeColor red text)"
	munis
	if [ $? -eq 0 ]; then
	    echo "$(ChangeColor white text)OK"
	else
	    echo "FAIL $(ChangeColor white text)"
	fi
}

function just_test {
	echo "Test $1 $2"
}

################
#### START  ####
################

COMMAND=${@:$OPTIND:1}
ARG=${@:$OPTIND+1:1}

#CHECKING PARAMS VALUES
case ${COMMAND} in

	-a | --author)
		get_author
	;;

	-V | --version)
		get_version
	;;

	git | --git)
		ask_git
		finish
	;;

	-u | --update | -U )
	    update_package
	;;


    -h | --help)

		helping

	;;
	-t | --test)

		unit_test

	;;
	-j * )
		just_test
	;;



    *)

        # if path not provided show usage message
	    if [ "$#" -ne 1 -a "$#" -ne 2 ]; then
            usage
        fi
        file_dir=${COMMAND}
    	arg=${ARG}
    	base_script ${file_dir} ${arg}	

	;;

	
esac

exit $ERROR_STATUS
