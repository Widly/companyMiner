CREATE TYPE LIVESTATUSENUM AS ENUM('0','1');
CREATE TYPE DIVTYPEENUM AS ENUM('0', '1', '2');

CREATE TABLE IF NOT EXISTS ActualStatus (
ACTSTATID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL 
);

COMMENT ON TABLE ActualStatus IS 'Статус актуальности ФИАС';
COMMENT ON COLUMN ActualStatus.ACTSTATID IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN ActualStatus.NAME IS 'Наименование';

CREATE TABLE IF NOT EXISTS AddressObject (
AOGUID VARCHAR(36) NOT NULL,
FORMALNAME VARCHAR(120) NOT NULL,
REGIONCODE VARCHAR(2) NOT NULL,
AUTOCODE VARCHAR(1) NOT NULL,
AREACODE VARCHAR(3) NOT NULL,
CITYCODE VARCHAR(3) NOT NULL,
CTARCODE VARCHAR(3) NOT NULL,
PLACECODE VARCHAR(3) NOT NULL,
STREETCODE VARCHAR(4),
EXTRCODE VARCHAR(4) NOT NULL,
SEXTCODE VARCHAR(3) NOT NULL,
OFFNAME VARCHAR(120),
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
SHORTNAME VARCHAR(10) NOT NULL,
AOLEVEL INTEGER NOT NULL,
PARENTGUID VARCHAR(36),
AOID VARCHAR(36) NOT NULL PRIMARY KEY,
PREVID VARCHAR(36),
NEXTID VARCHAR(36),
CODE VARCHAR(17),
PLAINCODE VARCHAR(15),
ACTSTATUS INTEGER NOT NULL,
CENTSTATUS INTEGER NOT NULL,
OPERSTATUS INTEGER NOT NULL,
CURRSTATUS INTEGER NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
NORMDOC VARCHAR(36),
LIVESTATUS LIVESTATUSENUM NOT NULL,
CADNUM VARCHAR(100),
DIVTYPE DIVTYPEENUM
);

COMMENT ON TABLE AddressObject IS 'Классификатор адресообразующих элементов';
COMMENT ON COLUMN AddressObject.AOGUID IS 'Глобальный уникальный идентификатор адресного объекта ';
COMMENT ON COLUMN AddressObject.FORMALNAME IS 'Формализованное наименование';
COMMENT ON COLUMN AddressObject.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN AddressObject.AUTOCODE IS 'Код автономии';
COMMENT ON COLUMN AddressObject.AREACODE IS 'Код района';
COMMENT ON COLUMN AddressObject.CITYCODE IS 'Код города';
COMMENT ON COLUMN AddressObject.CTARCODE IS 'Код внутригородского района';
COMMENT ON COLUMN AddressObject.PLACECODE IS 'Код населенного пункта';
COMMENT ON COLUMN AddressObject.STREETCODE IS 'Код улицы';
COMMENT ON COLUMN AddressObject.EXTRCODE IS 'Код дополнительного адресообразующего элемента';
COMMENT ON COLUMN AddressObject.SEXTCODE IS 'Код подчиненного дополнительного адресообразующего элемента';
COMMENT ON COLUMN AddressObject.OFFNAME IS 'Официальное наименование';
COMMENT ON COLUMN AddressObject.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN AddressObject.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN AddressObject.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN AddressObject.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN AddressObject.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN AddressObject.OKATO IS 'ОКАТО';
COMMENT ON COLUMN AddressObject.OKTMO IS 'ОКТМО';
COMMENT ON COLUMN AddressObject.UPDATEDATE IS 'Дата  внесения (обновления) записи';
COMMENT ON COLUMN AddressObject.SHORTNAME IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN AddressObject.AOLEVEL IS 'Уровень адресного объекта ';
COMMENT ON COLUMN AddressObject.PARENTGUID IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN AddressObject.AOID IS 'Уникальный идентификатор записи. Ключевое поле';
COMMENT ON COLUMN AddressObject.PREVID IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN AddressObject.NEXTID IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN AddressObject.CODE IS 'Код адресного объекта одной строкой с признаком актуальности из КЛАДР 4.0. ';
COMMENT ON COLUMN AddressObject.PLAINCODE IS 'Код адресного объекта из КЛАДР 4.0 одной строкой без признака актуальности (последних двух цифр)';
COMMENT ON COLUMN AddressObject.ACTSTATUS IS 'Статус актуальности адресного объекта ФИАС. Актуальный адрес на текущую дату. Обычно последняя запись об адресном объекте.';
COMMENT ON COLUMN AddressObject.CENTSTATUS IS 'Статус центра';
COMMENT ON COLUMN AddressObject.OPERSTATUS IS 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)';
COMMENT ON COLUMN AddressObject.CURRSTATUS IS 'Статус актуальности КЛАДР 4 (последние две цифры в коде)';
COMMENT ON COLUMN AddressObject.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN AddressObject.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN AddressObject.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN AddressObject.LIVESTATUS IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN AddressObject.CADNUM IS 'Кадастровый номер';
COMMENT ON COLUMN AddressObject.DIVTYPE IS 'Тип адресации: 0 - не определено, 1 - муниципальный, 2 - административно-территориальный';


