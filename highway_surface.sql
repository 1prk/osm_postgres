SELECT
    n.osm_id,
    n.surface,
    n.tags -> 'smoothness' AS smoothness,
    n.tags -> 'sidewalk:both:surface' AS "sidewalk:both:surface",
    n.tags -> 'cycleway:surface' AS "cycleway:surface",
    n.tags -> 'footway:surface' AS "footway:surface",
    n.tags -> 'sidewalk:right:surface' AS "sidewalk:right:surface",
    n.tags -> 'sidewalk:left:surface' AS "sidewalk:left:surface",
    n.tags -> 'cycleway:right:surface' AS "cycleway:right:surface",
    n.tags -> 'sidewalk:surface' AS "sidewalk:surface",
    n.tags -> 'shoulder:surface' AS "shoulder:surface",
    n.tags -> 'cycleway:left:surface' AS "cycleway:left:surface",
    n.tags -> 'cycleway:both:surface' AS "cycleway:both:surface",
    n.tags -> 'footway:right:surface' AS "footway:right:surface",
    n.tags -> 'footway:left:surface' AS "footway:left:surface",
    n.tags -> 'parking:right:surface' AS "parking:right:surface",
    n.tags -> 'shoulder:right:surface' AS "shoulder:right:surface",
    n.tags -> 'parking:both:surface' AS "parking:both:surface",
    n.tags -> 'footway:both:surface' AS "footway:both:surface",
    n.tags -> 'parking:left:surface' AS "parking:left:surface",
    n.tags -> 'parking:lane:right:surface' AS "parking:lane:right:surface",
    n.tags -> 'parking:lane:left:surface' AS "parking:lane:left:surface",
    n.tags -> 'bicycle:surface' AS "bicycle:surface",
    n.tags -> 'bus_bay:right:surface' AS "bus_bay:right:surface",
    n.tags -> 'bus_bay:left:surface' AS "bus_bay:left:surface",
    n.tags -> 'bus_bay:surface' AS "bus_bay:surface",
    n.tags -> 'shoulder:left:surface' AS "shoulder:left:surface",
    n.tags -> 'parking:lane:both:surface' AS "parking:lane:both:surface",

	
    st_setsrid(n.way, 3857) as geom
FROM
    planet_osm_line n
        JOIN
    vg250_gen_transformed g ON ST_Contains(
            g.gemeindegrenzen,
            st_setsrid(n.way, 3857)
                               )
WHERE
    (
	n.tags ? 'smoothness' OR
    n.tags ? 'sidewalk:both:surface' OR
    n.tags ? 'cycleway:surface' OR
    n.tags ? 'footway:surface' OR
    n.tags ? 'sidewalk:right:surface' OR
    n.tags ? 'sidewalk:left:surface' OR
    n.tags ? 'cycleway:right:surface' OR
    n.tags ? 'sidewalk:surface' OR
    n.tags ? 'shoulder:surface' OR
    n.tags ? 'cycleway:left:surface' OR
    n.tags ? 'cycleway:both:surface' OR
    n.tags ? 'footway:right:surface' OR
    n.tags ? 'footway:left:surface' OR
    n.tags ? 'parking:right:surface' OR
    n.tags ? 'shoulder:right:surface' OR
    n.tags ? 'parking:both:surface' OR
    n.tags ? 'footway:both:surface' OR
    n.tags ? 'parking:left:surface' OR
    n.tags ? 'parking:lane:right:surface' OR
    n.tags ? 'parking:lane:left:surface' OR
    n.tags ? 'bicycle:surface' OR
    n.tags ? 'bus_bay:right:surface' OR
    n.tags ? 'bus_bay:left:surface' OR
    n.tags ? 'bus_bay:surface' OR
    n.tags ? 'shoulder:left:surface' OR
    n.tags ? 'parking:lane:both:surface')
	AND n.highway IS NOT NULL AND
    g."GEN" = 'Leipzig';
