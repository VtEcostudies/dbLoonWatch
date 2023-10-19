SELECT locationTown,wbTextId,date_part('year',lwIngestDate) AS Year
,COALESCE(sum(lwIngestAdult),0) AS Adult
,COALESCE(sum(lwIngestSubAdult),0) AS SubAdult
,COALESCE(sum(lwIngestChick),0) AS Chick
FROM loonwatch_ingest li
JOIN vt_loon_locations ll on ll.locationName=li.lwingestlocation
JOIN vt_water_body wb ON wb.wbTextId=ll.waterBodyId
JOIN vt_town on ll.locationTownId="townId"
--WHERE vt_town."townName"='Derby'
group by ll.locationTown, wbTextId, li.lwIngestDate
order by ll.locationTown, wbTextId, li.lwIngestDate;

--Stats for a town, county, or region
--# Lakes
--# Surveyed Lakes
--# Occupied Lakes
--Surveyed Lakes by Lake/Town/County/Region with most recent survey year
SELECT wbRegion, "countyName", "townName", wbTextId, MAX(DATE_PART('YEAR', lwIngestDate)) AS Surveyed
FROM loonwatch_ingest li
JOIN vt_loon_locations ll on ll.locationName=li.lwingestlocation
JOIN vt_water_body wb ON wb.wbTextId=ll.waterBodyId
JOIN vt_town on ll.locationTownId="townId"
JOIN vt_county ON "govCountyId"="townCountyId"
--WHERE wbTextId LIKE 'MILLER%'
--WHERE "townName"='Derby'
--WHERE "countyName"='Windsor'
--WHERE wbRegion LIKE 'Champ%'
GROUP BY wbRegion,"countyName","townName",wbTextId
ORDER BY wbRegion,"countyName","townName",wbTextId;

--Occupied Lakes by Lake/Town/County/Region with most recent occupied year
SELECT wbRegion, "countyName", "townName", wbTextId, MAX(DATE_PART('YEAR', lwIngestDate)) AS Occupied
FROM loonwatch_ingest li
JOIN vt_loon_locations ll on ll.locationName=li.lwingestlocation
JOIN vt_water_body wb ON wb.wbTextId=ll.waterBodyId
JOIN vt_town on ll.locationTownId="townId"
JOIN vt_county ON "govCountyId"="townCountyId"
WHERE (COALESCE(lwIngestAdult,0)+COALESCE(lwIngestSubAdult,0)+COALESCE(lwIngestChick,0))>0
--AND wbTextId LIKE 'MILLER%'
--AND "townName"='Derby'
--AND "countyName"='Windsor'
--AND wbRegion LIKE 'Champ%'
GROUP BY wbRegion,"countyName","townName",wbTextId
ORDER BY wbRegion,"countyName","townName",wbTextId;