CREATE TABLE IF NOT EXISTS CenterStatus (
CENTERSTID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL
);

COMMENT ON TABLE CenterStatus IS 'Статус центра';
COMMENT ON COLUMN CenterStatus.CENTERSTID IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN CenterStatus.NAME IS 'Наименование';


CREATE TABLE IF NOT EXISTS CurrentStatus (
CURENTSTID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL
);

COMMENT ON TABLE CurrentStatus IS 'Статус актуальности КЛАДР 4.0';
COMMENT ON COLUMN CurrentStatus.CURENTSTID IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN CurrentStatus.NAME IS 'Наименование';


CREATE TABLE IF NOT EXISTS EstateStatus (
ESTSTATID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(20) NOT NULL,
SHORTNAME VARCHAR(20)
);

COMMENT ON TABLE EstateStatus IS 'Признак владения';
COMMENT ON COLUMN EstateStatus.ESTSTATID IS 'Признак владения (ключ)';
COMMENT ON COLUMN EstateStatus.NAME IS 'Наименование';
COMMENT ON COLUMN EstateStatus.SHORTNAME IS 'Краткое наименование';


CREATE TABLE IF NOT EXISTS House (
POSTALCODE VARCHAR(6),
REGIONCODE VARCHAR(2),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
HOUSENUM VARCHAR(20),
ESTSTATUS INTEGER NOT NULL,
BUILDNUM VARCHAR(10),
STRUCNUM VARCHAR(10),
STRSTATUS INTEGER,
HOUSEID VARCHAR(36) NOT NULL PRIMARY KEY,
HOUSEGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
STATSTATUS INTEGER NOT NULL,
NORMDOC VARCHAR(36),
COUNTER INTEGER NOT NULL,
CADNUM VARCHAR(100),
DIVTYPE DIVTYPEENUM NOT NULL
);

COMMENT ON TABLE House IS 'Сведения по номерам домов улиц городов и населенных пунктов, номера земельных участков и т.п.';
COMMENT ON COLUMN House.POSTALCODE IS 'Почтовый индекс'; 
COMMENT ON COLUMN House.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN House.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN House.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN House.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN House.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN House.OKATO IS 'ОКАТО';
COMMENT ON COLUMN House.OKTMO IS 'ОКTMO';
COMMENT ON COLUMN House.UPDATEDATE IS 'Дата время внесения (обновления) записи';
COMMENT ON COLUMN House.HOUSENUM IS 'Номер дома';
COMMENT ON COLUMN House.ESTSTATUS IS 'Признак владения';
COMMENT ON COLUMN House.BUILDNUM IS 'Номер корпуса';
COMMENT ON COLUMN House.STRUCNUM IS 'Номер строения';
COMMENT ON COLUMN House.STRSTATUS IS 'Признак строения';
COMMENT ON COLUMN House.HOUSEID IS 'Уникальный идентификатор записи дома';
COMMENT ON COLUMN House.HOUSEGUID IS 'Глобальный уникальный идентификатор дома';
COMMENT ON COLUMN House.AOGUID IS 'Guid записи родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN House.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN House.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN House.STATSTATUS IS 'Состояние дома';
COMMENT ON COLUMN House.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN House.COUNTER IS 'Счетчик записей домов для КЛАДР 4';
COMMENT ON COLUMN House.CADNUM IS 'Кадастровый номер';
COMMENT ON COLUMN House.DIVTYPE IS 'Тип адресации: 0 - не определено, 1 - муниципальный, 2 - административно-территориальный';


