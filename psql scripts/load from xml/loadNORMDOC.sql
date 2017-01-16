CREATE TEMP TABLE tmp (x xml);

COPY tmp (x) FROM '/home/igor/Документы/fias_xml/NORMDOC.XML';

INSERT INTO NormativeDocument
	SELECT (xpath('./@NORMDOCID', c.node))[1] AS NORMDOCID
     , (xpath('./@DOCNAME', c.node))[1] AS DOCNAME
     ,TO_DATE((xpath('./@DOCDATE', c.node))[1]::varchar, 'YYYY-MM-DD')  AS DOCDATE
     , (xpath('./@DOCNUM', c.node))[1] AS DOCNUM
     , (xpath('./@DOCTYPE', c.node))[1]::varchar::int AS DOCTYPE
     , (xpath('./@DOCIMGID', c.node))[1]::varchar::int AS DOCIMGID
FROM  (             
    SELECT unnest(xpath('./NormativeDocument', x)) AS node
    FROM tmp
    ) c;