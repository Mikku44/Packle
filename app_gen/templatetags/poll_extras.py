from django import template
from django.template.defaultfilters import stringfilter
from app_gen.models import *
register = template.Library()


@register.filter
@stringfilter
def detailCol(value):
    dCol = DetailCollection.objects.filter(col_id=value).first()
    # dCol.gen_id
    if dCol:
        return dCol.gen_id.gen_source
    return "https://static.vecteezy.com/system/resources/previews/014/275/767/non_2x/abstract-circle-pattern-monochrome-grey-color-geometric-circle-random-shape-seamless-pattern-background-use-for-fabric-interior-decoration-elements-upholstery-wrapping-vector.jpg"