CREATE TABLE IF NOT EXISTS HouseInterval (
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
INTSTART INTEGER NOT NULL,
INTEND INTEGER NOT NULL,
HOUSEINTID VARCHAR(36) NOT NULL PRIMARY KEY,
INTGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
INTSTATUS INTEGER NOT NULL,
NORMDOC VARCHAR(36),
COUNTER INTEGER NOT NULL
);

COMMENT ON TABLE HouseInterval IS 'Интервалы домов';
COMMENT ON COLUMN HouseInterval.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN HouseInterval.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN HouseInterval.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN HouseInterval.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN HouseInterval.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN HouseInterval.OKATO IS 'ОКАТО';
COMMENT ON COLUMN HouseInterval.OKTMO IS 'ОКTMO';
COMMENT ON COLUMN HouseInterval.UPDATEDATE IS 'Дата время внесения (обновления) записи';
COMMENT ON COLUMN HouseInterval.INTSTART IS 'Значение начала интервала';
COMMENT ON COLUMN HouseInterval.INTEND IS 'Значение окончания интервала';
COMMENT ON COLUMN HouseInterval.HOUSEINTID IS 'Идентификатор записи интервала домов';
COMMENT ON COLUMN HouseInterval.INTGUID IS 'Глобальный уникальный идентификатор интервала домов';
COMMENT ON COLUMN HouseInterval.AOGUID IS 'Идентификатор объекта родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN HouseInterval.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN HouseInterval.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN HouseInterval.INTSTATUS IS 'Статус интервала (обычный, четный, нечетный)';
COMMENT ON COLUMN HouseInterval.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN HouseInterval.COUNTER IS 'Счетчик записей домов для КЛАДР 4';


CREATE TABLE IF NOT EXISTS HouseStateStatus (
HOUSESTID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(60) NOT NULL
);

COMMENT ON TABLE HouseStateStatus IS 'Статус состояния домов';
COMMENT ON COLUMN HouseStateStatus.HOUSESTID IS 'Идентификатор статуса';
COMMENT ON COLUMN HouseStateStatus.NAME IS 'Наименование';


CREATE TABLE IF NOT EXISTS IntervalStatus (
INTVSTATID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(60) NOT NULL
);

COMMENT ON TABLE IntervalStatus IS 'Статус интервала домов';
COMMENT ON COLUMN IntervalStatus.INTVSTATID IS 'Идентификатор статуса (обычный, четный, нечетный)';
COMMENT ON COLUMN IntervalStatus.NAME IS 'Наименование';


CREATE TABLE IF NOT EXISTS Landmark (
LOCATION VARCHAR(500) NOT NULL,
REGIONCODE VARCHAR(2),
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
INFSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
LANDID VARCHAR(36) NOT NULL,
LANDGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
NORMDOC VARCHAR(36),
CADNUM VARCHAR(100)
);

COMMENT ON TABLE Landmark IS 'Описание мест расположения  имущественных объектов';
COMMENT ON COLUMN Landmark.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN Landmark.LOCATION IS 'Месторасположение ориентира';
COMMENT ON COLUMN Landmark.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN Landmark.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN Landmark.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN Landmark.INFSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN Landmark.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN Landmark.OKATO IS 'ОКАТО';
COMMENT ON COLUMN Landmark.OKTMO IS 'ОКТМО';
COMMENT ON COLUMN Landmark.UPDATEDATE IS 'Дата внесения (обновления) записи';
COMMENT ON COLUMN Landmark.LANDID IS 'Уникальный идентификатор записи ориентира';
COMMENT ON COLUMN Landmark.LANDGUID IS 'Глобальный уникальный идентификатор ориентира';
COMMENT ON COLUMN Landmark.AOGUID IS 'Уникальный идентификатор родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN Landmark.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN Landmark.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN Landmark.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN Landmark.CADNUM IS 'Кадастровый номер';


