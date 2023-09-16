--standalone query
SELECT 
	COUNT(lwIngestLocation) AS locationYearSurveyCount
	,date_part('year', lwIngestDate) AS surveyYear
	,lwIngestLocation AS surveyLocation
FROM loonWatch_ingest lwi
--WHERE date_part('year', lwi.lwIngestDate)=date_part('year', li.lwIngestDate) AND lwi.lwIngestLocation=li.lwIngestLocation
WHERE date_part('year', lwIngestDate)=2011 AND lwIngestLocation='Beaver'
GROUP BY date_part('year', lwIngestDate), lwIngestLocation 
ORDER BY lwIngestLocation, date_part('year', lwIngestDate)

--sub query
SELECT lwIngestLocation AS surveyLocation, date_part('year', li.lwIngestDate) AS surveyYear,
(
	SELECT COUNT(lwIngestLocation) AS surveyCount
	FROM loonWatch_ingest lwi
	WHERE date_part('year', lwi.lwIngestDate)=date_part('year', li.lwIngestDate) AND lwi.lwIngestLocation=li.lwIngestLocation
	GROUP BY date_part('year', lwIngestDate), lwIngestLocation 
	ORDER BY lwIngestLocation, date_part('year', lwIngestDate)
) AS surveyCount
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
