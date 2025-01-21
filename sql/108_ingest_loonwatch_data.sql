--loonWatch_ingest CONSTRAINTS copied here for reference
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_unique_location_date
--	UNIQUE (lwIngestLocation,lwIngestDate);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_location 
--	FOREIGN KEY (lwIngestLocation) REFERENCES vt_loon_locations (locationName);
--DISABLE CONSTRAINTS prior to ingesting a new year's data
ALTER TABLE loonWatch_ingest DISABLE TRIGGER ALL;
ALTER TABLE loonWatch_ingest ALTER COLUMN lwIngestTownName DROP NOT NULL;
--Import data using psql:
--\COPY loonWatch_ingest FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\LoonWatch_Raw_Counts_2011.csv' DELIMITER ',' CSV HEADER
--Import data with pgAdmin Query Tool. In Windows, alter folder permissions in explorer:
---Context-Menu: Properties 
---Security
---Group or user names: Edit
---Group or user names: Add
---Enter the object names to add: Everyone
---OK
SELECT * FROM loonWatch_ingest WHERE DATE_PART('year',lwIngestDate)='2007';
--DELETE FROM loonWatch_ingest WHERE DATE_PART('year',lwIngestDate)='2010';
COPY loonWatch_ingest FROM 
'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\LoonWatch_Raw_Counts_2007.csv' 
DELIMITER ',' CSV HEADER;

--Select loon locations with bad whitespace
SELECT * FROM loonWatch_ingest WHERE lwIngestLocation != TRIM(BOTH FROM lwIngestLocation);
--Fix location names having leading/trailing whitespace so they match our corrected loon_locations
UPDATE loonWatch_ingest SET lwIngestLocation=TRIM(BOTH FROM lwIngestLocation)
WHERE lwIngestLocation != TRIM(BOTH FROM lwIngestLocation);

--Fix lwIngestLocation replace double-spaces with single
SELECT * FROM loonWatch_ingest 
WHERE lwIngestLocation LIKE '%  %';
UPDATE loonWatch_ingest SET lwIngestLocation=replace(lwIngestLocation, '  ', ' ')
WHERE lwIngestLocation LIKE '%  %';

--Select Ingest Locations without town names
SELECT * FROM loonwatch_ingest 
WHERE lwIngestTownName IS NULL;

--Select ingest locations without town names that EXACT MATCH loon locations
SELECT lwIngestLocation, locationName, lwIngestTownName, locationTown, * FROM loonWatch_ingest
JOIN vt_loon_locations ON UPPER(lwIngestLocation)=UPPER(locationName)
WHERE lwIngestTownName IS NULL;

--UPDATE lwIngestTownName, lwIngestLocation for EXACT UPPERCASE MATCH lwIngestLocations:
UPDATE loonwatch_ingest 
SET lwIngestTownName=locationTown, lwIngestLocation=locationName
FROM vt_loon_locations
WHERE UPPER(lwIngestLocation)=UPPER(locationName)
AND lwIngestTownName IS NULL;

--Match location names missing towns by removing parenthetical (Townname) and matching just the leading name
SELECT 
	UPPER(SPLIT_PART(lwIngestLocation, ' (', 1)) AS "PartIngestLocation", lwIngestLocation,
	UPPER(SPLIT_PART(locationName, ' (', 1)) AS "PartLocationName", locationName,
	locationTown, lwIngestDate, * 
	FROM loonwatch_ingest 
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' (', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' (', 1))
WHERE lwIngestTownName IS NULL;
--Match location names missing towns where parenthetical (TownName) = locationTown
SELECT 
	UPPER(SPLIT_PART(lwIngestLocation, ' (', 1)) AS "PartIngestLocation", lwIngestLocation,
	UPPER(SPLIT_PART(locationName, ' (', 1)) AS "PartLocationName", locationName,
	locationTown, lwIngestDate, * 
	FROM loonwatch_ingest 
