# -*- coding: UTF-8 -*-

from grab import Grab
import json
from urllib import urlencode
from FiasAddress import FiasAddress

class GoogleAPIParser:
	__grabObject1 = None
	__grabObject2 = None
	__orgName = None
	__locName = None
	__googlePlacesURL = None
	__googleGeoURL = None
	__googleAPIkey = None
	__placeGeopositoin = None
	__fiasStreetTypes = None
	__googleStreetTypes = None

	def __init__(self, googleAPIkey):
		self.__googlePlacesURL = 'https://maps.googleapis.com/maps/api/place/textsearch/json?'
		self.__googleGeoURL = 'https://maps.googleapis.com/maps/api/geocode/json?'

		self.__grabObject1 = Grab(log_file = 'GooglePlacesResponse.json', connect_timeout = 30, timeout = 30)
		self.__grabObject2 = Grab(log_file = 'GoogleGeocodeResponse.json', connect_timeout = 30, timeout = 30)

		self.__googleAPIkey = googleAPIkey

		self.__fiasStreetTypes = {
			u'ул.' : u'ул',
			u'просп.' : u'пр-кт',
			u'пр-д' : u'пр-д',
			u'пер.' : u'пер',
			u'наб.' : u'наб',
			u'пл.' : u'пл',
			u'бул.' : u'б-р',
			u'ш.' : u'ш',
			u'км.' : u'км',
			u'г.' : u'г',
			u'пр.' : u'пр-кт'
		}

		self.__googleStreetTypes = {
			 u'ул' : u'ул.',
			 u'пр-кт' : u'просп.',
			 u'пр-д' : u'пр-д',
			 u'пер' : u'пер.',
			 u'наб' : u'наб.',
			 u'пл' : u'пл.',
			 u'б-р' : u'бул.',
			 u'ш' : u'ш.',
			 u'км' : u'км.',
			 u'г' : u'г.'
		}

	def __RequestGeoposition(self):
		postParameters = dict(
			address = (self.__locName).encode('utf-8'),
			key = self.__googleAPIkey,
			language = 'ru'
			)

		self.__grabObject2.setup(url = self.__googleGeoURL + urlencode(postParameters))
		self.__grabObject2.request()

		with open('GoogleGeocodeResponse.json', 'r') as resp:
			data = json.loads(resp.read())
			coords = data['results'][0]['geometry']['location']
			self.__placeGeopositoin = (coords['lat'], coords['lng'])

	def __RequestData(self):
		self.__RequestGeoposition()

		postParameters = dict(
			query = self.__orgName,
			key = self.__googleAPIkey,
			location = str(self.__placeGeopositoin[0]) + ',' + str(self.__placeGeopositoin[1]),
			radius = 20000,
			language = 'ru'
			)

		self.__grabObject1.setup(url = self.__googlePlacesURL + urlencode(postParameters))
		self.__grabObject1.request()

	def __ParseResponse(self):
		data = None
		name = []
		address = []

		with open('GooglePlacesResponse.json', 'r') as resp:
			data = json.loads(resp.read())

		for row in data['results']:
			name.append(row['name'])
			address.append(row['formatted_address'])

		return zip(name, address)

	def ParseAddress(self, address):
		streetTypes = [u'ул.', u'просп.', u'пр.', u'пр-д', u'пер.', u'наб.', u'пл.', u'бул.', u'ш.', u'км.']

		fiasAddr = FiasAddress()
		addr = address.split(',')

		for i in range(0, len(addr)):
			if (addr[i].find(u'корп.') != -1):
				fiasAddr.buildnum = (addr[i].replace(u'корп.', '')).strip()
				continue

			if (addr[i].find(u'стр.') != -1):
				fiasAddr.structnum = (addr[i].replace(u'стр.', '')).strip()
				continue

			if (addr[i].find(u'строение') != -1):
				fiasAddr.structnum = (addr[i].replace(u'строение', '')).strip()
				continue

			if (addr[i].find(u'оф.') != -1):
				fiasAddr.officenum = (addr[i].replace(u'оф.', '')).strip()
				continue


			for objType in streetTypes:
				if (addr[i].find(objType) != -1):
					fiasAddr.formalname = (addr[i].replace(objType, '')).strip()
					fiasAddr.shortname = self.__fiasStreetTypes[objType]
					
					if (addr[i + 1].find(u'вл.') == -1 and addr[i + 1].find(u'стр.') == -1 and addr[i + 1].find(u'корп.') == -1):
						fiasAddr.housenum = addr[i + 1].strip()
						i = i + 1
					break

		return fiasAddr

	def Load(self, orgName, locName):
		self.__orgName = orgName
		self.__locName = locName

		self.__RequestData()
		return self.__ParseResponse()

	def GoSearch(self, orgName, locName, EgrulAddr, containingType = 'inEgrul'):
		locWithStreet = locName + ' ' + EgrulAddr.formalname + ' ' + self.__googleStreetTypes[EgrulAddr.shortname]
		resp = self.Load(orgName = orgName, locName = locWithStreet)

		for name, address in resp:
			parsedAddress = self.ParseAddress(address)
			parsedAddress = parsedAddress.SetUpper()
			parsedAddress.officenum = ''

			if (containingType == 'inEgrul'):
				if (EgrulAddr.IfContains(parsedAddress) == True):
					return(name, address)
			elif (containingType == 'inGo'):
				if (parsedAddress.IfContains(EgrulAddr) == True):
					return (name, address)

		return None