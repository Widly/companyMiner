# -*- coding: UTF-8 -*-

class FiasAddress:
	postalcode = None
	regioncode = None

	formalname = None
	shortname = None

	housenum = None
	buildnum = None
	structnum = None

	officenum = None

	def __init__(self):
		self.postalcode = ''
		self.regioncode = ''
		self.formalname = ''
		self.shortname = ''
		self.housenum = ''
		self.buildnum = ''
		self.structnum = ''
		self.officenum = ''

	def __eq__(self, other):
		if(self.postalcode == other.postalcode and
			self.regioncode == other.regioncode and
			self.formalname == other.formalname and
			self.shortname == other.shortname and
			self.housenum == other.housenum and
			self.buildnum == other.buildnum and
			self.structnum == other.structnum and
			self.officenum == other.officenum
			):
			return True
		else:
			return False

	def SetUpper(self):
		self.formalname = self.formalname.upper()
		self.housenum = self.housenum.upper() 
		self.buildnum = self.buildnum.upper()
		self.structnum = self.structnum.upper()
		self.officenum = self.officenum.upper()

		return self


	def IfContains(self, other):
		if (other.postalcode != '' and other.postalcode != self.postalcode):
			return False

		if (other.regioncode != '' and other.regioncode != self.regioncode):
			return False

		if (other.formalname != '' and other.formalname != self.formalname):
			return False

		if (other.shortname != '' and other.shortname != self.shortname):
			return False

		if (other.housenum != '' and other.housenum != self.housenum):
			return False

		if (other.buildnum != '' and other.buildnum != self.buildnum):
			return False

		if (other.structnum != '' and other.structnum != self.structnum):
			return False

		if (other.officenum != '' and other.officenum != self.officenum):
			return False

		return True

	def Print(self):
		print u"Индекс " + self.postalcode
		print u"Код региона " + self.regioncode
		print u"Формализованное наименование " + self.formalname
		print u"Сокращенное наименование " + self.shortname
		print u"Номер дома/владения " + self.housenum
		print u"Номер корпуса " + self.buildnum 
		print u"Номер строения " + self.structnum
		print u"Номер офиса " + self.officenum