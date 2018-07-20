# Author Munis Isazade  create log file for Threading
from django.utils import timezone
import os
import sys
import traceback

VERSION = "0.5.1"


class Logger(object):
    """
        Logger objects create a log file
        if not exist and append string to
        log file
    """

    def __init__(self, file='messages.log'):
        self.file = file
        self.time = timezone.now().strftime('%Y/%m/%d %H:%M:%S')
        self.created_time = timezone.now().strftime('%d-%b-%Y %H:%M:%S')

    def debug(self, text=""):
        """
            debug check append
            method function
            :param text:
            :return: bool
        """
        self._file_append(text)

    def _file_append(self, text=""):
        """

            :param text:
            :return:
        """
        try:
            if self._check_file_exist(self.file):
                with open(self.file, "a") as msglog:
                    msglog.writelines(
                        "{} Error:[{}] SysInfo:[{}] Time:[{}]\n".format(text, traceback.format_exc(), sys.exc_info()[0],
                                                                        self.time))
            else:
                with open(self.file, "a") as msglog:
                    msglog.writelines("#Version: {}\n"
                                      "#CreatedDate: {}\n"
                                      "#Author: Munis Isazade\n"
                                      "#Fields: text error sysinfo time\n"
                                      "{} Error:[{}] SysInfo:[{}] Time:[{}]\n".format(self.version(), self.created_time,
                                                                                      text, traceback.format_exc(),
                                                                                      sys.exc_info()[0], self.time))
            return True
        except:
            raise FileNotFoundError('not found')

    def version(self):
        """
            get Logger Module version
        """
        return VERSION

    def _check_file_exist(self, filename):
        """
            check log file is exist or not
            :param filename:
            :return: bool
        """
        return os.path.isfile(filename)
