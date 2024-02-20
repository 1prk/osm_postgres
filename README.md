# OSM-Postgres

Hier werden nützliche Queries zur Abfrage in QGIS (oder in DBMS) gesammelt.

## Zugangsdaten

Siehe E-Mail vom 01.02.2024. Ansonsten lieb bei Teams fragen :)

## Aufbau der OSM-Datenbank

Die relevantesten Tabellen der OSM-Daten:

- Punkte (Nodes mit Attributen): `planet_osm_point`
- Linienelemente: `planet_osm_line`
- Polygone: `planet_osm_polygon`

- Nodes (nur OSM-ID mit Koordinaten): `planet_osm_nodes` 
- Ways: `planet_osm_ways`
- Relationen: `planet_osm_rels`

- Gemeindedaten: `vg250_gem`

Die Geometrien sind unter der Spalte `way` im WKB-Format `EPSG:4326` hinterlegt. Die Geometrie lässt sich mit `ST_AsText(way)` ins WKT-Format umwandeln.

Zur Auflistung aller Spalten einer Datenbank, nutze:

```
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = '[TABELLENNAME]';
```

## OSM-Tags auswählen und verwenden

Erfahrungsgemäß ist das Abrufen aller OSM-Daten mit allen Spalten rechen- und speicherintensiv.
Viele Tags werden demnach im HStore-Format unter der Spalte `tags` abgelegt. Veranschaulicht wird das an folgendem Beispiel:

```
traffic_signals=signal
traffic_sign=DE:240
lane:width=3,5
```


Im HStore-Format sehen die Key-Value-Paare wie folgt aus:

`traffic_signals => signal; traffic_sign => DE:240; lane:width => 3,5`

Einzelnte kv-Paare ruft man wie folgt mit PostgreSQL ab - im folgenden Beispiel für alle Straßen:

```
SELECT
    l.osm_id,
    l.highway,
    l.way,
    l.tags -> 'traffic_signals' AS traffic_signals,
    l.tags -> 'traffic_sign' AS traffic_sign
    l.tags -> 'lane:width' AS lane_width
FROM
planet_osm_line
LIMIT 10;
```


## OSM-Daten innerhalb einer bounding box abrufen

Die Abfragen sind mit den Gemeindeshapefiles (vg250_gem) verknüpft. Zuerst wird um eine Gemeinde eine Bounding-Box aufgespannt und als Materialized View separat abgespeichert. Darauf baut die Abfrage auf, indem alle OSM-Features abgefragt werden, die sich innerhalb einer bestimmten Bounding Box befinden.

Um Daten für eine Gemeinde abzurufen, wird folgendes Statement am Schluss einer Query verwendet:

`WHERE g."GEN" = 'Dresden';`

Für mehrere Gemeinden erfolgt die Abfrage so:

`WHERE g."GEN" IN ('Dresden', 'Leipzig', '...');`

Bei der Nutzung von amtiliche Regionalschlüsseln:

`WHERE g."ARS" IN ('874219409', '23081847')`