CREATE TABLE IF NOT EXISTS DeletedLandmark (
LOCATION VARCHAR(500) NOT NULL,
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
INFSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
LANDID VARCHAR(36) NOT NULL,
LANDGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
NORMDOC VARCHAR(36) NOT NULL
);

COMMENT ON TABLE DeletedLandmark IS 'Описание мест расположения  имущественных объектов';
COMMENT ON COLUMN DeletedLandmark.LOCATION IS 'Месторасположение ориентира';
COMMENT ON COLUMN DeletedLandmark.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN DeletedLandmark.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN DeletedLandmark.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN DeletedLandmark.INFSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN DeletedLandmark.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN DeletedLandmark.OKATO IS 'ОКАТО';
COMMENT ON COLUMN DeletedLandmark.OKTMO IS 'ОКТМО';
COMMENT ON COLUMN DeletedLandmark.UPDATEDATE IS 'Дата  внесения записи';
COMMENT ON COLUMN DeletedLandmark.LANDID IS 'Уникальный идентификатор записи ориентира';
COMMENT ON COLUMN DeletedLandmark.LANDGUID IS 'Глобальный уникальный идентификатор ориентира';
COMMENT ON COLUMN DeletedLandmark.AOGUID IS 'Уникальный идентификатор родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN DeletedLandmark.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN DeletedLandmark.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN DeletedLandmark.NORMDOC IS 'Внешний ключ на нормативный документ';


CREATE TABLE IF NOT EXISTS NormativeDocumentType (
NDTYPEID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(250) NOT NULL
);

COMMENT ON TABLE NormativeDocumentType IS 'Тип нормативного документа';
COMMENT ON COLUMN NormativeDocumentType.NDTYPEID IS 'Идентификатор записи (ключ)';
COMMENT ON COLUMN NormativeDocumentType.NAME IS 'Наименование типа нормативного документа';


CREATE TABLE IF NOT EXISTS NormativeDocument (
NORMDOCID VARCHAR(36) NOT NULL,
DOCNAME TEXT,
DOCDATE DATE,
DOCNUM VARCHAR(30),
DOCTYPE INTEGER NOT NULL,
DOCIMGID INTEGER
);

COMMENT ON TABLE NormativeDocument IS 'Сведения по нормативному документу, являющемуся основанием присвоения адресному элементу наименования';
COMMENT ON COLUMN NormativeDocument.NORMDOCID IS 'Идентификатор нормативного документа';
COMMENT ON COLUMN NormativeDocument.DOCNAME IS 'Наименование документа';
COMMENT ON COLUMN NormativeDocument.DOCDATE IS 'Дата документа';
COMMENT ON COLUMN NormativeDocument.DOCNUM IS 'Номер документа';
COMMENT ON COLUMN NormativeDocument.DOCTYPE IS 'Тип документа';
COMMENT ON COLUMN NormativeDocument.DOCIMGID IS 'Идентификатор образа (внешний ключ)';


CREATE TABLE IF NOT EXISTS OperationStatus (
OPERSTATID INTEGER NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL
);

COMMENT ON TABLE OperationStatus IS 'Статус действия';
COMMENT ON COLUMN OperationStatus.OPERSTATID IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN OperationStatus.NAME IS 'Наименование';


CREATE TABLE IF NOT EXISTS StructureStatus (
STRSTATID INTEGER NOT NULL,
NAME VARCHAR(20) NOT NULL,
SHORTNAME VARCHAR(20)
);

COMMENT ON TABLE StructureStatus IS 'Признак строения';
COMMENT ON COLUMN StructureStatus.STRSTATID IS 'Признак строения';
COMMENT ON COLUMN StructureStatus.NAME IS 'Наименование';
COMMENT ON COLUMN StructureStatus.SHORTNAME IS 'Краткое наименование';


