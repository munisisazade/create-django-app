# -*- coding: utf-8 -*-
# Generated by Django 1.11.9 on 2018-02-14 11:33
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('catalogue', '0012_auto_20170609_1902'),
    ]

    operations = [
        migrations.AddField(
            model_name='category',
            name='description_az',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='category',
            name='description_en',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='category',
            name='description_ru',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='category',
            name='name_az',
            field=models.CharField(db_index=True, max_length=255, null=True, verbose_name='Name'),
        ),
        migrations.AddField(
            model_name='category',
            name='name_en',
            field=models.CharField(db_index=True, max_length=255, null=True, verbose_name='Name'),
        ),
        migrations.AddField(
            model_name='category',
            name='name_ru',
            field=models.CharField(db_index=True, max_length=255, null=True, verbose_name='Name'),
        ),
        migrations.AddField(
            model_name='product',
            name='description_az',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='product',
            name='description_en',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='product',
            name='description_ru',
            field=models.TextField(blank=True, null=True, verbose_name='Description'),
        ),
        migrations.AddField(
            model_name='product',
            name='title_az',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='Title'),
        ),
        migrations.AddField(
            model_name='product',
            name='title_en',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='Title'),
        ),
        migrations.AddField(
            model_name='product',
            name='title_ru',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='Title'),
        ),
        migrations.AddField(
            model_name='productattribute',
            name='name_az',
            field=models.CharField(max_length=128, null=True, verbose_name='Name'),
        ),
        migrations.AddField(
            model_name='productattribute',
            name='name_en',
            field=models.CharField(max_length=128, null=True, verbose_name='Name'),
        ),
        migrations.AddField(
            model_name='productattribute',
            name='name_ru',
            field=models.CharField(max_length=128, null=True, verbose_name='Name'),
        ),
    ]
