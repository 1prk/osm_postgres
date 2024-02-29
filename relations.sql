SELECT 

    w.osm_id,
	w.highway,
    st_setsrid(w.way, 3857) as geom,
    n.id as relation_id,
    rel_ways,
    n.tags::hstore

FROM 

    planet_osm_rels n
CROSS JOIN LATERAL
    unnest(n.parts) AS rel_ways

LEFT JOIN
    planet_osm_line w ON rel_ways = w.osm_id
JOIN 
	vg250_gen_transformed g ON 
	st_contains(g.transformed_geom, st_setsrid(w.way, 3857))

WHERE 
	g."GEN" = 'Dresden'

	AND 'bicycle'=ANY(n.tags)
