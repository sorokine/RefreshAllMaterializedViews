CREATE OR REPLACE FUNCTION RefreshAllMaterializedViewsInDatabaseConcurrently()
RETURNS INT AS $$
    DECLARE
        sch VARCHAR;
        r RECORD;
    BEGIN
        RAISE NOTICE 'Refreshing all materialized views...';
        FOR sch IN SELECT schema_name FROM information_schema.schemata
        LOOP
            RAISE NOTICE 'Refreshing materialized view in schema %', sch;
            FOR r IN SELECT matviewname FROM pg_matviews WHERE schemaname = sch 
            LOOP
                RAISE NOTICE 'Refreshing %.%', sch, r.matviewname;
                EXECUTE 'REFRESH MATERIALIZED VIEW ' || sch || '.' || r.matviewname;
            END LOOP;
        END LOOP;

        RETURN 1;
    END 
$$ LANGUAGE plpgsql;
