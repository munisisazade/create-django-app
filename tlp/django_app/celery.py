from __future__ import absolute_import, unicode_literals
from celery import Celery
# from celery.schedules import crontab
import os, logging
from django.conf import settings

logger = logging.getLogger("Celery")

os.environ.setdefault('DJANGO_SETTINGS_MODULE', '#{PROJ_NAME}.settings')

app = Celery('#{PROJ_NAME}')

app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))


if settings.PROD:
    app.conf.update(
        BROKER_URL='redis://redis:6379/0',
        CELERYBEAT_SCHEDULER='django_celery_beat.schedulers:DatabaseScheduler',
        CELERY_RESULT_BACKEND='redis://redis:6379/1',
        CELERY_DISABLE_RATE_LIMITS=True,
        CELERY_ACCEPT_CONTENT=['json', ],
        CELERY_TASK_SERIALIZER='json',
        CELERY_RESULT_SERIALIZER='json',
    )
else:
    app.conf.update(
        BROKER_URL='redis://localhost:6379/0',
        CELERYBEAT_SCHEDULER='django_celery_beat.schedulers:DatabaseScheduler',
        CELERY_RESULT_BACKEND='redis://localhost:6379/1',
        CELERY_DISABLE_RATE_LIMITS=True,
        CELERY_ACCEPT_CONTENT=['json', ],
        CELERY_TASK_SERIALIZER='json',
        CELERY_RESULT_SERIALIZER='json',
    )
#
# app.conf.beat_schedule = {
#     'every_week_update_leaderboard': {
#         'task': 'game.tasks.update_leaderboard',
#         'schedule': crontab(hour=0, minute=1),
#     },
# }
