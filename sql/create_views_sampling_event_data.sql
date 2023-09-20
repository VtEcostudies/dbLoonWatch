CREATE OR REPLACE VIEW loonwatch_sampling_event AS
SELECT
date_part('year', lwIngestDate) 
--NOTE: if you change eventID formula here, you MUST copy that to occurrence eventIDs and occurrenceIDs in loonwatch_sampling_occurrences
--waterBodyId is not Unique to loonLocation. Created exportName in vt_loon_locations to handle that.
	--|| '-' || waterBodyId
	--|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), waterBodyId ORDER BY date_part('year', lwIngestDate), waterBodyId)
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
AS "eventID",
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
ORDER BY "eventID";
--test for uniqueness
select "eventID", count("eventID") from loonwatch_sampling_event
group by "eventID"
having count("eventID")>1;

CREATE OR REPLACE VIEW loonwatch_sampling_occurrence AS
SELECT * FROM (
SELECT
date_part('year', lwIngestDate) 
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
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
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
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
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
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
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
AS "eventID",
date_part('year', lwIngestDate) 
	|| '-' || UPPER(exportName)
	|| '-' || ROW_NUMBER() OVER (PARTITION BY date_part('year', li.lwIngestDate), exportName ORDER BY date_part('year', lwIngestDate), exportName)
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
AS occ
ORDER BY "occurrenceID";

--test for uniqueness
select "eventID", count("eventID") from loonwatch_sampling_event
group by "eventID"
having count("eventID")>1
UNION
select "occurrenceID", count("occurrenceID") from loonwatch_sampling_occurrence
group by "occurrenceID"
having count("occurrenceID")>1;
