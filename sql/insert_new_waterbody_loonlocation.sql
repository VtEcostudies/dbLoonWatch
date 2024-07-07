--looking for loonLocation or waterBody for 2008 survey of Quechee Gorge Dam
select * from vt_loon_locations where locationName like 'Que%';
select * from vt_water_body where wbFullName like '%Gorge%';
select * from vt_water_body where wbOfficialName like '%Gorge%';
select distinct(wbType) from vt_water_body;
--Doesn't exist. Create new waterBody & loonLocation 'Quechee Gorge Dam'
--There isn't an official VT Water Body, so the feature will not reside within that GeoJSON layer,
--meaning it can't be searched on the loon map.
CREATE TEMP TABLE tmp (like vt_water_body);
INSERT INTO tmp SELECT * FROM vt_water_body WHERE wbTextId = 'ABENAKI';
UPDATE tmp SET 
	wbTextId = 'QUECHEE GORGE DAM',
	wbArea=0,
	wbTownName='Hartford',
	wbElevation=null,
	wbMaxDepth=null, 
	wbMeanDepth=null,
	wbOfficialName=null,
	wbRegion=(SELECT wbRegion FROM vt_water_body WHERE wbTextId='PINNEO'),
	wbBasinArea=null,
	wbOutletType=null,
	wbFullName='Quechee Gorge Dam',
	wbType='Lake (Artificial Control)',
	wbCenterLatitude=43.642503, 
	wbCenterLongitude=-72.406640;
INSERT INTO vt_water_body SELECT * FROM tmp;
SELECT * FROM vt_water_body WHERE wbTextId like 'QUECHEE%';
DROP TABLE tmp;
INSERT INTO vt_loon_locations (locationName, locationTown, locationRegion, locationArea, waterBodyId, locationTownId, exportName)
VALUES(
	'Quechee Gorge Dam',
	'Hartford',
	(SELECT locationRegion FROM vt_loon_locations WHERE waterBodyId='PINNEO'),
	0,
	'QUECHEE GORGE DAM',
	(SELECT "townId" FROM vt_town WHERE "townName"='Hartford'),
	'QUECHEE GORGE DAM'
);
SELECT * FROM vt_loon_locations WHERE locationName LIKE '%Gorge%';
--DELETE FROM vt_loon_locations WHERE locationName LIKE '%Queechee%';
--DELETE FROM vt_water_body WHERE wbTextId LIKE '%QUEECHEE%';

--looking for loonLocation or waterBody for 2008 survey of Taftsville Dam
select * from vt_loon_locations where locationName like 'Taftsville%';
select * from vt_water_body where wbFullName like '%aftsv%';
select * from vt_water_body where wbTextId like '%aftsv%';
--Doesn't exist. Create new waterBody & loonLocation 'Quechee Gorge Dam'
--There isn't an official VT Water Body, so the feature will not reside within that GeoJSON layer,
--meaning it can't be searched on the loon map.
CREATE TEMP TABLE tmp (like vt_water_body);
INSERT INTO tmp SELECT * FROM vt_water_body WHERE wbTextId = 'ABENAKI';
UPDATE tmp SET 
	wbTextId = 'TAFTSVILLE DAM',
	wbArea=0,
	wbTownName='Hartford',
	wbElevation=null,
	wbMaxDepth=null, 
	wbMeanDepth=null,
	wbOfficialName=null,
	wbRegion=(SELECT wbRegion FROM vt_water_body WHERE wbTextId='PINNEO'),
	wbBasinArea=null,
	wbOutletType=null,
	wbFullName='Taftsville Dam',
	wbType='Lake (Artificial Control)',
	wbCenterLatitude=43.631688, 
	wbCenterLongitude=-72.468706;
INSERT INTO vt_water_body SELECT * FROM tmp;
SELECT * FROM vt_water_body WHERE wbTextId like 'TAFTS%';
DROP TABLE tmp;
INSERT INTO vt_loon_locations (locationName, locationTown, locationRegion, locationArea, waterBodyId, locationTownId, exportName)
VALUES(
	'Taftsville Dam',
	'Hartford',
	(SELECT locationRegion FROM vt_loon_locations WHERE waterBodyId='PINNEO'),
	0,
	'TAFTSVILLE DAM',
	(SELECT "townId" FROM vt_town WHERE "townName"='Hartford'),
	'TAFTSVILLE DAM'
);
SELECT * FROM vt_loon_locations WHERE locationName LIKE 'Tafts%';

--Add loon location Sabin (Woodbury) of Calais for 
INSERT INTO vt_loon_locations (locationName, locationTown, locationRegion, locationArea, waterBodyId, locationTownId, exportName)
VALUES(
	'Sabin (Woodbury)',
	'Calais',
	(SELECT locationRegion FROM vt_loon_locations WHERE waterBodyId='MIRROR'),
	142,
	'SABIN',
	(SELECT "townId" FROM vt_town WHERE "townName"='Calais'),
	'SABIN'
);
SELECT * FROM vt_loon_locations WHERE locationName LIKE 'Sabin%';

--Add loon location Waterbury
INSERT INTO vt_loon_locations (locationName, locationTown, locationRegion, locationArea, waterBodyId, locationTownId, exportName)
VALUES(
	'Waterbury',
	'Waterbury',
	(SELECT locationRegion FROM vt_loon_locations WHERE waterBodyId='WATERBURY'),
	839,
	'WATERBURY',
	(SELECT "townId" FROM vt_town WHERE "townName"='Waterbury'),
	'WATERBURY'
);
SELECT * FROM vt_loon_locations WHERE locationName LIKE 'Waterbury%';
