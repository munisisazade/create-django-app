from django.core.management.base import BaseCommand
from django import get_version as DJANGO_VERSION
from oscar import get_version as OSCAR_VERSION
import subprocess
import sys
import os

PYTHON_VERSION=sys.version[:3]
COMMAND_VERSION="0.1"

class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('venv_path', type=str)

    def handle(self, *args, **options):
        # Get Oscar Templates directory
        self.usage()
        print("Write Virtualenv path")
        venv_path = options.get('venv_path', '.venv')
        if os.path.exists(venv_path):
            subprocess.call("rm -rf $(pwd)/#{APP_NAME}/templates/* && cp -r {}/lib/python{}/site-packages/oscar/templates/oscar/* $(pwd)/#{APP_NAME}/templates && cd #{APP_NAME}/templates && tree".format(venv_path, PYTHON_VERSION),shell=True)
            print("Successfuly Ovveride templates")
        else:
            raise FileExistsError("%s file not found root dir" % venv_path)

    def usage(self):
        print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        print("\t Oscar Template tools v{}".format(COMMAND_VERSION))
        print("\t Django version v{}".format(DJANGO_VERSION()))
        print("\t Oscar version v{}".format(OSCAR_VERSION()))
        print("\t Author Munis Isazade - munisisazade@gmail.com")
        print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
        print("Usage: ./manage.py ovveride_templates <venv path>")

