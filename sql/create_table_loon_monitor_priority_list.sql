DROP TABLE IF EXISTS loonMonitor_priority_list;
DROP TYPE IF EXISTS lm_method_type;
DROP TYPE IF EXISTS lm_lookfor_type;
CREATE TYPE lm_method_type AS ENUM ('boat','shore','boat/shore','shore/boat','boat - carry in','boat - from outlet','hike','hike/boat','state park','bushwhack');
CREATE TYPE lm_lookfor_type AS ENUM ('loon activity','pair activity','territory status','extra loon activity');
CREATE TABLE loonMonitor_priority_list (
lmPriorityLocationName TEXT,
lmPriorityTerritoryName TEXT,
lmPriorityLocationTown TEXT,
lmPriorityMethod lm_method_type,
lmPriorityLookFor lm_lookfor_type,
lmPriorityValue INTEGER
);

COPY loonMonitor_priority_list FROM 
'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\LoonMonitor_Priority_List.csv' 
DELIMITER ',' CSV HEADER;

UPDATE loonMonitor_priority_list SET lmPriorityLocationName=TRIM(BOTH FROM lmPriorityLocationName)
WHERE lmPriorityLocationName != TRIM(BOTH FROM lmPriorityLocationName); --Count: 5

select * from loonMonitor_priority_list
left join vt_loon_locations on locationName like lmPriorityLocationName
where locationName is null

SELECT 
	UPPER(SPLIT_PART(lmPriorityLocationName, ' ', 1)) AS "PartIngestLocation", lmPriorityLocationName, lmPriorityLocationTown,
	UPPER(SPLIT_PART(locationName, ' ', 1)) AS "PartLocationName", locationName, locationTown
	FROM --loonMonitor_priority_list
	(select lm.* from loonMonitor_priority_list lm
		left join vt_loon_locations on locationName like lmPriorityLocationName
		where locationName is null
		) lm
JOIN vt_loon_locations 
	ON UPPER(SPLIT_PART(locationName, ' ', 1)) = UPPER(SPLIT_PART(lmPriorityLocationName, ' ', 1))
	AND UPPER(SPLIT_PART(SPLIT_PART(lmPriorityLocationName, ' (', 2),')',1)) = UPPER(locationTown);
