SELECT 

    w.osm_id,
    w.highway,
    st_setsrid(w.way, 3857) as geom,
    n.id as relation_id,
    rel_ways,
	n.tags::hstore -> 'name' as "name",
	n.tags::hstore -> 'network:type' as "network:type",
	n.tags::hstore -> 'type' as "type",
	n.tags::hstore -> 'route' as "route",
	n.tags::hstore -> 'network' as "network",
	n.tags::hstore -> 'cycle_network' as "cycle:network",
	n.tags::hstore -> 'roundtrip' as "roundtrip",
	n.tags::hstore -> 'note' as "note",
	n.tags::hstore -> 'ref' as "ref"
FROM 

    planet_osm_rels n
CROSS JOIN LATERAL
    unnest(n.parts) AS rel_ways

LEFT JOIN
    planet_osm_line w ON rel_ways = w.osm_id
JOIN 
	vg250_gen_transformed g ON 
	st_contains(g.gemeindegrenzen, st_setsrid(w.way, 3857))

WHERE 
	(g."GEN" IN ('Bietigheim-Bissingen', 'Cottbus', 'Dresden',
     'Eschborn', 'Freiburg im Breisgau', 'Freising',
      'Leipzig', 'Offenburg', 'Wedel', 'Weimar')
	OR g."ARS" LIKE '03354%') -- ARS für LK Lüchow-Dannenberg


	AND 'bicycle'=ANY(n.tags)
	AND n.tags::hstore -> 'route' = 'bicycle';
