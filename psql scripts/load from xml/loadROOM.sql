CREATE TEMP TABLE tmp (x xml);
INSERT INTO tmp VALUES (
    XMLPARSE(DOCUMENT convert_from(
        pg_read_binary_file('fias_xml/ROOM.XML'), 'UTF8'))

);

INSERT INTO Room
	SELECT (xpath('./@ROOMGUID', c.node))[1] AS ROOMGUID
    , (xpath('./@FLATNUMBER', c.node))[1] AS FLATNUMBER
    , (xpath('./@FLATTYPE', c.node))[1]::varchar::int AS FLATNUMBER
    , (xpath('./@ROOMNUMBER', c.node))[1] AS ROOMNUMBER
    , (xpath('./@ROOMTYPE', c.node))[1]::varchar::int AS ROOMTYPE
    , (xpath('./@REGIONCODE', c.node))[1] AS REGIONCODE
    , (xpath('./@POSTALCODE', c.node))[1] AS POSTALCODE
    , TO_DATE((xpath('./@UPDATEDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS UPDATEDATE
    , (xpath('./@HOUSEGUID', c.node))[1] AS HOUSEGUID
    , (xpath('./@ROOMID', c.node))[1] AS ROOMID
    , (xpath('./@PREVID', c.node))[1] AS PREVID
    , (xpath('./@NEXTID', c.node))[1] AS NEXTID
    , TO_DATE((xpath('./@STARTDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS STARTDATE
    , TO_DATE((xpath('./@ENDDATE', c.node))[1]::varchar, 'YYYY-MM-DD') AS ENDDATE
    , (xpath('./@LIVESTATUS', c.node))[1]::varchar::LIVESTATUSENUM AS LIVESTATUS
    , (xpath('./@NORMDOC', c.node))[1] AS NORMDOC
    , (xpath('./@OPERSTATUS', c.node))[1]::varchar::int AS OPERSTATUS
    , (xpath('./@CADNUM', c.node))[1] AS CADNUM
    , (xpath('./@ROOMCADNUM', c.node))[1] AS ROOMCADNUM
FROM  (             
    SELECT unnest(xpath('./Room', x)) AS node
    FROM tmp
    ) c;

