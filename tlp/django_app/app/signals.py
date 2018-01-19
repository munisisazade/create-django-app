from django.db.models.signals import post_save, pre_delete


# example of signal
# @receiver(post_save,sender=<ModelName>,dispatch_uid='<function name>')
# def <function name>(sender,**kwargs):
#     print(kwargs.get('instance')) # get Model object

