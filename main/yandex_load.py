# -*- coding: UTF-8 -*-

from grab import Grab
import json
from lxml import html
from FiasAddress import FiasAddress

class YandexSpravParser:
	__grabObject1 = None
	__orgName = None
	__loc_name = None
	__geoIDs = None

	def __init__(self):
		self.__grabObject1 = Grab(url = 'https://sprav.yandex.ru/cmd',
			log_file = 'yaResponse.json', connect_timeout = 30, timeout = 30)

		with open('ya_geoId.json', 'r') as f:
			self.__geoIDs = json.loads(f.read())


	def __ChooseGeoID(self):
		for row in self.__geoIDs:
			if (row['RegionName'].lower() == self.__loc_name.lower()):
				return row['RegionID']

	def __RequestData(self):
		postParameters = dict(
			page = 1,
			cmd = 'ajax_search',
			search = 1,
			from_orders = '',
			page_size = 50,
			dont_group_chains = '',
			owned_by_me = '',
			view_companies = '',
			order_id = '',
			uid = '',
			show_verification = 0,
			webmaster = '',
			country = 'Россия',
			country_id = '225',
			locality_name = self.__loc_name,
			name = self.__orgName,
			geo_id = self.__ChooseGeoID(),
			country_code = '7',
			#city_code = '495',
			phone_number = '',
			url = '',
			_ = '',
			)

		self.__grabObject1.setup(post = postParameters)
		self.__grabObject1.request()

	def __ParseResponse(self):
		data = None
		name = []
		address = []
		site = []

		with open('yaResponse.json', 'r') as resp:
			data = json.loads(resp.read())

		for row in data['result']:
			ht = html.fromstring(row)

			name.append(ht.xpath('//div/h3/a')[0].text)
			address.append(ht.xpath('//div/div/div')[0].text)

			try:
				site.append(ht.xpath('//div/div/div/a')[0].text)
			except(IndexError):
				site.append(None)
		

		return zip(name, address, site)

	def ParseAddress(self, address):
		streetTypes = [u'ул.', u'просп.', u'пр-д', u'пер.', u'наб.', u'пл.', u'бул.', u'ш.', u'км.', u'г.']
		fiasStreetTypes = {
			u'ул.' : u'ул',
			u'просп.' : u'пр-кт',
			u'пр-д' : u'пр-д',
			u'пер.' : u'пер',
			u'наб.' : u'наб',
			u'пл.' : u'пл',
			u'бул.' : u'б-р',
			u'ш.' : u'ш',
			u'км.' : u'км',
			u'г.' : u'г'
		}

		fiasAddr = FiasAddress()
		addr = address.split(',')

		for i in range(1, len(addr)):
			if (addr[i].find(u'корп.') != -1):
				fiasAddr.buildnum = (addr[i].replace(u'корп.', '')).strip()
				continue

			if (addr[i].find(u'стр.') != -1):
				fiasAddr.structnum = (addr[i].replace(u'стр.', '')).strip()
				continue

			if (addr[i].find(u'оф.') != -1):
				fiasAddr.officenum = (addr[i].replace(u'оф.', '')).strip()
				continue

			if (addr[i].find(u'МКАД') != -1):

				fiasAddr.formalname = u'МКАД' + ' ' + addr[i + 1].strip()

				if (addr[i + 2].find(u'Торговый') != -1):
					break

				i = i + 1
				continue

			for objType in streetTypes:
				if (addr[i].find(objType) != -1):
					fiasAddr.formalname = (addr[i].replace(objType, '')).strip()
					fiasAddr.shortname = fiasStreetTypes[objType]
					
					if (addr[i + 1].find(u'вл.') == -1 and addr[i + 1].find(u'стр.') == -1 and addr[i + 1].find(u'корп.') == -1):
						fiasAddr.housenum = addr[i + 1].strip()
						i = i + 1
					break

		return fiasAddr

	def Load(self, orgName, loc_name):
		self.__orgName = orgName.decode('utf-8')
		self.__loc_name = loc_name.decode('utf-8')

		self.__RequestData()
		return self.__ParseResponse()

	def YaSearch(self, orgName, loc_name, EgrulAddr, containingType = 'inEgrul'):
		resp = self.Load(orgName = orgName, loc_name = loc_name)

		for name, address, site in resp:
			parsedAddress = self.ParseAddress(address)
			parsedAddress = parsedAddress.SetUpper()
			parsedAddress.officenum = ''

			if (containingType == 'inEgrul'):
				if (EgrulAddr.IfContains(parsedAddress) == True):
					return (name, address, site)
			elif (containingType == 'inYa'):
				if (parsedAddress.IfContains(EgrulAddr) == True):
					return (name, address, site)
			

		return None