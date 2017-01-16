# -*- coding: UTF-8 -*-
from pandas import read_csv
from FiasAddress import FiasAddress
from egrul_load import EgrulParser
from yandex_load import YandexSpravParser
from google_load import GoogleAPIParser
import psycopg2
import os
import sys

def AddressParser(row):
	streetTypes = [u'ул.', u'пр-кт.', u'пр-д.', u'пер.', u'наб.', u'пл.', u'б-р.', u'ш.', u'км.']

	fiasAddr = FiasAddress()
	addr = row.split(',')

	for row in addr:
		if (row.find(u'д.') != -1):
			fiasAddr.housenum = (row.replace(u'д.', '')).strip()
			continue

		if (row.find(u'корп.') != -1):
			fiasAddr.buildnum = (row.replace(u'корп.', '')).strip()
			continue

		if (row.find(u'стр.') != -1):
			fiasAddr.structnum = (row.replace(u'стр.', '')).strip()
			continue

		for objType in streetTypes:
			if (row.find(objType) != -1):
				fiasAddr.formalname = (row.replace(objType, '')).strip()
				fiasAddr.shortname = objType[ : -1]
				break


		if (row.find(u'г.') != -1):
			fiasAddr.formalname = (row.replace(u'г.', '')).strip()
			fiasAddr.shortname = u'г'
			break

	return fiasAddr

def ConnectToDB(dataBaseName, tableNames, dbUsername, hostname, userPass):
	try:
		# Устанавливаем соединение с БД
		connection = psycopg2.connect(dbname = dataBaseName, user = dbUsername, host = hostname, password = userPass)

		# Создаем курсор и проверяем наличие таблицы
		cursor = connection.cursor()
		cursor.execute("SELECT * FROM information_schema.tables WHERE table_name = %s OR table_name = %s", (tableNames[0],tableNames[1] ))

		if cursor.rowcount == 0:
			print u'Таблица %s не существует' % tableNames
			sys.exit(1)

	except (psycopg2.DatabaseError) as dbError:
		print 'Ошибка подключения к базе', dbError
		sys.exit(1)

	return connection	

def FiasSearch(addr, cursor):
	params = "upper(formalname) = '" + addr.formalname + "'"
	params = params + " AND shortname = '" + addr.shortname + "'"

	if (addr.housenum != ''):
		params = params + " AND upper(housenum) = '" + addr.housenum + "'"
	if (addr.structnum != ''):
		params = params + " AND strucnum = '" + addr.structnum + "'"
	if (addr.buildnum != ''):
		params = params + " AND buildnum = '" + addr.buildnum + "'"
	if (addr.regioncode != ''):
		params = params + " AND AddressObject.regioncode = '" + addr.regioncode + "'"
	
	# Не у всех полей в AddressObject есть почтовый индекс, поэтому не ведем по нему поиск
	'''
	if (addr.postalcode != ''):
	params = params + " AND AddressObject.postalcode = '" + addr.postalcode + "'"
	'''

	cursor.execute("""SELECT * 
					FROM House 
					INNER JOIN 
					AddressObject 
					ON House.aoguid = AddressObject.aoguid 
					WHERE """ + params)


