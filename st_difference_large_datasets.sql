-------------------------------------------
# st_difference for large tables
# keep_table: the table you want to retain
# blade_table: the table used to cut out
-------------------------------------------

SELECT ST_Multi(COALESCE(
         ST_Difference(kt.geom, blade.geom),
         kt.geom
       )) AS geom
FROM   keep_table kt
CROSS JOIN LATERAL (
  SELECT ST_Union(bt.geom) AS geom
  FROM   blade_table AS bt
  WHERE  ST_Intersects(kt.geom, bt.geom) 
) AS blade
;
