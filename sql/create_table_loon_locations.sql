--drop table if exists vt_loon_locations;
create table if not exists vt_loon_locations (
	locationName text,
	locationTown text,
	locationRegion text,
	locationArea integer
);
--psql:
--\COPY vt_loon_locations FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\loonWatchData\csv_import\LoonWatch_Sampling_Locations.csv' DELIMITER ',' CSV HEADER
select * from vt_loon_locations where locationArea > 200;

--add foreign key waterBodyId 
alter table vt_loon_locations add column waterBodyId text;
alter table vt_loon_locations ADD CONSTRAINT fk_waterbody_id FOREIGN KEY (waterBodyId) REFERENCES vt_water_bodies (wbTextId);
--add foreign key locationTownId
alter table vt_loon_locations add column locationTownId integer;
alter table vt_loon_locations ADD CONSTRAINT fk_loon_location_town_id FOREIGN KEY (locationTownId) REFERENCES vt_town ("townId");

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

--exact match loon locationName == water body and town == town
update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_bodies b
where upper(l.locationName) = upper(b.wbTextId)
and l.locationTown = b.wbTownName;

--select loon locations with town == town and loon lake area == waterbody area
select * from vt_loon_locations l
join vt_water_bodies b 
on upper(l.locationTown) = upper(b.wbTownName)
and l.locationArea = b.lakeArea;

--exact match towns == towns and loon lake area == waterbody area
update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_bodies b
where upper(l.locationTown) = upper(b.wbTownName)
and l.locationArea = b.lakeArea;

--select loon locations without a matching waterBody
select * from vt_loon_locations l
join vt_town on locationTownId="townId"
where waterBodyId is null;

--select loon lake name 1st token == water body 1st token and town == town
select * from vt_loon_locations l
join vt_water_bodies b
on (string_to_array(upper(l.locationName), ' '))[1] = (string_to_array(upper(b.wbTextId), ' '))[1]
and upper(l.locationTown) = upper(b.wbTownName)
where waterBodyId is null;

update vt_loon_locations l
set waterBodyId=wbTextId
from vt_water_bodies b
where (string_to_array(upper(l.locationName), ' '))[1] = (string_to_array(upper(b.wbTextId), ' '))[1]
and upper(l.locationTown) = upper(b.wbTownName)
and waterBodyId is null;

--Find loon locations that don't match a vt water body
select (string_to_array(upper(l.locationName), ' '))[1], *
from vt_loon_locations l
where waterBodyId is null;

select * from vt_loon_locations l
join vt_water_bodies b on 1=1
where waterBodyId is null
and upper(b.wbOfficialName) like '%' || (string_to_array(upper(l.locationName), ' '))[1] || '%';

select * from vt_water_bodies where lower(wbFullName) like '%clyde%';
