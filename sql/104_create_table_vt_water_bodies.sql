/*
The orginal list of official water bodies came from Eric Hanson in a file named Official_Lake_List_VT_2023.csv. It's orgins were unclear,
but Eric suggested that it had been assembled from a variety of sources at the state. This is the only source we've found for the different
names LakeId, OfficialName, and LocationName (which is believed to be a Loon Project value).

Initially we trusted te lat, lon values here, but later found them to be wrong in some cases. With the creation of the LW DC App, we needed
guaranteed polygons and centroids, and used the download from geodata.vermont for that. (We compute, elsewhere, a centroid from the polygon).
*/
SET SEARCH_PATH TO loonWatch,public; --this makes table references use SEARCH_PATH to find the default schema

--DROP TABLE IF EXISTS vt_water_body;
create table if not exists vt_water_body (
	LakeId text,
	OfficialName text,
	Town text,
	LakeRegion text,
	LakeArea integer,
	BasinArea integer,
	Elevation integer,
	MaxDepth integer,
	MeanDepth integer,
	OutletType text,
	locationName text,
	locationType text,
	centerLatitude decimal,
	centerLongitude decimal
);

--Import data using psql:
--\COPY vt_water_body FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\Official_Lake_List_VT_2023.csv' DELIMITER ',' CSV HEADER

--Must give su privs to postgres user to allow it to read the file
COPY vt_water_body
FROM '../csv_import/Official_Lake_List_VT_2023.csv'
DELIMITER ','
CSV HEADER;

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

/*
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
);
*/
