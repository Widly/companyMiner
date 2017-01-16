# -*- coding: UTF-8 -*-
from grab import Grab
from time import time as unixTime
import json
import subprocess
from FiasAddress import FiasAddress
from exceptions import KeyError
from pdfToTxt import convert_pdf_to_txt
from os import remove

class EgrulParser:
	__grabObject1 = None
	__grabObject2 = None
	__grabObject3 = None
	__grabObject4 = None
	__egrulCaptchaURL = None
	__egrulPdfURL = None
	__token = None
	__captchaAns = None
	__data = None

	__ogrninn = None
	__nameul = None
	__regionul = None
	__nameEq = None
	__srchUl = None

	def __init__(self):
		self.__egrulCaptchaURL = 'https://egrul.nalog.ru/static/captcha.html'
		self.__egrulPdfURL = 'https://egrul.nalog.ru/download/'

		self.__grabObject1 = Grab(log_file = 'token.txt', connect_timeout = 30, timeout = 30)
		self.__grabObject2 = Grab(log_file = 'captcha.jpg', connect_timeout = 30, timeout = 30)
		self.__grabObject3 = Grab(url = 'https://egrul.nalog.ru', log_file = 'EgrulResponse.json', connect_timeout = 30, timeout = 30)
		self.__grabObject4 = Grab(connect_timeout = 30, timeout = 30) 

		self.shortNames = {
			u'УЛИЦА' : u'ул',
			u'ПРОСПЕКТ' : u'пр-кт',
			u'ПРОЕЗД' : u'пр-д',
			u'ПЕРЕУЛОК' : u'пер',
			u'НАБЕРЕЖНАЯ' : u'наб',
			u'ПЛОЩАДЬ' : u'пл',
			u'БУЛЬВАР' : u'б-р',
			u'ШОССЕ' : u'ш',
			u'КИЛОМЕТР' : u'км'
		}

	def __RequestJson(self):

		postParameters = dict(
			captcha	= 	self.__captchaAns,
			captchaToken = self.__token,
			fam	= '',
			kind= 'ul',
			ul = '',
			nam = '',
			nameEq = self.__nameEq,
			namul = self.__nameul,	
			ogrninnfl = '',	
			ogrninnul= self.__ogrninn,
			otch = '',
			region = '',
			regionul = self.__regionul,
			srchFl = 'inn',
			srchUl = self.__srchUl,
			)
		
		self.__grabObject3.setup(post = postParameters)	
		self.__grabObject3.request()

		try:
			with open('EgrulResponse.json', 'r') as resp:
				self.__data = json.loads(resp.readline()).pop('rows')
		except(KeyError):
			return False

		return True


	def __LoadToken(self):
		self.__grabObject1.setup(url = self.__egrulCaptchaURL + '?r=' + str(int(unixTime())))
		self.__grabObject1.request()

		with open('token.txt', 'r') as f:
			self.__token = f.readline()

	def __LoadCaptcha(self):		
		self.__grabObject2.setup(url = self.__egrulCaptchaURL + '?a=' + self.__token)
		self.__grabObject2.request()

	def __LoadData(self):
		while(1):
			imageProcess = subprocess.Popen(["display", "captcha.jpg"])

			self.__captchaAns = int(raw_input("Введите каптчу: "))
			if (self.__RequestJson() == True):
				imageProcess.kill()
				break

			else:
				print("Неправильно введена каптча")
				imageProcess.kill()
				self.__LoadToken()
				self.__LoadCaptcha()

	def ParseAddress(self, address):
		fiasAddr = FiasAddress()
		#addr = address.encode('utf-8')
		addr = address
		addr = addr.split(',')

		# почтовый индекс
		if (addr[0] != ''):
			fiasAddr.postalcode = addr[0]

		# улица

		dividerPos = addr[5].find(' ')
		fiasAddr.shortname = self.shortNames[addr[5][0 : dividerPos]]
		fiasAddr.formalname = addr[5][dividerPos : ].strip()

		# дом/владение...
		dividerPos = addr[6].find(' ')
		if (dividerPos == -1):
			fiasAddr.housenum = addr[6]
		else:
			fiasAddr.housenum = addr[6][dividerPos + 1 :]

		# корпус, строение
		semicolonPos = addr[7].find(';')
		structDivider = None
		dividerPos = None

		if (semicolonPos == -1):
			structDivider = addr[7].find(u'СТР.')

			if (structDivider == -1):
				dividerPos = addr[7].find(' ')

				if (addr[7][0 : dividerPos] == u'КОРПУС'):
					fiasAddr.buildnum = addr[7][dividerPos + 1 : ]
				elif(addr[7][0 : dividerPos] == u'СТРОЕНИЕ'):
					fiasAddr.structnum = addr[7][dividerPos + 1 : ]
				else:
					fiasAddr.buildnum = addr[7].lstrip()

			else:
				fiasAddr.structnum = addr[7][structDivider + len(u'СТР.') : ].lstrip()

		else:
			fiasAddr.buildnum = addr[7][0 : semicolonPos]

			structDivider = addr[7].find(u'СТР.')

			if (structDivider == -1):
				fiasAddr.structnum = addr[7][semicolonPos + 1 : ].lstrip()
			else:
				fiasAddr.structnum = addr[7][structDivider + 8 : ].lstrip()

		# офис
		fiasAddr.officenum = addr[8]

		return fiasAddr

	def Load(self, ogrninn = '', nameul = '', regionul = '', nameEq = '', srchUl = ''):
		self.__ogrninn = ogrninn
		self.__regionul = regionul
		self.__nameul = nameul
		self.__nameEq = nameEq
		self.__srchUl = srchUl

		self.__LoadToken()
		self.__LoadCaptcha()
		self.__LoadData()

	def ListSearch(self,  name, foundationDate, addr, dirFIO, region = ''):
		# поиск по дате и ФИО дира, не учитывая улицу
		self.__regionul = region
		self.__nameul = name
		self.__nameEq = 'on'
		self.__srchUl = 'name'
		self.__ogrninn = ''

		self.__LoadToken()
		self.__LoadCaptcha()
		self.__LoadData()

		directorFIO = dirFIO.split(' ')

		for row in self.__data:
			ogrn = str(row["OGRN"])
			pdfFoundDate = None

			self.__grabObject4.setup(url = self.__egrulPdfURL + row['T'], log_file = ogrn + '.pdf')
			self.__grabObject4.request()

			pdfText = convert_pdf_to_txt(ogrn + '.pdf', maxPages = 1)

			splittedPdf = pdfText.split('\n')
			for i in range (60, len(splittedPdf)):
				if (splittedPdf[i].find('Дата регистрации') != -1):
					pdfFoundDate = splittedPdf[i + 5]

					if (pdfFoundDate == foundationDate):
						# Если дата регистрации совпадает
						pdfText = convert_pdf_to_txt(ogrn + '.pdf', maxPages = 3, firstPageNum = 1)
						splittedPdf = pdfText.split('\n')

						# Ищем генерального директора
						i = None 
						for i in range(0, len(splittedPdf)):
							if(splittedPdf[i].find('ГЕНЕРАЛЬНЫЙ ДИРЕКТОР') != -1):
								break

						for j in reversed(range(0, i)):
							if (splittedPdf[j] == directorFIO[0]):

								#нашли фамилию, проверяем остальное
								if (splittedPdf[j + 1] == directorFIO[1] and splittedPdf[j + 2] == directorFIO[2]):
									# все совпало
									ret = [row['ADRESTEXT'], row["OGRN"], row["INN"], row["KPP"]]
									try:
										ret.append(row["DTEND"])
									except(KeyError):
										pass

									return ret
								else:
									break
					remove(ogrn + '.pdf')
					break