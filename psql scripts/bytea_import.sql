CREATE OR REPLACE FUNCTION bytea_import(p_path text, p_result out bytea) 
                   language plpgsql as $$
DECLARE
  l_oid oid;
  r record;
BEGIN
  p_result := '';
  SELECT lo_import(p_path) INTO l_oid;
  FOR r IN ( SELECT data 
             FROM pg_largeobject 
             WHERE loid = l_oid 
             ORDER BY pageno ) loop
    p_result = p_result || r.data;
  END loop;
  PERFORM lo_unlink(l_oid);
END;$$;