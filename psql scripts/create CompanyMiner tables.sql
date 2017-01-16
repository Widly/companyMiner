CREATE TABLE IF NOT EXISTS CompanyInformation (
COMPANYNAME TEXT,
FOUNDATIONDATE DATE,
DIRECTORFIO VARCHAR(100),
ADDRESS TEXT,
EGRULADDRESS TEXT,
INN VARCHAR(10),
OGRN VARCHAR(13),
ENDACTIVITYDATE DATE,
PDF oid,
EGRULADRINFIAS BOOLEAN,
IFSIMILLARADR BOOLEAN,
EGRULYASEARCH TEXT,
EGRULGOSEARCH TEXT,
YASEARCH TEXT,
GOSEARCH TEXT,
PRIMARY KEY(COMPANYNAME, FOUNDATIONDATE, DIRECTORFIO, ADDRESS)
);

COMMENT ON TABLE CompanyInformation IS 'Добытая информация о компаниях';
COMMENT ON COLUMN CompanyInformation.COMPANYNAME IS 'Название компании';
COMMENT ON COLUMN CompanyInformation.FOUNDATIONDATE IS 'Дата регистрации';
COMMENT ON COLUMN CompanyInformation.DIRECTORFIO IS 'ФИО директора';
COMMENT ON COLUMN CompanyInformation.ADDRESS IS 'Адрес из исходного документа';
COMMENT ON COLUMN CompanyInformation.EGRULADDRESS IS 'Адрес из ЕГРЮЛ';
COMMENT ON COLUMN CompanyInformation.INN IS 'ИНН';
COMMENT ON COLUMN CompanyInformation.OGRN IS 'ОГРН';
COMMENT ON COLUMN CompanyInformation.ENDACTIVITYDATE IS 'Дата прекращения деятельности';
COMMENT ON COLUMN CompanyInformation.PDF IS 'ID pdf файла из ЕГРЮЛ';
COMMENT ON COLUMN CompanyInformation.EGRULADRINFIAS IS 'Наличие адреса ЕГРЮЛ в ФИАС';
COMMENT ON COLUMN CompanyInformation.IFSIMILLARADR IS 'Похож ли исходный адрес на адрес из ЕГРЮЛ';
COMMENT ON COLUMN CompanyInformation.EGRULYASEARCH IS 'Поиск по паре (Название/Адрес из ЕГРЮЛ) в Yandex Справочнике';
COMMENT ON COLUMN CompanyInformation.EGRULGOSEARCH IS 'Поиск по паре (Название/Адрес из ЕГРЮЛ) в Google Places';
COMMENT ON COLUMN CompanyInformation.YASEARCH IS 'Поиск по паре (Название/Адрес из исходного документа) в Yandex Справочнике';
COMMENT ON COLUMN CompanyInformation.GOSEARCH IS 'Поиск по паре (Название/Адрес из исходного документа) в Google Places';