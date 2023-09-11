
drop table if exists loonWatch_ingest;

create table if not exists loonWatch_ingest (
	--lwIngestId SERIAL,
	lwIngestLocation TEXT NOT NULL,
	lwIngestTownName TEXT NOT NULL,
	--lwIngestTownId INTEGER,
	lwIngestDate DATE NOT NULL,
	--lwIngestObserverEmail TEXT[], --NOT NULL, --Initial import has no observer info
	--lwIngestObserverName TEXT[], --NOT NULL, --Initial import has no observer info
	--lwIngestObserverCount INTEGER,
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
ALTER TABLE loonWatch_ingest ADD CONSTRAINT lw_ingest_unique_location_dat
	UNIQUE (lwIngestLocation,lwIngestDate);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_location 
--	FOREIGN KEY (lwIngestLocation) REFERENCES vt_loon_locations (locationName);
--ALTER TABLE loonWatch_ingest ADD CONSTRAINT fk_town_id 
--	FOREIGN KEY (lwIngestTownId) REFERENCES vt_town ("townId");

--Import data using psql:
--\COPY loonWatch_ingest FROM 'C:\Users\jtloo\Documents\VCE\LoonWeb\loonWatchData\csv_import\LoonWatch_Raw_Counts_2011.csv' DELIMITER ',' CSV HEADER
