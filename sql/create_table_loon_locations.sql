--drop table if exists vt_loon_locations;
create table if not exists vt_loon_locations (
	locationName text,
	locationTown text,
	locationRegion text,
	locationArea integer
);
--psql:
--\COPY vt_loon_locations FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\loonWatchData\csv_import\LoonWatch_Sampling_Locations.csv' DELIMITER ',' CSV HEADER
--sql: (in Windows Explorer alter csv_import folder >properties >security: add group 'everyone'	with full privs)
--COPY vt_loon_locations FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\loonWatchData\csv_import\LoonWatch_Sampling_Locations.csv' DELIMITER ',' CSV HEADER
select * from vt_loon_locations;

--constrain locationName to be unique
ALTER TABLE vt_loon_locations ADD CONSTRAINT loon_location_unique UNIQUE(locationName);
--add foreign key waterBodyId 
ALTER TABLE vt_loon_locations ADD COLUMN waterBodyId text;
ALTER TABLE vt_loon_locations ADD CONSTRAINT fk_waterbody_id FOREIGN KEY (waterBodyId) REFERENCES vt_water_body (wbTextId);
--add foreign key locationTownId
ALTER TABLE vt_loon_locations ADD COLUMN locationTownId integer;
ALTER TABLE vt_loon_locations ADD CONSTRAINT fk_loon_location_town_id FOREIGN KEY (locationTownId) REFERENCES vt_town ("townId");

--fix incorrect town names in loon_locations
update vt_loon_locations set locationTown='Hubbardton' where locationTown='Hubbarton';

--set loon location townId from vt_town
update vt_loon_locations l 
set locationTownId = t."townId"
from vt_town t
where upper(l.locationTown) = upper(t."townName")
or upper(l.locationTown) = upper(t."townAlias");

--Find loon locations with towns that didn't match anything in vt_towns
select locationTown, locationName from vt_loon_locations l
where locationTownId is null;

--fix vt_town Mount Holly to have Alias Mt. Holly
update vt_town set "townAlias"='Mt. Holly' where "townName"='Mount Holly';
--fix vt_town Averys Gore to have Alias Avery's Gore
update vt_town set "townAlias"=E'Avery\'s Gore' where "townName"='Averys Gore';

--update locationName, trim leading & trailing whitespace
update vt_loon_locations set locationName=TRIM(BOTH FROM locationName);

-- fix loon location towns that are misspelled or incorrect
update vt_loon_locations set locationTown='Townshend' where locationTown='Townsend';
update vt_loon_locations set locationTown='Lunenburg' where locationTown='Lunenberg';
update vt_loon_locations set locationTown='Hartford' where locationTown='Quechee';

--alter town for lake 'Memphremagog' to 'Derby'
update vt_loon_locations set locationTown='Derby' where locationName = 'Memphremagog';
--alter town for lake 'South Bay' from 'Newport' to 'Newport City'
update vt_loon_locations set locationTown='Newport City' where locationName='South Bay';
--fix other loon locations whose towns are incorrect
update vt_loon_locations set locationTown='Elmore' where locationName='Hardwood';
update vt_loon_locations set locationTown='Eden' where locationName='South (Eden)';

--update waterBodyId where loon locationName == waterBodyId and town == town
update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_body b
where upper(l.locationName) = upper(b.wbTextId)
and l.locationTown = b.wbTownName;

--select loon locations where town == town and loon locationArea == waterbody lakeArea
select * from vt_loon_locations l
join vt_water_body b 
on upper(l.locationTown) = upper(b.wbTownName)
and l.locationArea = b.lakeArea;

--update waterBodyId where town == town and loon locationArea == waterbody lakeArea
update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_body b
where upper(l.locationTown) = upper(b.wbTownName)
and l.locationArea = b.lakeArea;

--select loon locations without a matching waterBody
select * from vt_loon_locations l
join vt_town on locationTownId="townId"
where waterBodyId is null;

--select loon locationName 1st token == waterBodyId 1st token and town == town
select * from vt_loon_locations l
join vt_water_body b
on (string_to_array(upper(l.locationName), ' '))[1] = (string_to_array(upper(b.wbTextId), ' '))[1]
and upper(l.locationTown) = upper(b.wbTownName)
where waterBodyId is null;

