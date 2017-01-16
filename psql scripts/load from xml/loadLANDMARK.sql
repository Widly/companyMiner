CREATE TEMP TABLE tmp (x xml);
INSERT INTO tmp VALUES (
    XMLPARSE(DOCUMENT convert_from(
        pg_read_binary_file('fias_xml/LANDMARK.XML'), 'UTF8'))

);

INSERT INTO Landmark (LOCATION, POSTALCODE, IFNSFL, TERRIFNSFL, INFSUL, TERRIFNSUL, 
	OKATO, OKTMO, UPDATEDATE, LANDID, LANDGUID, AOGUID, STARTDATE, ENDDATE, NORMDOC)

SELECT (xpath('./@LOCATION', c.node))[1] AS LOCATION
	,(xpath('./@POSTALCODE', c.node))[1] AS POSTALCODE
	,(xpath('./@IFNSFL', c.node))[1] AS IFNSFL
	,(xpath('./@TERRIFNSFL', c.node))[1] AS TERRIFNSFL
	,(xpath('./@INFSUL', c.node))[1] AS INFSUL
	,(xpath('./@TERRIFNSUL', c.node))[1] AS TERRIFNSUL
	,(xpath('./@OKATO', c.node))[1] AS OKATO
	,(xpath('./@OKTMO', c.node))[1] AS OKTMO
	,TO_DATE((xpath('./@UPDATEDATE', c.node))[1]::varchar, 'YYYY-MM-DD')  AS UPDATEDATE
	,(xpath('./@LANDID', c.node))[1] AS UPDATEDATE
	,(xpath('./@LANDGUID', c.node))[1] AS LANDGUID
	,(xpath('./@AOGUID', c.node))[1] AS AOGUID
	,TO_DATE((xpath('./@STARTDATE', c.node))[1]::varchar, 'YYYY-MM-DD')  AS STARTDATE
	,TO_DATE((xpath('./@ENDDATE', c.node))[1]::varchar, 'YYYY-MM-DD')  AS ENDDATE
	,(xpath('./@NORMDOC', c.node))[1] AS NORMDOC
FROM  (             
    SELECT unnest(xpath('./Landmark', x)) AS node
    FROM tmp
    ) c;