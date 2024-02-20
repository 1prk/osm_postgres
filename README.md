# OSM-Postgres

Hier werden nützliche Queries zur Abfrage in QGIS (oder in DBMS) gesammelt.

## Zugangsdaten

Siehe E-Mail vom 01.02.2024. Ansonsten lieb bei Teams fragen :)


## OSM-Daten innerhalb einer bounding box abrufen

Die Abfragen sind mit den Gemeindeshapefiles (vg250_gem) verknüpft. Zuerst wird um eine Gemeinde eine Bounding-Box aufgespannt und als Materialized View separat abgespeichert. Darauf baut die Abfrage auf, indem alle OSM-Features abgefragt werden, die sich innerhalb einer bestimmten Bounding Box befinden.

Um Daten für eine Gemeinde abzurufen, wird folgendes Statement am Schluss einer Query verwendet:

`WHERE g."GEN" = 'Dresden';`

Für mehrere Gemeinden erfolgt die Abfrage so:

`WHERE g."GEN" IN ('Dresden', 'Leipzig', '...');`

Bei der Nutzung von amtiliche Regionalschlüsseln:

`WHERE g."ARS" IN ('874219409', '23081847')`
