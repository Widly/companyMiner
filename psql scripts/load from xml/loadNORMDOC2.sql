INSERT INTO NormativeDocument
	SELECT (xpath('./@NORMDOCID', x))[1] AS NORMDOCID
     , (xpath('./@DOCNAME', x))[1] AS DOCNAME
     ,TO_DATE((xpath('./@DOCDATE', x))[1]::varchar, 'YYYY-MM-DD')  AS DOCDATE
     , (xpath('./@DOCNUM', x))[1] AS DOCNUM
     , (xpath('./@DOCTYPE', x))[1]::varchar::int AS DOCTYPE
     , (xpath('./@DOCIMGID', x))[1]::varchar::int AS DOCIMGID
FROM unnest(xpath('./NormativeDocument', 
    	convert_from(bytea_import('fias_xml/NORMDOC.XML'), 'UTF8')::xml)) x;