--update waterBodyId where loon locationName 1st token == waterBodyId 1st token and town == town
update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_body b
where (string_to_array(upper(l.locationName), ' '))[1] = (string_to_array(upper(b.wbTextId), ' '))[1]
and upper(l.locationTown) = upper(b.wbTownName)
and waterBodyId is null;

--Find loon locations that don't match a vt water body
select (string_to_array(upper(l.locationName), ' '))[1], *
from vt_loon_locations l
where waterBodyId is null;

--handle these on case-by-case basis:
/*
"Clyde River - Buck Flats" - Eric says this is truly a 'new' water body not in the official Lakes list. It's a river.
"Adamant" - See below. Adamant Pond in Calais, VT is not in vt_water_bodies.
"Little Salem" - See below. Little Salem Pond is an historical name not differentiated from Salem Pond in Derby, VT.
"Memphremagog" - Is correct. It wasn't matched because town name was different.
"Townsend Res." - Townsend is misspelled. vt_water_body has a Townshend Reservoir.
"Happenstance Farm" - Didn't exist. Had to create one.
"Nelson" - Nelson Pond in Woodbury, VT is Forest (Calais) in vt_water_bodies
"WrightSurveyille" - Typo. This is Wrightsville Reservoir in East Montpelier
*/

--Adamant Pond, Calais, VT is not in vt_water_bodies:
--https://geodata.vermont.gov/datasets/VTANR::lakes-inventory/explore?location=44.332249%2C-72.501288%2C15.00
select * from vt_loon_locations where lower(locationName) like '%adamant%';
select * from vt_water_body where lower(wbTextId) like '%adamant%';
select * from vt_water_body where lower(wbTownName) like '%calais%';
CREATE TEMP TABLE tmp (like vt_water_body);
INSERT INTO tmp SELECT * FROM vt_water_body WHERE wbTextId = 'ABENAKI';
UPDATE tmp SET wbTextId = 'ADAMANT';
UPDATE tmp SET 
wbArea=20,
wbTownName='Calais',
wbElevation=null,
wbMaxDepth=null, 
wbMeanDepth=null,
wbOfficialName=null,
wbRegion='North Central',
wbBasinArea=null,
wbOutletType=null,
wbFullName='Adamant Pond',
wbType='Pond',
wbCenterLatitude=44.334050, 
wbCenterLongitude=-72.502490
WHERE wbTextId='ADAMANT';
INSERT INTO vt_water_body SELECT * FROM tmp;
SELECT * FROM vt_water_body WHERE wbTextId ='ADAMANT';
DROP TABLE tmp;
UPDATE vt_loon_locations set waterBodyId='ADAMANT' WHERE locationName='Adamant';	

--Nelson Pond in Woodbury, VT is Forest (Calais) in vt_water_bodies
--https://geodata.vermont.gov/datasets/VTANR::lakes-inventory/explore?location=44.404647%2C-72.440308%2C15.00
select * from vt_loon_locations where lower(locationName) like '%nelson%';
select * from vt_water_body where wbTextId like '%FOREST (CALAIS)%';
update vt_loon_locations set waterBodyId='FOREST (CALAIS)' WHERE locationName='Nelson';

--Little Salem Pond is an historical name not differentiated from Salem Pond in Derby, VT
--https://geodata.vermont.gov/datasets/VTANR::lakes-inventory/explore?location=44.927270%2C-72.102205%2C14.00
select * from vt_loon_locations where lower(locationName) like '%little salem%';
select * from vt_water_body where wbTextId like '%SALEM%';
update vt_loon_locations set waterBodyId='SALEM' WHERE locationName='Little Salem';
--insert new wbTextId='LITTLE SALEM' into vt_water_body, copied from 'SALEM'
CREATE TEMP TABLE tmp (like vt_water_body);
INSERT INTO tmp SELECT * FROM vt_water_body WHERE wbTextId = 'SALEM';
UPDATE tmp SET wbTextId = 'LITTLE SALEM';
UPDATE tmp SET wbArea = (SELECT locationArea FROM vt_loon_locations WHERE locationName='Little Salem');
INSERT INTO vt_water_body SELECT * from tmp;
SELECT * FROM vt_water_body WHERE wbTextId='LITTLE SALEM';
UPDATE vt_water_body SET wbCenterLatitude=44.915, wbCenterLongitude=-72.091 WHERE wbTextId='LITTLE SALEM';

