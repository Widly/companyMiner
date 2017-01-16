INSERT INTO AddressObjectType
	SELECT (xpath('./@LEVEL', x))[1]::varchar::int AS LEVEL
	, (xpath('./@SCNAME', x))[1] AS SCNAME
	, (xpath('./@SOCRNAME', x))[1] AS SOCRNAME
	, (xpath('./@KOD_T_ST', x))[1] AS KOD_T_ST
FROM unnest(xpath('./AddressObjectType', 
    	convert_from(bytea_import('fias_xml/SOCRBASE.XML'), 'UTF8')::xml)) x;