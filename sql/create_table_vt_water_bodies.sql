--drop table vt_water_bodies;
create table if not exists vt_water_bodies (
	wbTextId text,
	wbOfficialName text,
	wbTownName text,
	wbRegion text,
	wbArea integer,
	wbBasinArea integer,
	wbElevation integer,
	wbMaxDepth integer,
	wbMeanDepth integer,
	wbOutletType text,
	wbFullName text,
	wbType text,
	wbCenterLatitude decimal,
	wbCenterLongitude decimal
	--wbGeoCentroid GEOMETRY(Geometry, 4326),
	--wbGeoBorder GEOMETRY(Geometry, 4326)
);
--Import data using psql:
--\COPY vt_water_bodies FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\loonWatchData\csv_import\Official_Lake_List_VT_2023.csv' DELIMITER ',' CSV HEADER

--find duplicate wbTextIds
select wbTextId, count(wbTextId) from vt_water_bodies
group by wbTextId
having count(wbTextId) > 1;

ALTER TABLE vt_water_bodies ADD CONSTRAINT vt_water_bodies_pkey PRIMARY KEY (LakeId);

ALTER TABLE vt_water_bodies RENAME COLUMN LakeId TO wbTextId;
ALTER TABLE vt_water_bodies RENAME COLUMN OfficialName TO wbOfficialName;
ALTER TABLE vt_water_bodies RENAME COLUMN Town TO wbTownName;
ALTER TABLE vt_water_bodies RENAME COLUMN LakeRegion TO wbRegion;
ALTER TABLE vt_water_bodies RENAME COLUMN LakeArea TO wbArea;
ALTER TABLE vt_water_bodies RENAME COLUMN BasinArea TO wbBasinArea;
ALTER TABLE vt_water_bodies RENAME COLUMN Elevation TO wbElevation;
ALTER TABLE vt_water_bodies RENAME COLUMN MaxDepth TO wbMaxDepth;
ALTER TABLE vt_water_bodies RENAME COLUMN MeanDepth TO wbMeanDepth;
ALTER TABLE vt_water_bodies RENAME COLUMN OutletType TO wbOutletType;
ALTER TABLE vt_water_bodies RENAME COLUMN locationName TO wbFullName;
ALTER TABLE vt_water_bodies RENAME COLUMN locationType TO wbType;
ALTER TABLE vt_water_bodies RENAME COLUMN CenterLatitude TO wbCenterLatitude;
ALTER TABLE vt_water_bodies RENAME COLUMN CenterLongitude TO wbCenterLongitude;
ALTER TABLE vt_water_bodies ADD COLUMN wbGeoCentroid GEOMETRY(Geometry, 4326);
ALTER TABLE vt_water_bodies ADD COLUMN wbGeoBorder GEOMETRY(Geometry, 4326);