if __name__ ==  "__main__":
	userPassword = None
	googleAPIkey = None
	dbUsername = None
	firstRecordNum = None
	lastRecordNum = None


	try:
		data = read_csv('price.csv', ';')
	except(IOError):
		print u"Не найден файл price.csv  в директории"
		sys.exit(0)

	if len(sys.argv) == 2 and sys.argv[1] == '-help':
		print u'\nИнструкция по эксплуатации:'
		print u'Первый аргумент – имя пользователя баз данных fias и companyminer в PSQL\nВторой аргумент – пароль пользователя'
		print u'Третий аргумент – ключ от Google API\nЧетвертый аргумент – номер первой записи в price.csv на проверку'
		print u'Пятый аргумент – номер последней записи в price.csv на проверку'
		sys.exit(0)

	elif len(sys.argv) == 6:
		dbUsername = sys.argv[1]
		userPassword = sys.argv[2]
		googleAPIkey = sys.argv[3]
		firstRecordNum = int(sys.argv[4])
		lastRecordNum = int(sys.argv[5])

	else:
		print u'Неверный формат параметров запуска. Запустите скрипт с параметром -help для вывода инструкции'
		sys.exit(0)

	data.drop(data.index[[0, 17, 22, 28, 66, 74, 80]], inplace = True)
	data.reset_index(drop = True, inplace = True)

	egrulPars = EgrulParser()
	yaPars = YandexSpravParser()
	goPars = GoogleAPIParser(googleAPIkey = googleAPIkey)

	fiasConnection = ConnectToDB('fias', ('house','addressobject'), dbUsername, 'localhost', userPassword)
	companyMinerConnection = ConnectToDB('companyminer', ('companyinformation',''), dbUsername, 'localhost', userPassword)
	fiasCursor = fiasConnection.cursor()
	companyMinerCursor = companyMinerConnection.cursor()

	if (firstRecordNum < 1 or lastRecordNum < firstRecordNum):
		print u'Неправильно заданы границы обработки'
		sys.exit(1)

	for i in range(firstRecordNum - 1, lastRecordNum):
		toWriteInDB = []
		name = data['НАЗВАНИЕ'][i].replace("«", '"', 10)
		name = name.replace("»", '"', 10)
		dirFIO = data['ФИО ДИРА'][i]
		foundDate = data['дата'][i].strip()
		addr = data['АДРЕС'][i].strip()
		
		print name

		bracketPos = name.find('(')
		if (bracketPos != -1):
			name = name[ : bracketPos].strip()
		else:
			name = name.strip()

		bracketPos = dirFIO.find('(')
		if (bracketPos != -1):
			dirFIO = dirFIO[ : bracketPos].strip()
		else:
			dirFIO = dirFIO.strip()

		toWriteInDB.append(name)
		toWriteInDB.append(foundDate)
		toWriteInDB.append(dirFIO)
		toWriteInDB.append(addr)

		companyMinerCursor.execute("""SELECT * 
									FROM CompanyInformation 
									WHERE companyname = %s AND foundationdate = %s AND directorfio = %s AND address = %s""", toWriteInDB)
		if (companyMinerCursor.rowcount != 0):
			print u"Запись уже существует"
			continue

		dirFIO = dirFIO.decode('utf-8').upper().encode('utf-8')
		addr = AddressParser(addr.decode('utf-8'))

		retValues = egrulPars.ListSearch(name = name, foundationDate = foundDate, addr = addr.SetUpper(), dirFIO = dirFIO, region = '77')

		if (retValues == None):
			for i in range(0, 11):
				toWriteInDB.append(None)

			companyMinerCursor.execute("""INSERT INTO CompanyInformation VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)""", toWriteInDB)
			companyMinerConnection.commit()

			continue

		egrulAddr = retValues[0]
		ogrn = retValues[1]
		inn = retValues[2]
		kpp = retValues[3]
		endActivityDate = None

		if (len(retValues) == 5):
			endActivityDate = retValues[4]

		toWriteInDB.append(egrulAddr)
		toWriteInDB.append(inn)
		toWriteInDB.append(ogrn)
		toWriteInDB.append(endActivityDate)
		toWriteInDB.append(os.path.abspath(os.curdir) + '/' + ogrn + '.pdf')

		egrulParsedAddr = egrulPars.ParseAddress(egrulAddr)
		egrulParsedAddr.regioncode = '77'

		# Ищем адрес в ФИАС
		FiasSearch(egrulParsedAddr, fiasCursor)
		if (fiasCursor.rowcount != 0):
			toWriteInDB.append(True)
		else:
			toWriteInDB.append(False)

		if (egrulParsedAddr.IfContains(addr) == True):
			toWriteInDB.append(True)
		else:
			toWriteInDB.append(False)

		yaResp = yaPars.YaSearch(orgName = name, loc_name = 'Москва', EgrulAddr = egrulParsedAddr)
		goResp = goPars.GoSearch(orgName = name, locName = u'Москва', EgrulAddr = egrulParsedAddr)

		if (yaResp != None):
			toWriteInDB.append(yaResp[0] + '; ' + yaResp[1] + '; ' + yaResp[2])
		else:
			toWriteInDB.append(None)

		if (goResp != None):
			toWriteInDB.append(goResp[0] + '; ' + goResp[1])
		else:
			toWriteInDB.append(None)


		if (egrulParsedAddr.IfContains(addr) == True):
			toWriteInDB.append(None)
			toWriteInDB.append(None)
		else:
			# Рассматривем второй адрес
			yaResp2 = yaPars.YaSearch(orgName = name, loc_name = 'Москва', EgrulAddr = addr, containingType = 'inYa')
			goResp2 = goPars.GoSearch(orgName = name, locName = u'Москва', EgrulAddr = addr, containingType = 'inGo')

			if (yaResp2 != None):
				toWriteInDB.append(yaResp2[0] + '; ' + yaResp2[1] + '; ' + yaResp2[2])
			else:
				toWriteInDB.append(None)

			if (goResp2 != None):
				toWriteInDB.append(goResp2[0] + '; ' + goResp2[1])
			else:
				toWriteInDB.append(None)

		companyMinerCursor.execute("""INSERT INTO CompanyInformation VALUES (%s,%s,%s,%s,%s,%s,%s,%s,lo_import(%s),%s,%s,%s,%s,%s,%s)""", toWriteInDB)
		companyMinerConnection.commit()

	fiasConnection.close()
	companyMinerConnection.close()