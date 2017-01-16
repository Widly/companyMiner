CREATE TEMP TABLE tmp (x xml);
INSERT INTO tmp VALUES (
    XMLPARSE(DOCUMENT convert_from(
        pg_read_binary_file('fias_xml/STEAD.XML'), 'UTF8'))

);

INSERT INTO Stead
	SELECT (xpath('./@STEADGUID', c.node))[1] AS STEADGUID
	, (xpath('./@NUMBER', c.node))[1] AS NUMBER
	, (xpath('./@REGIONCODE', c.node))[1] AS REGIONCODE
	, (xpath('./@POSTALCODE', c.node))[1] AS POSTALCODE
	, (xpath('./@IFNSFL', c.node))[1] AS IFNSFL
	, (xpath('./@TERRIFNSFL', c.node))[1] AS TERRIFNSFL
	, (xpath('./@IFNSUL', c.node))[1] AS IFNSUL
	, (xpath('./@TERRIFNSUL', c.node))[1] AS TERRIFNSUL
	, (xpath('./@OKATO', c.node))[1] AS OKATO
	, (xpath('./@OKTMO', c.node))[1] AS OKTMO
	, TO_DATE((xpath('./@UPDATEDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS UPDATEDATE
	, (xpath('./@PARENTGUID', c.node))[1] AS PARENTGUID
	, (xpath('./@STEADID', c.node))[1] AS STEADID
	, (xpath('./@PREVID', c.node))[1] AS PREVID
	, (xpath('./@NEXTID', c.node))[1] AS NEXTID
	, (xpath('./@OPERSTATUS', c.node))[1]::varchar::int AS OPERSTATUS
	, TO_DATE((xpath('./@STARTDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS STARTDATE
	, TO_DATE((xpath('./@ENDDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS ENDDATE
	, (xpath('./@NORMDOC', c.node))[1] AS NORMDOC
	, (xpath('./@LIVESTATUS', c.node))[1]::varchar::LIVESTATUSENUM AS LIVESTATUS
	, (xpath('./@CADNUM', c.node))[1] AS CADNUM
	, (xpath('./@DIVTYPE', c.node))[1]::varchar::DIVTYPEENUM AS DIVTYPE
FROM  (             
    SELECT unnest(xpath('./Stead', x)) AS node
    FROM tmp
    ) c;