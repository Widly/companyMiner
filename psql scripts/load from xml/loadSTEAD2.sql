INSERT INTO Stead
	SELECT (xpath('./@STEADGUID', x))[1] AS STEADGUID
	, (xpath('./@NUMBER', x))[1] AS NUMBER
	, (xpath('./@REGIONCODE', x))[1] AS REGIONCODE
	, (xpath('./@POSTALCODE', x))[1] AS POSTALCODE
	, (xpath('./@IFNSFL', x))[1] AS IFNSFL
	, (xpath('./@TERRIFNSFL', x))[1] AS TERRIFNSFL
	, (xpath('./@IFNSUL', x))[1] AS IFNSUL
	, (xpath('./@TERRIFNSUL', x))[1] AS TERRIFNSUL
	, (xpath('./@OKATO', x))[1] AS OKATO
	, (xpath('./@OKTMO', x))[1] AS OKTMO
	, TO_DATE((xpath('./@UPDATEDATE', x))[1]::varchar, 'YYYY-MM-DD') AS UPDATEDATE
	, (xpath('./@PARENTGUID', x))[1] AS PARENTGUID
	, (xpath('./@STEADID', x))[1] AS STEADID
	, (xpath('./@PREVID', x))[1] AS PREVID
	, (xpath('./@NEXTID', x))[1] AS NEXTID
	, (xpath('./@OPERSTATUS', x))[1]::varchar::int AS OPERSTATUS
	, TO_DATE((xpath('./@STARTDATE', x))[1]::varchar, 'YYYY-MM-DD') AS STARTDATE
	, TO_DATE((xpath('./@ENDDATE', x))[1]::varchar, 'YYYY-MM-DD') AS ENDDATE
	, (xpath('./@NORMDOC', x))[1] AS NORMDOC
	, (xpath('./@LIVESTATUS', x))[1]::varchar::LIVESTATUSENUM AS LIVESTATUS
	, (xpath('./@CADNUM', x))[1] AS CADNUM
	, (xpath('./@DIVTYPE', x))[1]::varchar::DIVTYPEENUM AS DIVTYPE
FROM unnest(xpath('./Stead', 
    	convert_from(bytea_import('fias_xml/STEAD.XML'), 'UTF8')::xml)) x;