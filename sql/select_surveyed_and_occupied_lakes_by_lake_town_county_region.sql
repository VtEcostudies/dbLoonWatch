SELECT wbRegion AS "regionName", "countyName", "townName", wbFullName, locationName, wbArea,
(SELECT MAX(DATE_PART('YEAR', lwIngestDate)) AS "lastOccupied"
	FROM loonwatch_ingest
	WHERE lwIngestLocation=locationName
	AND (COALESCE(lwIngestAdult,0)+COALESCE(lwIngestSubAdult,0)+COALESCE(lwIngestChick,0))>0
	GROUP BY lwIngestLocation),
(ARRAY (SELECT DATE_PART('YEAR', lwIngestDate) AS Year
	FROM loonwatch_ingest
	WHERE lwIngestLocation=locationName
	AND (COALESCE(lwIngestAdult,0)+COALESCE(lwIngestSubAdult,0)+COALESCE(lwIngestChick,0))>0
	GROUP BY lwIngestLocation, lwIngestDate)) AS Occupied,
(SELECT MAX(DATE_PART('YEAR', lwIngestDate)) AS "lastSurveyed"
	FROM loonwatch_ingest
	WHERE lwIngestLocation=locationName
	GROUP BY lwIngestLocation),
(ARRAY (SELECT DATE_PART('YEAR', lwIngestDate) AS Year
	FROM loonwatch_ingest
	WHERE lwIngestLocation=locationName
	GROUP BY lwIngestLocation, lwIngestDate)) AS Surveyed
FROM vt_water_body wb
FULL JOIN vt_loon_locations ll on ll.waterBodyId=wb.wbTextId
FULL JOIN loonWatch_ingest li ON ll.locationName=li.lwingestlocation
FULL JOIN vt_town on wbTownName="townName"
JOIN vt_county ON "govCountyId"="townCountyId"
/*
FROM loonwatch_ingest li
JOIN vt_loon_locations ll on ll.locationName=li.lwingestlocation
JOIN vt_water_body wb ON wb.wbTextId=ll.waterBodyId
JOIN vt_town on ll.locationTownId="townId"
JOIN vt_county ON "govCountyId"="townCountyId"
*/
--WHERE locationName LIKE 'Memphremagog'
--WHERE "townName" = 'Derby'
--WHERE "countyName" = 'Orleans'
--WHERE wbRegion LIKE 'North%'
GROUP BY wbRegion, "countyName", "townName", wbfullName, locationName, wbArea