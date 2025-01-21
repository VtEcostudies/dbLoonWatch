SET SEARCH_PATH TO loonWatch,public; --this makes table references use SEARCH_PATH to find the default schema

--create table loonWatch_ingest_backup as select * from loonWatch_ingest;

--drop table if exists loonWatch_ingest;

create table if not exists loonWatch_ingest (
	--lwIngestId SERIAL,
	lwIngestLocation TEXT NOT NULL,
	lwIngestTownName TEXT NOT NULL,
	--lwIngestTownId INTEGER,
	lwIngestObserverName TEXT, --Initial import has a few delimited values
	--lwIngestObserverEmail TEXT, --Initial import has no observer info
	--lwIngestObserverCount INTEGER,
	lwIngestDate DATE NOT NULL,
	lwIngestStart TIME WITHOUT TIME ZONE,
	lwIngestStop TIME WITHOUT TIME ZONE,
	lwIngestAdult INTEGER DEFAULT 0,
	lwIngestChick INTEGER DEFAULT 0,
	lwIngestSubAdult INTEGER DEFAULT 0,
	lwIngestSurvey INTEGER,	
	lwIngestComment TEXT
);

--ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_primary_key 
--	PRIMARY KEY (lwIngestId);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_unique_location_date
--	UNIQUE (lwIngestLocation,lwIngestDate);
--ALTER TABLE loonWatch_ingest DROP CONSTRAINT lw_ingest_unique_location_date;
ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_unique_location_town_date
	UNIQUE (lwIngestLocation,lwIngestTownName,lwIngestDate);
ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_location 
	FOREIGN KEY (lwIngestLocation) REFERENCES vt_loon_locations (locationName);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_town_id 
--	FOREIGN KEY (lwIngestTownId) REFERENCES vt_town ("townId");
--For now we leave lwIngestLocation unconstrained, but we use it to link data to vt_loon_locations and vt_water_bodies
ALTER TABLE loonWatch_ingest DROP CONSTRAINT fk_location;
ALTER TABLE loonWatch_ingest ADD COLUMN "updatedAt" TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW();
CREATE TRIGGER trigger_updated_at
    BEFORE UPDATE 
    ON loonWatch_ingest
    FOR EACH ROW
    EXECUTE FUNCTION public.set_updated_at();
--Import data using psql:
--\COPY loonWatch_ingest FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\csv_import\LoonWatch_Raw_Counts_2011.csv' DELIMITER ',' CSV HEADER

--5 location names from 2011 spreadsheet have leading/trailing whitespace, so they don't match our corrected loon_locations
update loonWatch_ingest set lwIngestLocation=TRIM(BOTH FROM lwIngestLocation);

select * from loonWatch_ingest
join vt_loon_locations on locationName=lwIngestLocation; --155

select * from loonWatch_ingest
left join vt_loon_locations on locationName=lwIngestLocation
where locationName is null; --0

--loonWatch data having waterBodyId
select * from loonWatch_ingest
join vt_loon_locations on locationName=lwIngestLocation
join vt_water_body on wbTextId=waterBodyId;

--loonWatch data missing waterBodyId
select * from loonWatch_ingest
join vt_loon_locations on locationName=lwIngestLocation
left join vt_water_body on wbTextId=waterBodyId
where waterBodyId is null; --3

update loonWatch_ingest set lwIngestLocation='Wrightsville' where lwIngestLocation = 'WrightSurveyille';

--delete from loonWatch_ingest where date_part('year', lwingestdate)=2014; --to fix an incorrect ingestion
select * from loonWatch_ingest where date_part('year', lwingestdate)=2023;
update loonWatch_ingest set lwIngestDate='2014-07-18' where lwIngestDate='2023-07-18';
delete from loonWatch_ingest where lwIngestObservername='test';