JOIN vt_loon_locations ON 
	UPPER(SPLIT_PART(locationName, ' (', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' (', 1))
	AND
	UPPER(SPLIT_PART(SPLIT_PART(lwIngestLocation, ' (', 2),')',1)) = UPPER(locationTown)
WHERE lwIngestTownName IS NULL;
--Fix ingestLocation and ingestTownName where parenthetical (TownName) = locationTown
UPDATE loonWatch_ingest
SET lwIngestLocation=locationName, lwIngestTownName=locationTown
FROM vt_loon_locations
WHERE lwIngestTownName IS NULL
AND
UPPER(SPLIT_PART(locationName, ' (', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' (', 1))
AND
UPPER(SPLIT_PART(SPLIT_PART(lwIngestLocation, ' (', 2),')',1)) = UPPER(locationTown);

--Match first space piece of location names missing towns
SELECT 
	UPPER(SPLIT_PART(lwIngestLocation, ' ', 1)) AS "PartIngestLocation", lwIngestLocation,
	UPPER(SPLIT_PART(locationName, ' ', 1)) AS "PartLocationName", locationName,
	locationTown, lwIngestDate, * 
	FROM loonwatch_ingest 
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL;

--Match first space piece location names having only one parenthetical townName in loonLocations
SELECT 
	--UPPER(SPLIT_PART(SPLIT_PART(locationName, ' (', 2),')',1)),
	UPPER(SPLIT_PART(lwIngestLocation, ' ', 1)) AS "PartIngestLocation", lwIngestLocation,
	UPPER(SPLIT_PART(locationName, ' ', 1)) AS "PartLocationName", locationName,
	locationTown, lwIngestDate, * 
	FROM loonwatch_ingest 
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(SPLIT_PART(locationName, ' (', 2),')',1)) != '';

--OK this is ridiculous, trying to match historical ingestName to current locationName and add town from data
--Just do this manually:
--Charleston
SELECT lwIngestLocation, lwIngestDate, locationName, locationTown, waterBodyId FROM loonwatch_ingest
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='CHARLESTON';
--1 result: 
UPDATE loonWatch_ingest SET 
lwIngestLocation='Charleston (Charleston)', lwIngestTownName='Charleston'
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='CHARLESTON';
--Daniels
SELECT lwIngestLocation, lwIngestDate, locationName, locationTown, waterBodyId FROM loonwatch_ingest
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='DANIELS';
--2 results: Daniels Pond and Daniels - West (Rodgers). Pick one: Daniels Pond
UPDATE loonWatch_ingest SET 
lwIngestLocation='Daniels Pond', lwIngestTownName='Glover'
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='DANIELS';
--Amherst
SELECT lwIngestLocation, lwIngestDate, locationName, locationTown, waterBodyId FROM loonwatch_ingest
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='AMHERST';
--1 result: 
UPDATE loonWatch_ingest SET 
lwIngestLocation='Amherst (Plymouth)', lwIngestTownName='Plymouth'
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='AMHERST';
--Baker
SELECT lwIngestLocation, lwIngestDate, locationName, locationTown, waterBodyId FROM loonwatch_ingest
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='BAKER';
--2 results: Baker (Brookfield) and Baker (Barton) 
--UPDATE loonWatch_ingest SET 
lwIngestLocation='Baker (Brookfield)', lwIngestTownName='Brookfield'
WHERE lwIngestTownName IS NULL
AND UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))='BAKER';
--Fix Silver (barnard) -> Silver (Barnard)
SELECT * FROM loonWatch_ingest WHERE lwIngestLocation='Silver (barnard)';
--UPDATE loonWatch_ingest SET 
lwIngestLocation='Silver (Barnard)'
WHERE lwIngestLocation='Silver (barnard)';


select * from vt_town where "townName" like 'Unk%';

ALTER TABLE loonWatch_ingest ALTER COLUMN lwIngestTownName SET NOT NULL;
ALTER TABLE loonWatch_ingest ENABLE TRIGGER ALL;

select * from loonwatch_ingest where lwIngestLocation='Baker'