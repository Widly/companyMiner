# -*- coding: UTF-8 -*-
from lxml import etree
from pandas import DataFrame
from sqlalchemy import create_engine
import psycopg2

def fast_iter(context, func, dframe, eng):
	count = 0
	for event, elem in context:
		df.loc[count] = [elem.get('NORMDOCID'), elem.get('DOCNAME'), elem.get('DOCDATE'),
				 	elem.get('DOCNUM'), elem.get('DOCTYPE'), elem.get('DOCIMGID')]

		count = count + 1
		print count
		if (count == 100000):
			dframe.to_sql('NormativeDocument', eng)
			del dframe
			dframe = DataFrame(columns = ['NORMDOCID', 'DOCNAME', 'DOCDATE', 'DOCNUM', 'DOCTYPE', 'DOCIMGID'])
			count = 0


		#func(elem, *args, **kwargs)
		# It's safe to call clear() here because no descendants will be
		# accessed
		elem.clear()
		# Also eliminate now-empty references from the root node to elem
		for ancestor in elem.xpath('ancestor-or-self::*'):
			while ancestor.getprevious() is not None:
				del ancestor.getparent()[0]
	del context

def process_element(elem):
	pass
	#connection.commit()

df = DataFrame(columns = ['NORMDOCID', 'DOCNAME', 'DOCDATE', 'DOCNUM', 'DOCTYPE', 'DOCIMGID'])

engine = create_engine('postgresql+psycopg2://fiasuser:pass@localhost/fias')

connection = psycopg2.connect(dbname = 'fias', user = 'fiasuser', host = 'localhost', password = 'pass')
cursor = connection.cursor()

context = etree.iterparse('/home/igor/Документы/fias_xml/NORMDOC.XML', encoding = 'utf-8', tag = 'NormativeDocument')
fast_iter(context,process_element, dframe = df, eng = engine)

connection.close()