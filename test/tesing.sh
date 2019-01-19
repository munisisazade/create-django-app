#!/bin/bash
# Author Munis Isazade
COMMAND_NAME=create-django-app
if [[ "$OSTYPE" == "darwin"* ]]; then
    LOCAL_COMMAND_DIRECTORY=/usr/local/bin/
    TLP_DIRECTORY=/usr/local/share/
else
    LOCAL_COMMAND_DIRECTORY=~/.local/bin/
    TLP_DIRECTORY=~/.local/share/
fi

echo "My local command directory is $LOCAL_COMMAND_DIRECTORY"
echo "My local share directory is $TLP_DIRECTORY"

if [ -d $LOCAL_COMMAND_DIRECTORY ]; then
	echo "Yes I have"
fi
