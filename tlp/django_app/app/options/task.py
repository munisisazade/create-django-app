from .debug import Logger
from threading import Thread

mylog = Logger()


class Task(object):

    def __init__(self, function=None):
        """
            Base Async Task Object
            Base constructor
        """
        self.name = "Task"
        self.function = function

    def delay(self, *args):
        background_send = Thread(target=self.async, args=(self.function, *args))
        background_send.start()
        return print(background_send)

    def async(self, task, *args):
        try:
            if len(args) == 1:
                task(args[0])
                mylog.debug("Successful")
            else:
                task(*args)
                mylog.debug("Successful")
        except:
            mylog.debug("Error")


def shared_task(*args):
    try:
        base_task = Task(args[0])
        return base_task
    except:
        task = Task()
        return task
