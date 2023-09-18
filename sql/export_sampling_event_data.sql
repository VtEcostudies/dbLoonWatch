COPY 
--CREATE TABLE loonwatch_sampling_event AS
(
SELECT
--date_part('year', lwIngestDate) || '-' || lwIngestLocation || '-' || COALESCE(lwIngestStart, '00:00:00') AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || UPPER(locationName) --waterBodyId is not Unique to loonLocations, which are. Must use loonLocation to create UNIQUE eventID.
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
/*
(
	SELECT COUNT(lwIngestLocation)
	FROM loonWatch_ingest lwi
	WHERE date_part('year', lwi.lwIngestDate)=date_part('year', li.lwIngestDate) AND lwi.lwIngestLocation=li.lwIngestLocation
	GROUP BY date_part('year', lwIngestDate), lwIngestLocation 
	ORDER BY lwIngestLocation, date_part('year', lwIngestDate)
) AS "surveyYearLocationCount",
row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation 
   ORDER BY date_part('year', lwIngestDate), lwIngestLocation ) AS "surveyYearLocationIter",
*/
'Area Survey' AS "samplingProtocol",
'Observer Time' AS "samplingEffort",
locationArea AS "sampleSizeValue",
'Acre' AS "sampleSizeUnit",
lwIngestDate AS "eventDate",
date_part('year', lwIngestDate) AS "year",
date_part('month', lwIngestDate) AS "month",
date_part('day', lwIngestDate) AS "day",
--lwIngestStart || '/' || lwIngestStop AS "eventTime", --this expression is NULL if either value is NULL
CASE WHEN lwIngestStart IS NOT NULL THEN
	CASE WHEN lwIngestStop IS NOT NULL THEN
			lwIngestStart::TEXT || '/' || lwIngestStop::TEXT
		ELSE 
			lwIngestStart::TEXT
		END
	END AS "eventTime",
EXTRACT(DOY FROM lwIngestDate) AS "startDayOfYear",
'United States of America' AS "country",
'USA' AS "countryCode",
'Vermont' AS "stateProvince",
"countyName" AS "county",
locationTown AS "municipality",
waterBodyId AS "locationID",
waterBodyId AS "waterBody",
wbCenterLatitude AS "decimalLatitude",
wbCenterLongitude AS "decimalLongitude",
'WGS84' AS "geodeticDatum",
10 AS "coordinateUncertaintyInMeters",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode",
lwIngestComment AS "eventRemarks"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
INNER JOIN vt_town ON locationTownId="townId"
INNER JOIN vt_county ON "townCountyId"="govCountyId"
) 
TO 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_export\loonwatch_sampling_event.csv' delimiter ',' csv header;

COPY (
SELECT
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
	|| '-Ad'
AS "occurrenceID",
'HumanObservation' AS "basisOfRecord",
lwIngestObserverName AS "recordedBy",
lwIngestAdult AS "individualCount",
'Adult' AS "lifeStage",
'Present' AS "occurrenceStatus",
'Gavia immer' AS "scientificName",
'Animalia' AS "kingdom",
'Chordata' AS "phylum",
'Aves' AS "class",
'Gaviiformes' AS "order",
'Gaviidae' AS "family",
'Species' AS "taxonRank",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
WHERE lwIngestAdult > 0

UNION

SELECT
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
	|| '-SA'
AS "occurrenceID",
'HumanObservation' AS "basisOfRecord",
lwIngestObserverName AS "recordedBy",
lwIngestSubAdult AS "individualCount",
'SubAdult' AS "lifeStage",
'Present' AS "occurrenceStatus",
'Gavia immer' AS "scientificName",
'Animalia' AS "kingdom",
'Chordata' AS "phylum",
'Aves' AS "class",
'Gaviiformes' AS "order",
'Gaviidae' AS "family",
'Species' AS "taxonRank",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
WHERE lwIngestSubAdult > 0

UNION

SELECT
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
	|| '-Ch'
AS "occurrenceID",
'HumanObservation' AS "basisOfRecord",
lwIngestObserverName AS "recordedBy",
lwIngestChick AS "individualCount",
'Chick' AS "lifeStage",
'Present' AS "occurrenceStatus",
'Gavia immer' AS "scientificName",
'Animalia' AS "kingdom",
'Chordata' AS "phylum",
'Aves' AS "class",
'Gaviiformes' AS "order",
'Gaviidae' AS "family",
'Species' AS "taxonRank",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
WHERE lwIngestChick > 0

UNION

SELECT
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || waterBodyId
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
	|| '-00'
AS "occurrenceID",
'HumanObservation' AS "basisOfRecord",
lwIngestObserverName AS "recordedBy",
0 AS "individualCount",
NULL AS "lifeStage",
'Absent' AS "occurrenceStatus",
'Gavia immer' AS "scientificName",
'Animalia' AS "kingdom",
'Chordata' AS "phylum",
'Aves' AS "class",
'Gaviiformes' AS "order",
'Gaviidae' AS "family",
'Species' AS "taxonRank",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
WHERE COALESCE(lwIngestAdult, 0)=0 AND COALESCE(lwIngestSubAdult, 0)=0 AND COALESCE(lwIngestChick, 0)=0
)
TO 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_export\loonwatch_sampling_occurrence.csv' delimiter ',' csv header;