CREATE TABLE IF NOT EXISTS DeletedAddressObject (
AOGUID VARCHAR(36) NOT NULL,
FORMALNAME VARCHAR(120) NOT NULL,
REGIONCODE VARCHAR(2) NOT NULL,
AUTOCODE VARCHAR(1) NOT NULL,
AREACODE VARCHAR(3) NOT NULL,
CITYCODE VARCHAR(3) NOT NULL,
CTARCODE VARCHAR(3) NOT NULL,
PLACECODE VARCHAR(3) NOT NULL,
STREETCODE VARCHAR(4),
EXTRCODE VARCHAR(4) NOT NULL,
SEXTCODE VARCHAR(3) NOT NULL,
OFFNAME VARCHAR(120),
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
SHORTNAME VARCHAR(10) NOT NULL,
AOLEVEL INTEGER NOT NULL,
PARENTGUID VARCHAR(36),
AOID VARCHAR(36) NOT NULL PRIMARY KEY,
PREVID VARCHAR(36),
NEXTID VARCHAR(36),
CODE VARCHAR(17),
PLAINCODE VARCHAR(15),
ACTSTATUS INTEGER NOT NULL,
CENTSTATUS INTEGER NOT NULL,
OPERSTATUS INTEGER NOT NULL,
CURRSTATUS INTEGER NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
NORMDOC VARCHAR(36),
LIVESTATUS LIVESTATUSENUM NOT NULL
);

COMMENT ON TABLE DeletedAddressObject IS 'Классификатор адресообразующих элементов';
COMMENT ON COLUMN DeletedAddressObject.AOGUID IS 'Глобальный уникальный идентификатор адресного объекта ';
COMMENT ON COLUMN DeletedAddressObject.FORMALNAME IS 'Формализованное наименование';
COMMENT ON COLUMN DeletedAddressObject.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN DeletedAddressObject.AUTOCODE IS 'Код автономии';
COMMENT ON COLUMN DeletedAddressObject.AREACODE IS 'Код района';
COMMENT ON COLUMN DeletedAddressObject.CITYCODE IS 'Код города';
COMMENT ON COLUMN DeletedAddressObject.CTARCODE IS 'Код внутригородского района';
COMMENT ON COLUMN DeletedAddressObject.PLACECODE IS 'Код населенного пункта';
COMMENT ON COLUMN DeletedAddressObject.STREETCODE IS 'Код улицы';
COMMENT ON COLUMN DeletedAddressObject.EXTRCODE IS 'Код дополнительного адресообразующего элемента';
COMMENT ON COLUMN DeletedAddressObject.SEXTCODE IS 'Код подчиненного дополнительного адресообразующего элемента';
COMMENT ON COLUMN DeletedAddressObject.OFFNAME IS 'Официальное наименование';
COMMENT ON COLUMN DeletedAddressObject.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN DeletedAddressObject.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN DeletedAddressObject.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN DeletedAddressObject.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN DeletedAddressObject.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN DeletedAddressObject.OKATO IS 'ОКАТО';
COMMENT ON COLUMN DeletedAddressObject.OKTMO IS 'ОКТМО';
COMMENT ON COLUMN DeletedAddressObject.UPDATEDATE IS 'Дата  внесения (обновления) записи';
COMMENT ON COLUMN DeletedAddressObject.SHORTNAME IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN DeletedAddressObject.AOLEVEL IS 'Уровень адресного объекта ';
COMMENT ON COLUMN DeletedAddressObject.PARENTGUID IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN DeletedAddressObject.AOID IS 'Уникальный идентификатор записи. Ключевое поле';
COMMENT ON COLUMN DeletedAddressObject.PREVID IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN DeletedAddressObject.NEXTID IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN DeletedAddressObject.CODE IS 'Код адресного объекта одной строкой с признаком актуальности из КЛАДР 4.0. ';
COMMENT ON COLUMN DeletedAddressObject.PLAINCODE IS 'Код адресного объекта из КЛАДР 4.0 одной строкой без признака актуальности (последних двух цифр)';
COMMENT ON COLUMN DeletedAddressObject.ACTSTATUS IS 'Статус актуальности адресного объекта ФИАС. Актуальный адрес на текущую дату. Обычно последняя запись об адресном объекте.';
COMMENT ON COLUMN DeletedAddressObject.CENTSTATUS IS 'Статус центра';
COMMENT ON COLUMN DeletedAddressObject.OPERSTATUS IS 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)';
COMMENT ON COLUMN DeletedAddressObject.CURRSTATUS IS 'Статус актуальности КЛАДР 4 (последние две цифры в коде)';
COMMENT ON COLUMN DeletedAddressObject.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN DeletedAddressObject.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN DeletedAddressObject.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN DeletedAddressObject.LIVESTATUS IS 'Признак действующего адресного объекта';


