drop table if exists loonWatch_observation;
drop table if exists loonWatch_event;

create table if not exists loonWatch_event (
	lwEventId SERIAL,
	lwEventUuid UUID,
	lwEventTimestamp TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	lwEventWaterBodyId TEXT NOT NULL,
	lwEventTownId INTEGER,
	lwEventDate DATE NOT NULL,
	lwEventObserverEmail TEXT[] NOT NULL, --Initial import has no observer info
	lwEventObserverName TEXT[],
	lwEventObserverCount INTEGER,
	lwEventStart TIME WITHOUT TIME ZONE NOT NULL,
	lwEventStop TIME WITHOUT TIME ZONE NOT NULL,
	lwEventType TEXT,
	--lwEventSketchUrl TEXT,
	lwEventEagle TEXT,
	lwEventOsprey TEXT,
	lwEventOther TEXT
);

ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_primary_key 
	PRIMARY KEY (lwEventId);
ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_unique_wbId_date_time_observer 
	UNIQUE (lwEventWaterBodyId,lwEventDate,lwEventStart,lwEventObserverEmail);
ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_unique_uuid
	UNIQUE (lwEventUuid);
ALTER TABLE loonWatch_event ADD CONSTRAINT fk_water_body_id 
	FOREIGN KEY (lwEventWaterBodyId) REFERENCES vt_water_body (wbTextId);
ALTER TABLE loonWatch_event ADD CONSTRAINT fk_town_id 
	FOREIGN KEY (lwEventTownId) REFERENCES vt_town ("townId");

create table if not exists loonWatch_observation (
	lwObsEventId INTEGER NOT NULL,
	lwObsTime TIME WITHOUT TIME ZONE,
	lwObsLatitude DECIMAL,
	lwObsLongitude DECIMAL,
	lwObsGeoLocation geometry(Geometry, 4326),
	lwObsAdult INTEGER DEFAULT 0,
	lwObsSubAdult INTEGER DEFAULT 0,
	lwObsChick INTEGER DEFAULT 0,
	lwObsPhotoUrl TEXT[],
	lwObsNotes TEXT
);

ALTER TABLE loonWatch_observation ADD CONSTRAINT fk_lw_event_id 
	FOREIGN KEY (lwObsEventId) REFERENCES loonWatch_event (lwEventId);
ALTER TABLE loonWatch_observation ADD CONSTRAINT lw_event_unique_time_counts
	UNIQUE (lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick);
	
INSERT INTO loonWatch_event (lwEventUuid,lwEventTimestamp,lwEventWaterBodyId,lwEventTownId,lwEventDate,lwEventObserverEmail,lwEventStart,lwEventStop,lwEventEagle,lwEventOsprey,lwEventOther) 
	VALUES(
			gen_random_uuid(),
			(SELECT NOW()),
			'ABENAKI', 
			(SELECT "townId" FROM vt_town WHERE "townName"='Thetford'), 
			(SELECT DATE(NOW())),
			'{ehanson@vtecostudies.org,jloomis@vtecostudies.org}',
			'8:00',
			'9:00',
			'Eagle nest on dead tree in NW swamp.',
			'NE region: Osprey attacked chick. Unsuccessful.',
			'Recent fish drop by F&W.'
		  );
	
SELECT * FROM loonWatch_event;

INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick)
	VALUES(1,'8:36',2,0,1);
INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick)
	VALUES(1,'8:41',0,1,0);
INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick)
	VALUES(1,'8:55',0,0,1);

SELECT * FROM loonWatch_observation;

SELECT * FROM loonWatch_event
JOIN loonWatch_observation ON lwObsEventId=lwEventId;
