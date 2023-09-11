drop table if exists loonWatch_observation;
drop table if exists loonWatch_event;

create table if not exists loonWatch_event (
	lwEventId SERIAL,
	lwEventWaterBodyId TEXT NOT NULL,
	lwEventTownId INTEGER,
	lwEventDate DATE NOT NULL,
	lwEventObserverEmail TEXT[], --NOT NULL, --Initial import has no observer info
	lwEventObserverName TEXT[], --NOT NULL, --Initial import has no observer info
	lwEventObserverCount INTEGER,
	lwEventStart TIME WITHOUT TIME ZONE,
	lwEventStop TIME WITHOUT TIME ZONE,
	lwEventComment TEXT,
	lwEventSketchUrl TEXT
);

ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_primary_key 
	PRIMARY KEY (lwEventId);
ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_unique_wbId_date_time_observer 
	UNIQUE (lwEventWaterBodyId,lwEventDate,lwEventStart,lwEventObserverEmail);
ALTER TABLE loonWatch_event ADD CONSTRAINT fk_water_body_id 
	FOREIGN KEY (lwEventWaterBodyId) REFERENCES vt_water_body (wbTextId);
ALTER TABLE loonWatch_event ADD CONSTRAINT fk_town_id 
	FOREIGN KEY (lwEventTownId) REFERENCES vt_town ("townId");

create table if not exists loonWatch_observation (
	lwObsEventId INTEGER NOT NULL,
	lwObsTime TIME WITHOUT TIME ZONE,
	lwObsGeoLocation geometry(Geometry, 4326),
	lwObsAdult INTEGER DEFAULT 0,
	lwObsAdultPhotoUrl TEXT[],
	lwObsSubAdult INTEGER DEFAULT 0,
	lwObsSubAdultPhotoUrl TEXT[],
	lwObsChick INTEGER DEFAULT 0,
	lwObsChickPhotoUrl TEXT[],
	lwObsLoonLocationDirection TEXT,
	lwObsEagle TEXT,
	lwObsOsprey TEXT,
	lwObsOther TEXT
);

ALTER TABLE loonWatch_observation ADD CONSTRAINT fk_lw_event_id 
	FOREIGN KEY (lwObsEventId) REFERENCES loonWatch_event (lwEventId);
ALTER TABLE loonWatch_observation ADD CONSTRAINT lw_event_unique_time_counts
	UNIQUE (lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick);
	
INSERT INTO loonWatch_event (lwEventWaterBodyId,lwEventTownId,lwEventDate,lwEventObserverEmail,lwEventStart,lwEventStop) 
	VALUES('ABENAKI', 
		   (SELECT "townId" FROM vt_town WHERE "townName"='Thetford'), 
		   (SELECT DATE(NOW())),
		   '{ehanson@vtecostudies.org,jloomis@vtecostudies.org}',
		   '8:00',
		   '9:00'
		  );
	
SELECT * FROM loonWatch_event;

INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick)
	VALUES(1,'8:36',2,0,1);
INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick)
	VALUES(1,'8:41',0,1,0);
INSERT INTO loonWatch_observation(lwObsEventId,lwObsTime,lwObsAdult,lwObsSubAdult,lwObsChick,lwObsEagle,lwObsOsprey)
	VALUES(1,'8:55',0,0,1,'','NE region: Osprey attacked chick. Unsuccessful.');

SELECT * FROM loonWatch_observation;

SELECT * FROM loonWatch_event
JOIN loonWatch_observation ON lwObsEventId=lwEventId;
