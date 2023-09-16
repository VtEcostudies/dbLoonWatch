--COPY 
(
SELECT
--date_part('year', lwIngestDate) || '-' || lwIngestLocation || '-' || COALESCE(lwIngestStart, '00:00:00') AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || lwIngestLocation 
	|| '-' || row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation ORDER BY date_part('year', lwIngestDate), lwIngestLocation)
AS "eventID",
(
	SELECT COUNT(lwIngestLocation)
	FROM loonWatch_ingest lwi
	WHERE date_part('year', lwi.lwIngestDate)=date_part('year', li.lwIngestDate) AND lwi.lwIngestLocation=li.lwIngestLocation
	GROUP BY date_part('year', lwIngestDate), lwIngestLocation 
	ORDER BY lwIngestLocation, date_part('year', lwIngestDate)
) AS "surveyYearLocationCount",
row_number() OVER (PARTITION BY date_part('year', li.lwIngestDate), lwIngestLocation 
   ORDER BY date_part('year', lwIngestDate), lwIngestLocation ) AS "surveyYearLocationIter",
'Area Survey' AS "samplingProtocol",
'Observer Time' AS "samplingEffort",
locationArea AS "sampleSizeValue",
'Acre' AS "sampleSizeUnit",
lwIngestDate AS "eventDate",
lwIngestStart || '/' || lwIngestStop AS "eventTime",
EXTRACT(DOY FROM lwIngestDate) AS "startDayOfYear",
'United States of America' AS "country",
'USA' AS "countryCode",
locationTown AS "locality",
waterBodyId AS "locationID",
wbCenterLatitude AS "decimalLatitude",
wbCenterLongitude AS "decimalLongitude",
'WGS94' AS "geodeticDatum",
10 AS "coordinateUncertaintyInMeters",
'Event' AS "type",
'VCE' AS "ownerInstitutionCode",
lwIngestComment AS "eventRemarks"
FROM loonWatch_ingest li
INNER JOIN vt_loon_locations ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=waterBodyId
) 
--TO 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_export\loonwatch_sampling_event.csv' delimiter ',' csv header;
/*
COPY (
SELECT
eventID
occurrenceID
basisOfRecord
recordedBy
individualCount
organismQuantity
organismQuantityType
occurrenceStatus
scientificName
kingdom
phylum
class
order
family
infraspecificEpithet
taxonRank
type
ownerInstitutionCode
lwIngestLocation AS "",
lwIngestObserverName AS "observerName",
	
FROM loonWatch_ingest li
INNER JOIN vt_loon_location ll ON locationName=lwIngestLocation
INNER JOIN vt_water_body wb ON wbTextId=lw.waterBodyId
)
TO 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_export\loonwatch_sampling_event.csv' delimiter ',' csv header;
*/