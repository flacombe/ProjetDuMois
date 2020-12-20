#!/bin/bash

# Production du csv
rm -f /data/files/pdm/extracts/poteaux.csv
psql -d $DB_URL -c "COPY (select osm_id, ST_X(St_Transform(geom, 4326)) AS lng, St_Y(St_Transform(geom, 4326)) AS lat, tags->>'power' AS power, tags->>'operator' AS operator, tags->>'material' AS material, tags->>'location:transition' AS ras, tags->>'line_attachment' AS line_attachment, tags->>'line_management' AS line_management, tags->>'ref' AS ref_terrain, tags->>'ref:FR:Enedis' AS ref_enedis FROM pdm_project_poteaux WHERE St_geometryType(geom)='ST_Point') TO STDOUT DELIMITER ',' CSV HEADER" > /data/files/pdm/extracts/poteaux.csv
