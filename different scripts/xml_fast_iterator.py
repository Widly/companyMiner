# -*- coding: UTF-8 -*-
from lxml import etree
import psycopg2

def fast_iter(context, func, *args, **kwargs):
    Count = 0
    for event, elem in context:
        func(elem, *args, **kwargs)
        Count = Count + 1
        # It's safe to call clear() here because no descendants will be
        # accessed
        elem.clear()
        # Also eliminate now-empty references from the root node to elem
        for ancestor in elem.xpath('ancestor-or-self::*'):
            while ancestor.getprevious() is not None:
                del ancestor.getparent()[0]
    print Count
    del context


def process_element(elem):
    pass


context = etree.iterparse('/home/igor/Документы/fias_xml/NORMDOC.XML', tag = 'NormativeDocument')
fast_iter(context,process_element)