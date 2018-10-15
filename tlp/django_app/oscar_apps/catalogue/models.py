from oscar.apps.catalogue.abstract_models import AbstractProduct
from oscar.apps.partner.models import StockRecord
from django.db import models
import json


class Product(AbstractProduct):
    best_seller = models.BooleanField(default=False)

    def get_variants(self):
        return Product.objects.filter(parent=self)

    def get_common_colors(self, type):
        _colors = []
        for product in self.get_variants():
            attrs = product.attribute_values.all()
            for item in attrs:
                # _colors.append(item.attribute.name)
                if item.attribute.code == type and not _colors.__contains__(item.value.option):
                    _colors.append(item.value.option)
        return _colors

    def get_base_type(self):
        return self.get_common_colors('type')

    def get_child_images(self):
        result = []
        for product in self.get_variants():
            for attr in product.attribute_values.all():
                if attr.attribute.code == 'type' or attr.attribute.code == 'color':
                    pass
                else:
                    obj = {}
                    obj['product_id'] = product.id
                    obj['image_url'] = attr.value_image.url
                    result.append(obj)
        return result

    def get_product_variants(self):
        result = []
        for product in self.get_variants():
            resultObj = {}
            for attr in product.attribute_values.all():
                if attr.attribute.code == 'type':
                    resultObj['type'] = attr.value.option
                elif attr.attribute.code == 'color':
                    resultObj['color'] = attr.value.option
                else:
                    if hasattr(attr, 'value_image'):
                        resultObj['picture_url'] = attr.value_image.url
            resultObj['product_id'] = product.id
            resultObj['title'] = product.get_title()
            try:
                record = StockRecord.objects.get(product=product)
                resultObj['price'] = float(record.price_excl_tax)
            except:
                resultObj['price'] = 0
            result.append(resultObj)
        return json.dumps(result)

    def get_first_color(self):
        _colors = []
        first_obj = self.get_base_type()[0]
        for product in self.get_variants():
            check = product.attribute_values.filter(value_option__option=first_obj)
            attrs = product.attribute_values.all()
            if check:
                for item in attrs:
                    if item.attribute.code == 'color' and not _colors.__contains__(item.value.option):
                        _colors.append(item.value.option)


from oscar.apps.catalogue.models import *
