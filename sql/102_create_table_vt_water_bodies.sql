SET SEARCH_PATH TO loonWatch,public; --this makes table references use SEARCH_PATH to find the default schema

--drop table vt_water_body;
create table if not exists vt_water_body (
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
	--,wbGeoCentroid GEOMETRY(Geometry, 4326)
	--,wbGeoBorder GEOMETRY(Geometry, 4326)
);

--Import data using psql:
--\COPY vt_water_body FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\Official_Lake_List_VT_2023.csv' DELIMITER ',' CSV HEADER
/*
--find duplicate wbTextIds
select wbTextId, count(wbTextId) from vt_water_body
group by wbTextId
having count(wbTextId) > 1;

ALTER TABLE vt_water_body RENAME COLUMN LakeId TO wbTextId;
ALTER TABLE vt_water_body RENAME COLUMN OfficialName TO wbOfficialName;
ALTER TABLE vt_water_body RENAME COLUMN Town TO wbTownName;
ALTER TABLE vt_water_body RENAME COLUMN LakeRegion TO wbRegion;
ALTER TABLE vt_water_body RENAME COLUMN LakeArea TO wbArea;
ALTER TABLE vt_water_body RENAME COLUMN BasinArea TO wbBasinArea;
ALTER TABLE vt_water_body RENAME COLUMN Elevation TO wbElevation;
ALTER TABLE vt_water_body RENAME COLUMN MaxDepth TO wbMaxDepth;
ALTER TABLE vt_water_body RENAME COLUMN MeanDepth TO wbMeanDepth;
ALTER TABLE vt_water_body RENAME COLUMN OutletType TO wbOutletType;
ALTER TABLE vt_water_body RENAME COLUMN locationName TO wbFullName;
ALTER TABLE vt_water_body RENAME COLUMN locationType TO wbType;
ALTER TABLE vt_water_body RENAME COLUMN CenterLatitude TO wbCenterLatitude;
ALTER TABLE vt_water_body RENAME COLUMN CenterLongitude TO wbCenterLongitude;

ALTER TABLE vt_water_body ADD CONSTRAINT vt_water_body_pkey PRIMARY KEY (wbTextId);
*/