CREATE TABLE IF NOT EXISTS DeletedHouse (
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
HOUSENUM VARCHAR(20),
ESTSTATUS INTEGER NOT NULL,
BUILDNUM VARCHAR(10),
STRUCNUM VARCHAR(10),
STRSTATUS INTEGER,
HOUSEID VARCHAR(36) NOT NULL PRIMARY KEY,
HOUSEGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
STATSTATUS INTEGER NOT NULL,
NORMDOC VARCHAR(36),
COUNTER INTEGER NOT NULL,
CADNUM VARCHAR(100),
DIVTYPE DIVTYPEENUM NOT NULL
);

COMMENT ON TABLE DeletedHouse IS 'Сведения по номерам домов улиц городов и населенных пунктов, номера земельных участков и т.п.';
COMMENT ON COLUMN DeletedHouse.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN DeletedHouse.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN DeletedHouse.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN DeletedHouse.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN DeletedHouse.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN DeletedHouse.OKATO IS 'ОКАТО';
COMMENT ON COLUMN DeletedHouse.OKTMO IS 'ОКTMO';
COMMENT ON COLUMN DeletedHouse.UPDATEDATE IS 'Дата время внесения (обновления) записи';
COMMENT ON COLUMN DeletedHouse.HOUSENUM IS 'Номер дома';
COMMENT ON COLUMN DeletedHouse.ESTSTATUS IS 'Признак владения';
COMMENT ON COLUMN DeletedHouse.BUILDNUM IS 'Номер корпуса';
COMMENT ON COLUMN DeletedHouse.STRUCNUM IS 'Номер строения';
COMMENT ON COLUMN DeletedHouse.STRSTATUS IS 'Признак строения';
COMMENT ON COLUMN DeletedHouse.HOUSEID IS 'Уникальный идентификатор записи дома';
COMMENT ON COLUMN DeletedHouse.HOUSEGUID IS 'Глобальный уникальный идентификатор дома';
COMMENT ON COLUMN DeletedHouse.AOGUID IS 'Guid записи родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN DeletedHouse.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN DeletedHouse.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN DeletedHouse.STATSTATUS IS 'Состояние дома';
COMMENT ON COLUMN DeletedHouse.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN DeletedHouse.COUNTER IS 'Счетчик записей домов для КЛАДР 4';
COMMENT ON COLUMN DeletedHouse.CADNUM IS 'Кадастровый номер';
COMMENT ON COLUMN DeletedHouse.DIVTYPE IS 'Тип адресации: 0 - не определено, 1 - муниципальный, 2 - административно-территориальный';


CREATE TABLE IF NOT EXISTS DeletedHouseInterval (
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
INTSTART INTEGER NOT NULL,
INTEND INTEGER NOT NULL,
HOUSEINTID VARCHAR(36) NOT NULL PRIMARY KEY,
INTGUID VARCHAR(36) NOT NULL,
AOGUID VARCHAR(36) NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
INTSTATUS INTEGER NOT NULL,
NORMDOC VARCHAR(36),
COUNTER INTEGER NOT NULL
);


