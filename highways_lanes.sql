SELECT
    n.osm_id,
    n.highway,
    n.oneway,
	n.width,
    n.tags -> 'lanes' AS lanes,
	n.tags -> 'lanes:forward' AS lanes_forward,
	n.tags -> 'lanes:backward' AS lanes_backward,
	n.tags -> 'vehicle:lanes:forward' AS vehicle_lanes_forward,
	n.tags -> 'vehicle:lanes:backward' AS vehicle_lanes_backward,
	n.tags -> 'width:lanes:forward' AS width_lanes_forward,
	n.tags -> 'width:lanes:backward' AS width_lanes_backward,
    n.tags -> 'change:lanes' AS change_lanes,
    n.tags -> 'turn:lanes' AS turn_lanes
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
    g."GEN" = 'Leipzig';
