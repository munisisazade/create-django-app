from time import time
import random, string, calendar, datetime
from datetime import date
from django.utils import timezone
from unidecode import unidecode

def get_user_profile_photo_file_name(instance, filename):
    return "profile/%s_%s" % (str(time()).replace('.', '_'), filename)


# Models Helper choices here
GENDER = (
    (1, "Man"),
    (2, "Woman")
)


# Custom slugify function
def slugify(title):
    symbol_mapping = (
        (' ', '-'),
        ('.', '-'),
        (',', '-'),
        ('!', '-'),
        ('?', '-'),
        ("'", '-'),
        ('"', '-'),
        ('ə', 'e'),
        ('ı', 'i'),
        ('ö', 'o'),
        ('ğ', 'g'),
        ('ü', 'u'),
        ('ş', 's'),
        ('ç', 'c'),
    )
    title_url = title.strip().lower()

    for before, after in symbol_mapping:
        title_url = title_url.replace(before, after)

    return unidecode(title_url)
