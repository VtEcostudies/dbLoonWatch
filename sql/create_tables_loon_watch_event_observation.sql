--drop table if exists loonWatch_event;
create table if not exists loonWatch_event (
	lwEventId SERIAL,
	lwEventWaterBodyId INTEGER NOT NULL,
	lwEventTownId INTEGER NOT NULL,
	lwEventStart TIMESTAMP WITHOUT TIME ZONE,
	lwEventStop TIMESTAMP WITHOUT TIME ZONE
);

ALTER TABLE loonWatch_event ADD CONSTRAINT lw_event_primary_key PRIMARY KEY (lwEventId);

--drop table if exists loonWatch_observation;
create table if not exists loonWatch_observation (
	lwObsEventId INTEGER,
	lwObsTime TIMESTAMP WITHOUT TIME ZONE,
	lwObsGeoLocation geometry(Geometry, 4326),
	lwObsLoonAdults INTEGER DEFAULT 0,
	lwObsLoonSubAdults INTEGER DEFAULT 0,
	lwObsLoonChicks INTEGER DEFAULT 0,
	lwObsEagle INTEGER DEFAULT 0,
	lwObsOsprey INTEGER DEFAULT 0,
	lwObsOther TEXT
);

ALTER TABLE loonWatch_observation ADD CONSTRAINT fk_lw_event_id 
	FOREIGN KEY (lwObsEventId) REFERENCES loonWatch_event (lwEventId);
