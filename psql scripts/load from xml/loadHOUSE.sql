INSERT INTO House
	SELECT (xpath('./@POSTALCODE', x))[1] AS POSTALCODE
	, (xpath('./@REGIONCODE', x))[1] AS REGIONCODE
	, (xpath('./@IFNSFL', x))[1] AS IFNSFL
	, (xpath('./@TERRIFNSFL', x))[1] AS TERRIFNSFL
	, (xpath('./@IFNSUL', x))[1] AS IFNSUL
	, (xpath('./@TERRIFNSUL', x))[1] AS TERRIFNSUL
	, (xpath('./@OKATO', x))[1] AS OKATO
	, (xpath('./@OKTMO', x))[1] AS OKTMO
	, TO_DATE((xpath('./@UPDATEDATE', x))[1]::varchar, 'YYYY-MM-DD') AS UPDATEDATE
	, (xpath('./@HOUSENUM', x))[1] AS HOUSENUM
	, (xpath('./@ESTSTATUS', x))[1]::varchar::int AS ESTSTATUS
	, (xpath('./@BUILDNUM', x))[1] AS BUILDNUM
	, (xpath('./@STRUCNUM', x))[1] AS STRUCNUM
	, (xpath('./@STRSTATUS', x))[1]::varchar::int AS STRSTATUS
	, (xpath('./@HOUSEID', x))[1] AS HOUSEID
	, (xpath('./@HOUSEGUID', x))[1] AS HOUSEGUID
	, (xpath('./@AOGUID', x))[1] AS AOGUID
	, TO_DATE((xpath('./@STARTDATE', x))[1]::varchar, 'YYYY-MM-DD') AS STARTDATE
	, TO_DATE((xpath('./@ENDDATE', x))[1]::varchar, 'YYYY-MM-DD') AS ENDDATE
	, (xpath('./@STATSTATUS', x))[1]::varchar::int AS STATSTATUS
	, (xpath('./@NORMDOC', x))[1] AS NORMDOC
	, (xpath('./@COUNTER', x))[1]::varchar::int AS COUNTER
	, (xpath('./@CADNUM', x))[1] AS CADNUM
	, (xpath('./@DIVTYPE', x))[1]::varchar::DIVTYPEENUM AS DIVTYPE
FROM unnest(xpath('./House', 
    	convert_from(bytea_import('fias_xml/HOUSE.XML'), 'UTF8')::xml)) x;