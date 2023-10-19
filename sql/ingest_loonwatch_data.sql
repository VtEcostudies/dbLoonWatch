--ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_unique_location_date
--	UNIQUE (lwIngestLocation,lwIngestDate);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_location 
--	FOREIGN KEY (lwIngestLocation) REFERENCES vt_loon_locations (locationName);
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
COPY loonWatch_ingest FROM 
'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\LoonWatch_Raw_Counts_2009.csv' 
DELIMITER ',' CSV HEADER;

--Select loon locations with bad whitespace
SELECT * FROM loonWatch_ingest WHERE lwIngestLocation != TRIM(BOTH FROM lwIngestLocation);
--Fix location names having leading/trailing whitespace so they match our corrected loon_locations
UPDATE loonWatch_ingest SET lwIngestLocation=TRIM(BOTH FROM lwIngestLocation);

--Select ingest locations without town names
SELECT * FROM loonwatch_ingest 
WHERE lwIngestTownName IS NULL;

--Oops. Fix all ingest town names in table. Earlier query updated all to same name.
--UPDATE loonwatch_ingest SET lwIngestTownName=NULL;
--Set lwIngest town names where locationNames match
UPDATE loonwatch_ingest 
SET lwIngestTownName=locationTown 
FROM vt_loon_locations
WHERE lwIngestLocation=locationName 
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

--try to fuzzy match location names without towns
SELECT 
	UPPER(SPLIT_PART(lwIngestLocation, ' ', 1)) AS "PartIngestLocation", lwIngestLocation,
	UPPER(SPLIT_PART(locationName, ' ', 1)) AS "PartLocationName", locationName,
	locationTown, lwIngestDate, * 
	FROM loonwatch_ingest 
--JOIN vt_loon_locations ON UPPER(locationName) = UPPER(lwIngestLocation)
JOIN vt_loon_locations ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lwIngestLocation, ' ', 1))
WHERE lwIngestTownName IS NULL;

ALTER TABLE loonWatch_ingest ALTER COLUMN lwIngestTownName SET NOT NULL;
ALTER TABLE loonWatch_ingest ENABLE TRIGGER ALL;
