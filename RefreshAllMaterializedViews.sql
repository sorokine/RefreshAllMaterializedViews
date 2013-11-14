--
-- function to refresh all materialized views in a schema
--

CREATE OR REPLACE FUNCTION RefreshAllMaterializedViews(schema_arg TEXT DEFAULT 'public')
RETURNS INT AS $$
	DECLARE
		r RECORD;
	BEGIN
		RAISE NOTICE 'Refreshing materialized view in schema %', schema_arg;
		FOR r IN SELECT matviewname FROM pg_matviews WHERE schemaname = schema_arg 
		LOOP
			RAISE NOTICE 'Refreshing %.%', schema_arg, r.matviewname;
			EXECUTE 'REFRESH MATERIALIZED VIEW ' || schema_arg || '.' || r.matviewname; 
		END LOOP;
		
		RETURN 1;
	END 
$$ LANGUAGE plpgsql;
