from time import time
import random, string, calendar, datetime
from datetime import date
from django.utils import timezone


def get_user_profile_photo_file_name(instance, filename):
    return "profile/%s_%s" % (str(time()).replace('.', '_'), filename)


def get_question_photo(instance, filename):
    return "questions/%s_%s" % (str(time()).replace('.', '_'), filename)


def get_answer_photo(instance, filename):
    return "answers/%s_%s" % (str(time()).replace('.', '_'), filename)


# Models Helper choices here
GENDER = (
    (1, "Kişi"),
    (2, "Qadın")
)
POSITION = (
    (1, "Fənn Müəllimi"),
    (2, "Ibtidai sinif Müəllimi")
)

USERTYPES = (
    (1, "Həkim"),
    (2, "Normal user"),
    (3, "Administrator")
)

PAYMENT_STATUS = (
    (1, "Gecikir"),
    (2, "Normal"),
    (3, "Vaxtinda")
)

ATTENDANCE = (
    (1, "plus"),
    (2, "minus"),
    (3, "icazəli"),
    (4, "çıxıb"),
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

    return title_url


confirmation_link = "http://localhost:8023/az/account/confirmation/?code=%s&csrfmiddlewaretoken=yqblx5XHw9E57i1UVPktCXWGWGYaFiV92o8EifbH2lZ3rMNJdphusTdxZO6AMLC8&user=%s"
forget_link = "http://localhost:8023/az/account/forget/?code=%s&csrfmiddlewaretoken=yqblx5XHw9E57i1UVPktCXWGWGYaFiV92o8EifbH2lZ3rMNJdphusTdxZO6AMLC8"


def id_generator(size=120, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def game_session_generate(size=20, chars=string.ascii_lowercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def change_pass(size=6, chars=string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def get_random_answer():
    return random.randint(0, 2)


def current_month_range():
    year = int(timezone.now().strftime("%Y"))
    month = int(timezone.now().strftime("%m"))
    start_date = 1
    end_date = calendar.monthrange(year, month)[1]
    start = "{0}-{1}-{2}".format(year, month, start_date)
    end = "{0}-{1}-{2}".format(year, month, end_date)
    return [start, end]


def current_week_range():
    today = timezone.now()
    start_date = today - datetime.timedelta(days=today.weekday())
    end_date = start_date + datetime.timedelta(days=6)
    start = start_date.strftime("%Y-%m-%d")
    end = end_date.strftime("%Y-%m-%d")
    exception = True
    if not exception:
        return [start, end]
    else:
        return ['2017-09-29', '2017-10-8']


def get_month_index(name):
    month_names = (('Sentyabr', '9'),
                   ('Oktyabr', '10'),
                   ('Noyabr', '11'),
                   ('Dekabr', '12')
                   )
    result = ''
    for name_month, index in month_names:
        if name_month == name:
            result += index
    if result == '':
        result += '1'
    return result


def get_four_month_calendar():
    result = []
    cal = [('Sentyabr', range(1, 30 + 1), 4),
           ('Oktyabr', range(1, 31 + 1), 6),
           ('Noyabr', range(1, 30 + 1), 2),
           ('Dekabr', range(1, 31 + 1), 4)]
    week = ['Bazar ertəsi', 'Çərşənbə axşamı', 'Çərşənbə', 'Cümə axşamı', 'Cümə', 'Şənbə', 'Bazar']
    thisweek = False
    for month, days, start_pos in cal:
        week_start_point = start_pos
        month_obj = {}
        month_obj['name'] = month
        month_obj['data'] = []
        month_obj['weeks'] = []
        days_list = []
        week_start_count = 1
        for day in days:
            # Print day
            day_obj = {}
            day_obj['day'] = day
            day_obj['week'] = week[start_pos]
            month_obj['data'].append(day_obj)
            days_list.append(day_obj)
            if get_month_index(month) == timezone.localtime(timezone.now()).strftime("%m") and day == int(
                    timezone.localtime(timezone.now()).strftime("%d")):
                thisweek = True
            start_pos += 1
            if start_pos == 7:
                str_obj = {}
                str_week = str(day - 6 if day > 7 else 1) + "-" + str(day)
                str_obj['title'] = str_week
                str_obj['days'] = days_list
                str_obj['thisweek'] = thisweek
                thisweek = False
                month_obj['weeks'].append(str_obj)
                days_list = []
                week_start_point = 0
                start_pos = 0  # Reset counter
        element_obj = {}
        element = month_obj['data'][-1]
        last_week = str(days_list[0]['day']) + '-' + str(days_list[-1]['day']) if days_list else None
        element_obj['title'] = last_week
        element_obj['days'] = days_list
        element_obj['thisweek'] = thisweek
        thisweek = False
        month_obj['weeks'].append(element_obj)
        result.append(month_obj)
    return result


WEEK_LEADERBORD = (
    ("1 ci həftə", 25),
    ("2 ci həftə", 9),
    ("3 ci həftə", 16),
    ("4 ci həftə", 23),
    ("5 ci həftə", 30),
    ("6 ci həftə", 6),
    ("7 ci həftə", 13),
    ("8 ci həftə", 20),
    ("9 ci həftə", 27),
    ("10 ci həftə", 4),
    ("11 ci həftə", 11),
    ("12 ci həftə", 18),
)


def check_week(date):
    day = date.day
    result = ''
    for name, item in WEEK_LEADERBORD:
        if item == day:
            result += name
    return result


def day_range_utc():
    current_time = timezone.now()
    if current_time.day != 1:
        if current_time.hour >= 20:
            day_start = timezone.datetime(current_time.year,
                                          current_time.month,
                                          current_time.day,
                                          20,
                                          0).replace(tzinfo=current_time.tzinfo)
            day_end = timezone.datetime(current_time.year,
                                        current_time.month,
                                        current_time.day + 1,
                                        20,
                                        0).replace(tzinfo=current_time.tzinfo)
        else:
            day_start = timezone.datetime(current_time.year,
                                          current_time.month,
                                          current_time.day - 1,
                                          20,
                                          0).replace(tzinfo=current_time.tzinfo)
            day_end = timezone.datetime(current_time.year,
                                        current_time.month,
                                        current_time.day,
                                        20,
                                        0).replace(tzinfo=current_time.tzinfo)
    else:
        start_pos = current_time - datetime.timedelta(days=1)
        if current_time.hour >= 20:
            day_start = timezone.datetime(current_time.year,
                                          current_time.month,
                                          current_time.day,
                                          20,
                                          0).replace(tzinfo=current_time.tzinfo)
            day_end = timezone.datetime(current_time.year,
                                        current_time.month,
                                        current_time.day + 1,
                                        20,
                                        0).replace(tzinfo=current_time.tzinfo)
        else:
            day_start = timezone.datetime(start_pos.year,
                                          start_pos.month,
                                          start_pos.day,
                                          20,
                                          0).replace(tzinfo=current_time.tzinfo)
            day_end = timezone.datetime(current_time.year,
                                        current_time.month,
                                        current_time.day,
                                        20,
                                        0).replace(tzinfo=current_time.tzinfo)
    return [day_start, day_end]


def get_week_date():

    return