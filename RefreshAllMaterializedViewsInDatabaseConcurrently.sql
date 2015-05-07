CREATE OR REPLACE FUNCTION RefreshMatviewsConcurrently()
RETURNS INT AS $$
    DECLARE
        matview VARCHAR;
    BEGIN
        FOR matview IN SELECT schemaname || '.' || matviewname FROM pg_matviews 
        LOOP
            RAISE NOTICE 'Refreshing %', matview;
            EXECUTE 'REFRESH MATERIALIZED VIEW CONCURRENTLY ' || matview;
        END LOOP;

        RETURN 1;
    END 
$$ LANGUAGE plpgsql;
