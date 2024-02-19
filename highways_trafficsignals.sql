SELECT
    n.osm_id,
    n.highway,
	n.tags -> 'traffic_signals',
	n.tags -> 'traffic_signals:direction' AS signal_direction,
	n.tags -> 'traffic_signals:foot' AS signal_foot,
	n.tags -> 'traffic_signals:arrow' AS signal_arrow,
	st_setsrid(n.way, 3857) as geom
FROM
    planet_osm_point n
        JOIN
    vg250_gen_transformed g ON ST_Contains(
            g.transformed_geom,
            st_setsrid(n.way, 3857)
                               )
WHERE
    n.highway = 'traffic_signals' AND
    g."GEN" = 'Leipzig';
