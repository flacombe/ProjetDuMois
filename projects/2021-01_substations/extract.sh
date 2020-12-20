#!/bin/bash

# Production du csv
rm -f /data/files/pdm/extracts/substations.csv
psql -d $DB_URL -c "COPY (select osm_id, ST_X(St_Transform(ST_Centroid(geom), 4326)) AS lng, St_Y(St_Transform(ST_Centroid(geom), 4326)) AS lat, tags->>'power' AS power, tags->>'operator' AS operator, COALESCE(tags->>'substation','minor_distribution') AS substation, COALESCE(tags->>'voltage', tags->>'voltage:primary') AS voltage, COALESCE(tags->>'design:ref', CASE tags->>'power' WHEN 'pole' THEN 'H6' ELSE NULL END) AS design, tags->>'ref' AS ref_terrain, tags->>'ref:FR:gdo' AS gdo, tags->>'name' AS name FROM pdm_project_substations) TO STDOUT DELIMITER ',' CSV HEADER" > /data/files/pdm/extracts/substations.csv
