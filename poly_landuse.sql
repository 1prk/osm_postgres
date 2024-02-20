SELECT
    n.osm_id,
    n.landuse,
    st_setsrid(n.way, 3857) as geom
FROM
    planet_osm_polygon n
JOIN
    vg250_gen_transformed g
ON
    ST_Contains(
        g.transformed_geom,
        st_setsrid(n.way, 3857)
    )
WHERE
    g."GEN" IN ('Berlin', 'Bremen', 'Erfurt', 'Kempten', 'Münster', 'Landshut', 'Fürstenfeldbruck') AND
    n.landuse IS NOT NULL;
