SELECT
    n.osm_id,
    n.highway,
    n.bicycle,
    n.foot,
    n.oneway,
    n.surface,
    n.tags -> 'smoothness' AS smoothness,
    n.tags -> 'traffic_sign' AS traffic_sign,
    n.tags -> 'cycleway' AS cycleway,
    n.tags -> 'cycleway:right' AS "cycleway:right",
    n.tags -> 'cycleway:left' AS "cycleway:left",
    n.tags -> 'cycleway:both' AS "cycleway:both",
    n.tags -> 'cyclestreet' AS cyclestreet,
    n.tags -> 'bicycle_road' AS bicycle_road,
    n.tags -> 'is_sidepath' AS is_sidepath,
    n.tags -> 'maxspeed' AS maxspeed,
    st_setsrid(n.way, 3857) as geom
FROM
    planet_osm_line n
        JOIN
    vg250_gen_transformed g ON ST_Contains(
            g.transformed_geom,
            st_setsrid(n.way, 3857)
                               )
WHERE
    n.highway IS NOT NULL AND
    --hier beliebigen Gemeindenamen eingeben
    g."GEN" = 'Leipzig';
