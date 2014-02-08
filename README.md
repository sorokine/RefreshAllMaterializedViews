RefreshAllMaterializedViews
===========================

Function to refresh all materialized views in a PostgreSQL 9.3 database.

PostgreSQL 9.3 supports materialized views but does not have a functionality 
to refresh the views except for issuing refresh command for each view 
individually.  After asking on stackoverflow and not finding solution 
(http://stackoverflow.com/questions/19981600/how-to-refresh-all-materialized-views-in-postgresql-9-3-at-once) 
I decided to write my own function.

Usage
-----

To refresh views in `public` schema:
```
select RefreshAllMaterializedViews()
```

To refresh views in other schema:
```
select RefreshAllMaterializedViews('my_schema');
```
