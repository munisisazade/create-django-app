from time import time


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

    return title_url


def get_doctor_image(instance, filename):
    return "doctor/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_home_icons(instance, filename):
    return "icons/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


# cover images>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
def get_news_cover(instance, filename):
    return "news/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_flatpage_cover(instance, filename):
    return "flatpage/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_faq_cover(instance, filename):
    return "news/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_doctor_image(instance, filename):
    return "doctor/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_departments_cover(instance, filename):
    return "news/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_contact_cover(instance, filename):
    return "contact/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))


def get_cover_path(instance, filename):
    return "contact/%s_%s" % (str(time()).replace('.', '_'), filename.replace(' ', '_'))
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
