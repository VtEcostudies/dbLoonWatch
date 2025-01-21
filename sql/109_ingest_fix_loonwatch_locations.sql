--Create a backup
drop table lw_ingest_backup;
create table lw_ingest_backup as table loonwatch_ingest;

--Select Ingest Locations that don't match Loon Locations
SELECT distinct(lwIngestLocation) FROM loonwatch_ingest 
SELECT * FROM loonwatch_ingest 
LEFT JOIN vt_loon_locations ON lwIngestLocation=locationName
WHERE locationName IS NULL;

SELECT * FROM loonWatch_ingest
JOIN vt_loon_locations ON 1=1
WHERE UPPER(lwIngestLocation)=UPPER(locationName)
AND lwIngestLocation!=locationName

--Fix lwIngestTownName, lwIngestLocation for EXACT UPPERCASE MATCH lwIngestLocations:
UPDATE loonwatch_ingest 
SET lwIngestTownName=locationTown, lwIngestLocation=locationName
FROM vt_loon_locations
WHERE UPPER(lwIngestLocation)=UPPER(locationName)
AND lwIngestLocation!=locationName

--Fix lwIngestTownName, lwIngestLocation for 
WITH fix AS (
SELECT 
	UPPER(SPLIT_PART(li.lwIngestLocation, ' ', 1)) AS "PartIngestLocation", li.lwIngestLocation,
	UPPER(SPLIT_PART(ll.locationName, ' ', 1)) AS "PartLocationName", ll.locationName,
	ll.locationTown, li.lwIngestDate, li.lwIngestTownName
	FROM 
	(SELECT * FROM loonwatch_ingest LEFT JOIN vt_loon_locations ON lwIngestLocation=locationName WHERE locationName IS NULL) li
JOIN vt_loon_locations ll ON UPPER(SPLIT_PART(ll.locationName, ' ', 1)) = UPPER(SPLIT_PART(li.lwIngestLocation, ' ', 1))
WHERE
UPPER(SPLIT_PART(SPLIT_PART(li.lwIngestLocation, ' (', 2),')',1)) = UPPER(ll.locationTown)
)
UPDATE loonWatch_ingest li
SET lwIngestLocation = fix.locationName, lwIngestTownName=fix.locationTown
FROM fix
WHERE li.lwIngestLocation=fix.lwIngestLocation AND li.lwIngestDate=fix.lwIngestDate AND li.lwIngestTownName=fix.lwIngestTownName

--Find lwIngestLocations not in vt_loon_locations
SELECT 
	UPPER(SPLIT_PART(li.lwIngestLocation, ' ', 1)) AS "PartIngestLocation", li.lwIngestLocation, li.lwIngestTownName,
	UPPER(SPLIT_PART(ll.locationName, ' ', 1)) AS "PartLocationName", ll.locationName, ll.locationTown, 
	li.lwIngestDate, li.lwIngestTownName
	FROM 
	(SELECT * FROM loonwatch_ingest LEFT JOIN vt_loon_locations ON lwIngestLocation=locationName WHERE locationName IS NULL) li
JOIN vt_loon_locations ll ON UPPER(SPLIT_PART(ll.locationName, ' ', 1)) = UPPER(SPLIT_PART(li.lwIngestLocation, ' ', 1))

--Knapp Brook 1 -> Knapp Br1
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Knapp Brook 1';
UPDATE loonWatch_ingest li SET lwIngestLocation = locationName FROM vt_loon_locations ll
WHERE lwIngestLocation = 'Knapp Brook 1';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Knapp Br1';
--Knapp Brook 2 -> Knapp Br2
--Got a strange Constraint violation trying to do below what was done above. Had to make SET to static text, not column.
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Knapp Brook 2';
UPDATE loonWatch_ingest SET lwIngestLocation = 'Knapp Br2'
WHERE lwIngestLocation = 'Knapp Brook 2';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Knapp Br2';
--Marshfield -> Marshfield Pond (Turtlehead Pond)
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Marshfield';
UPDATE loonWatch_ingest SET lwIngestLocation = locationName
WHERE lwIngestLocation = 'Marshfield';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Marshfield%';
--Sherman -> Sherman Reservoir
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Sherman';
UPDATE loonWatch_ingest SET lwIngestLocation = locationName FROM vt_loon_locations
WHERE lwIngestLocation = 'Sherman';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Sherman%';
--Woodbury (Sabin) -> Sabin (Woodbury) Also must add to vt_loon_locations
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation Like 'Woodbury (Sabin)';
SELECT * FROM vt_water_body WHERE UPPER(wbFullName) LIKE 'SABIN%';
UPDATE loonWatch_ingest SET lwIngestLocation = 'Sabin (Woodbury)'
WHERE lwIngestLocation = 'Woodbury (Sabin)';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Sabin%';
--Waterbury - Don't alter ingest. Instead add vt_loon_location 'Waterbury'
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Waterbury';
SELECT * FROM vt_water_body WHERE UPPER(wbFullName) LIKE 'WATERBURY%';
--Bean of Sutton -> Bean (Sutton)
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Bean' AND lwIngestTownName = 'Sutton';
UPDATE loonWatch_ingest SET lwIngestLocation = locationName FROM vt_loon_locations
WHERE lwIngestLocation = 'Bean' AND lwIngestTownName = 'Sutton';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Bean (Sutton)';
--Baker of Barton -> Baker (Barton)
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Baker' AND lwIngestTownName = 'Barton';
UPDATE loonWatch_ingest SET lwIngestLocation = locationName FROM vt_loon_locations
WHERE lwIngestLocation = 'Baker' AND lwIngestTownName = 'Barton';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Baker (Barton)';
SELECT * FROM loonwatch_ingest WHERE lwIngestTownName LIKE 'Barton';
--Baker of Brookfield -> Baker (Brookfield)
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation = 'Baker' AND lwIngestTownName = 'Brookfield';
UPDATE loonWatch_ingest SET lwIngestLocation = locationName FROM vt_loon_locations
WHERE lwIngestLocation = 'Baker' AND lwIngestTownName = 'Brookfield';
SELECT * FROM loonwatch_ingest WHERE lwIngestLocation LIKE 'Baker (Brookfield)';
--Something is WRONG with the UPDATE JOIN method - it doesn't obey the WHERE clause
--Using it has corrupted loonwatch_ingest data, maybe just townNames.
select * from loonwatch_ingest
join vt_loon_locations on lwIngestLocation=locationName
where locationTown != lwIngestTownName
