#!/bin/bash

COMMAND_NAME=create-django-app
LOCAL_COMMAND_DIRECTORY=~/.local/bin/
TLP_DIRECTORY=~/.local/share/
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



cp  base.sh $COMMAND_NAME
chmod +x $COMMAND_NAME
if [ -d $LOCAL_COMMAND_DIRECTORY ]; then
	mv $COMMAND_NAME $LOCAL_COMMAND_DIRECTORY
	if [ -d $TLP_DIRECTORY ]; then
		cp -r tlp/django_app/ $TLP_DIRECTORY
	else
		cd ~/.local/
		mkdir share
		cp -r tlp/django_app/ $TLP_DIRECTORY
	fi
else
	cd ~
	mkdir .local
	cd .local/
	mkdir bin/
	mv $COMMAND_NAME $LOCAL_COMMAND_DIRECTORY
	mkdir share
	cp -r tlp/django_app/ $TLP_DIRECTORY
	sudo echo "# set PATH so it includes user's private bin directories" >> ~/.profile
	sudo echo "PATH=\"\$HOME/bin:\$HOME/.local/bin:\$PATH\"" >> ~/.profile
fi

 
echo -e "$(ChangeColor green text)"
echo -ne '##                    (0%)\r'
sleep 0.5
echo -ne '####                  (10%)\r'
sleep 0.5
echo -ne '######                (20%)\r'
sleep 0.5
echo -ne '########              (30%)\r'
sleep 0.5
echo -ne '##########            (40%)\r'
sleep 0.5
echo -ne '############          (50%)\r'
sleep 0.5
echo -ne '##############        (60%)\r'
sleep 0.5
echo -ne '################      (70%)\r'
sleep 0.5
echo -ne '##################    (80%)\r'
sleep 0.5
echo -ne '####################  (90%)\r'
sleep 0.5
echo -ne '######################(100%)\r'
echo -ne '\n'
echo -e "$(ChangeColor white text)" 

 
echo -e "\n"
echo -e " Successfuly installed $(ChangeColor green text)$COMMAND_NAME$(ChangeColor white text) "
echo -e "\n"
echo -e "Please specify the project directory:"
echo -e "$(ChangeColor blue text)  create-django-app $(ChangeColor green text)<project-directory>$(ChangeColor white text)"
echo -e "\n"
echo -e "For example:"
echo -e "$(ChangeColor blue text)  create-django-app $(ChangeColor green text)my-django-app$(ChangeColor white text)"
echo -e "\n"
echo -e "Run $(ChangeColor blue text)create-django-app --help$(ChangeColor white text) to see all options."


