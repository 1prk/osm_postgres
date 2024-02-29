SELECT
    a.id,
    unnested.node_id,
    b.osm_id as way_id,
    c.id,
    ST_SetSrid(ST_MakePoint(c.lon, c.lat),3857) as geom
FROM
    planet_osm_ways a
LEFT JOIN
    LATERAL unnest(a.nodes) AS unnested(node_id) ON true
LEFT JOIN
    planet_osm_line b ON a.id = b.osm_id
LEFT JOIN
    planet_osm_nodes c ON unnested.node_id = c.id
WHERE b.osm_id IN ('88027717');