--Memphremagog didn't match because towns don't match
select * from vt_loon_locations where lower(locationName) like '%memphremagog%';
select * from vt_water_body where wbTextId like '%MEMPHREMAGOG%';
update vt_loon_locations set waterBodyId='MEMPHREMAGOG' WHERE locationName='Memphremagog';

--Townsend Res. is misspelled
--vt_water_bodies has a Townshend Reservoir
select * from vt_loon_locations where lower(locationName) like '%townsend%';
update vt_loon_locations set locationName='Townshend Res.' where locationName='Townsend Res.';
select * from vt_water_body where wbTextId like '%TOWNSHEND%';
update vt_loon_locations set waterBodyId='TOWNSHEND' WHERE locationName='Townshend Res.';

--Happenstance Farm is tiny, private, and isn't in vt_water_body
select * from vt_loon_locations where lower(locationName) like '%happenstance%';
select * from vt_water_body where lower(wbTextId) like '%happenstance%'; --Does not exist
update vt_loon_locations set waterBodyId='HAPPENSTANCE' WHERE locationName='Happenstance Farm';

--insert new wbTextId='LITTLE SALEM' into vt_water_body, copied from 'SALEM'
CREATE TEMP TABLE tmp (like vt_water_body);
INSERT INTO tmp SELECT * FROM vt_water_body WHERE wbTextId = 'ABENAKI';
UPDATE tmp SET wbTextId = 'HAPPENSTANCE';
UPDATE tmp SET 
wbArea=12,
wbTownName='Goshen',
wbElevation=1640,
wbMaxDepth=null, 
wbMeanDepth=null,
wbOfficialName=null,
wbRegion=(select wbRegion from vt_water_body WHERE wbTextId='DUNMORE'),
wbBasinArea=null,
wbOutletType=null,
wbFullName='Happenstance Farm Pond',
wbType='Pond',
wbCenterLatitude=44.8899, 
wbCenterLongitude=-73.0091 
WHERE wbTextId='HAPPENSTANCE';
INSERT INTO vt_water_body SELECT * from tmp;
DROP TABLE tmp;
UPDATE vt_water_body 
	SET wbRegion=(SELECT wbRegion FROM vt_water_body WHERE wbTextId='DUNMORE') WHERE wbTextId='HAPPENSTANCE';

SELECT * FROM vt_water_body WHERE wbTextId='HAPPENSTANCE';
update vt_loon_locations set waterBodyId='HAPPENSTANCE' WHERE locationName='Happenstance Farm';

select * from vt_water_body where lower(wbTextId) like '%wrightsville%';
update vt_loon_locations set locationName='Wrightsville' where locationName='WrightSurveyille';
update vt_loon_locations set locationTown='East Montpelier' where locationName='Wrightsville';
update vt_loon_locations set waterBodyId='WRIGHTSVILLE' WHERE locationName='Wrightsville';

--add modified exportName to be used for stable, unique eventID on export to IPT
/*
	If future loon locations change, new exportNames can be added and old exportNames remain stable.
	One imagined change is the addition of territories or other lake sub-divisions. If/when that happens, we can remove the 
	uniqueness constraint from locationName, add territory, create a new uniqueness constraint on locationName+territory,
	and generate exportNames from those. Old exportNames without territories would remain the same.
*/
ALTER TABLE vt_loon_locations ADD COLUMN exportName text;
UPDATE vt_loon_locations set exportName=COALESCE(waterBodyId, TRANSLATE(UPPER(locationName),'''.-:,',''));
UPDATE vt_loon_locations SET exportName=REGEXP_REPLACE(exportName,' +',' ','g');
SELECT locationName,locationTownId,"townName",waterBodyId,exportName
--,REGEXP_REPLACE(exportName,' +',' ','g')
FROM vt_loon_locations 
JOIN vt_town ON "townId"=locationTownId
WHERE UPPER(locationName)!=exportName;