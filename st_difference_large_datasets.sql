SELECT ST_Multi(COALESCE(
         ST_Difference(a.geom, blade.geom),
         a.geom
       )) AS geom
FROM   table1 AS a
CROSS JOIN LATERAL (
  SELECT ST_Union(b.geom) AS geom
  FROM   table2 AS b
  WHERE  ST_Intersects(a.geom, b.geom) 
) AS blade
;