COMMENT ON TABLE DeletedHouseInterval IS 'Интервалы домов';
COMMENT ON COLUMN DeletedHouseInterval.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN DeletedHouseInterval.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN DeletedHouseInterval.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN DeletedHouseInterval.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN DeletedHouseInterval.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN DeletedHouseInterval.OKATO IS 'ОКАТО';
COMMENT ON COLUMN DeletedHouseInterval.OKTMO IS 'ОКTMO';
COMMENT ON COLUMN DeletedHouseInterval.UPDATEDATE IS 'Дата время внесения (обновления) записи';
COMMENT ON COLUMN DeletedHouseInterval.INTSTART IS 'Значение начала интервала';
COMMENT ON COLUMN DeletedHouseInterval.INTEND IS 'Значение окончания интервала';
COMMENT ON COLUMN DeletedHouseInterval.HOUSEINTID IS 'Идентификатор записи интервала домов';
COMMENT ON COLUMN DeletedHouseInterval.INTGUID IS 'Глобальный уникальный идентификатор интервала домов';
COMMENT ON COLUMN DeletedHouseInterval.AOGUID IS 'Идентификатор объекта родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN DeletedHouseInterval.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN DeletedHouseInterval.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN DeletedHouseInterval.INTSTATUS IS 'Статус интервала (обычный, четный, нечетный)';
COMMENT ON COLUMN DeletedHouseInterval.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN DeletedHouseInterval.COUNTER IS 'Счетчик записей домов для КЛАДР 4';


CREATE TABLE IF NOT EXISTS DeletedNormativeDocument (
NORMDOCID VARCHAR(36) NOT NULL,
DOCNAME TEXT,
DOCDATE DATE,
DOCNUM VARCHAR(20),
DOCTYPE INTEGER NOT NULL,
DOCIMGID INTEGER
);

COMMENT ON TABLE DeletedNormativeDocument IS 'Сведения по нормативному документу, являющемуся основанием присвоения адресному элементу наименования';
COMMENT ON COLUMN DeletedNormativeDocument.NORMDOCID IS 'Идентификатор нормативного документа';
COMMENT ON COLUMN DeletedNormativeDocument.DOCNAME IS 'Наименование документа';
COMMENT ON COLUMN DeletedNormativeDocument.DOCDATE IS 'Дата документа';
COMMENT ON COLUMN DeletedNormativeDocument.DOCNUM IS 'Номер документа';
COMMENT ON COLUMN DeletedNormativeDocument.DOCTYPE IS 'Тип документа';
COMMENT ON COLUMN DeletedNormativeDocument.DOCIMGID IS 'Идентификатор образа (внешний ключ)';


CREATE TABLE IF NOT EXISTS Room (
ROOMGUID VARCHAR(36) NOT NULL,
FLATNUMBER VARCHAR(50) NOT NULL,
FLATTYPE INTEGER NOT NULL,
ROOMNUMBER VARCHAR(50),
ROOMTYPE INTEGER,
REGIONCODE VARCHAR(2) NOT NULL,
POSTALCODE VARCHAR(6),
UPDATEDATE DATE NOT NULL,
HOUSEGUID VARCHAR(36) NOT NULL,
ROOMID VARCHAR(36) NOT NULL PRIMARY KEY,
PREVID VARCHAR(36),
NEXTID VARCHAR(36),
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
LIVESTATUS LIVESTATUSENUM NOT NULL,
NORMDOC VARCHAR(36),
OPERSTATUS INTEGER NOT NULL,
CADNUM VARCHAR(100),
ROOMCADNUM VARCHAR(100)
);

