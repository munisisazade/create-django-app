from django import template

register = template.Library()


@register.filter
def not_null(arg):
    if arg:
        return arg
    else:
        return ""

@register.filter
def val_int(arg):
    return int(arg)

@register.filter
def val_str(arg):
    return str(arg)



@register.filter
def duration_format(value):
    days, seconds = value.days, value.seconds
    hours = days * 24 + seconds // 3600
    minutes = (seconds % 3600) // 60
    seconds = (seconds % 60)
    return '%s:%s' % (minutes, seconds)