COMMENT ON TABLE Room IS 'Классификатор помещений';
COMMENT ON COLUMN Room.ROOMGUID IS 'Глобальный уникальный идентификатор адресного объекта (помещения)';
COMMENT ON COLUMN Room.FLATNUMBER IS 'Номер помещения или офиса';
COMMENT ON COLUMN Room.FLATTYPE IS 'Тип помещения';
COMMENT ON COLUMN Room.ROOMNUMBER IS 'Номер комнаты';
COMMENT ON COLUMN Room.ROOMTYPE IS 'Тип комнаты';
COMMENT ON COLUMN Room.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN Room.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN Room.UPDATEDATE IS 'Дата  внесения записи';
COMMENT ON COLUMN Room.HOUSEGUID IS 'Идентификатор родительского объекта (дома)';
COMMENT ON COLUMN Room.ROOMID IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN Room.PREVID IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN Room.NEXTID IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN Room.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN Room.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN Room.LIVESTATUS IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN Room.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN Room.OPERSTATUS IS 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)';
COMMENT ON COLUMN Room.CADNUM IS 'Кадастровый номер помещения';
COMMENT ON COLUMN Room.ROOMCADNUM IS 'Кадастровый номер комнаты в помещении';


CREATE TABLE IF NOT EXISTS Stead (
STEADGUID VARCHAR(36) NOT NULL,
NUMBER VARCHAR(120),
REGIONCODE VARCHAR(2) NOT NULL,
POSTALCODE VARCHAR(6),
IFNSFL VARCHAR(4),
TERRIFNSFL VARCHAR(4),
IFNSUL VARCHAR(4),
TERRIFNSUL VARCHAR(4),
OKATO VARCHAR(11),
OKTMO VARCHAR(11),
UPDATEDATE DATE NOT NULL,
PARENTGUID VARCHAR(36),
STEADID VARCHAR(36) NOT NULL PRIMARY KEY,
PREVID VARCHAR(36),
NEXTID VARCHAR(36),
OPERSTATUS INTEGER NOT NULL,
STARTDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
NORMDOC VARCHAR(36),
LIVESTATUS LIVESTATUSENUM NOT NULL,
CADNUM VARCHAR(100),
DIVTYPE DIVTYPEENUM NOT NULL
);

COMMENT ON TABLE Stead IS 'Классификатор земельных участков';
COMMENT ON COLUMN Stead.STEADGUID IS 'Глобальный уникальный идентификатор адресного объекта (земельного участка)';
COMMENT ON COLUMN Stead.NUMBER IS 'Номер земельного участка';
COMMENT ON COLUMN Stead.REGIONCODE IS 'Код региона';
COMMENT ON COLUMN Stead.POSTALCODE IS 'Почтовый индекс';
COMMENT ON COLUMN Stead.IFNSFL IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN Stead.TERRIFNSFL IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN Stead.IFNSUL IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN Stead.TERRIFNSUL IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN Stead.OKATO IS 'ОКАТО';
COMMENT ON COLUMN Stead.OKTMO IS 'ОКTMO';
COMMENT ON COLUMN Stead.UPDATEDATE IS 'Дата  внесения записи';
COMMENT ON COLUMN Stead.PARENTGUID IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN Stead.STEADID IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN Stead.PREVID IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN Stead.NEXTID IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN Stead.OPERSTATUS IS 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus)';
COMMENT ON COLUMN Stead.STARTDATE IS 'Начало действия записи';
COMMENT ON COLUMN Stead.ENDDATE IS 'Окончание действия записи';
COMMENT ON COLUMN Stead.NORMDOC IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN Stead.LIVESTATUS IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN Stead.CADNUM IS 'Кадастровый номер';
COMMENT ON COLUMN Stead.DIVTYPE IS 'Тип адресации: 0 - не определено, 1 - муниципальный, 2 - административно-территориальный';

CREATE TABLE IF NOT EXISTS AddressObjectType (
LEVEL INTEGER NOT NULL,
SCNAME VARCHAR(10),
SOCRNAME VARCHAR(50) NOT NULL,
KOD_T_ST VARCHAR(4) NOT NULL PRIMARY KEY
);

COMMENT ON TABLE AddressObjectType IS 'Тип адресного объекта';
COMMENT ON COLUMN AddressObjectType.LEVEL IS 'Уровень адресного объекта';
COMMENT ON COLUMN AddressObjectType.SCNAME IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN AddressObjectType.SOCRNAME IS 'Полное наименование типа объекта';
COMMENT ON COLUMN AddressObjectType.KOD_T_ST IS 'Ключевое поле';