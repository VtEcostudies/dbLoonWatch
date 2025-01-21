
CREATE TABLE vt_county (
    "countyId" integer NOT NULL,
    "govCountyId" integer,
    "countyName" character varying(50) NOT NULL
);

INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (0, 0, 'Unknown');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (1, 19, 'Orleans');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (2, 13, 'Grand Isle');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (3, 7, 'Chittenden');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (4, 27, 'Windsor');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (5, 25, 'Windham');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (6, 3, 'Bennington');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (7, 11, 'Franklin');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (8, 9, 'Essex');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (9, 15, 'Lamoille');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (10, 5, 'Caledonia');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (11, 17, 'Orange');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (12, 23, 'Washington');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (13, 21, 'Rutland');
INSERT INTO vt_county ("countyId", "govCountyId", "countyName") VALUES (14, 1, 'Addison');

ALTER TABLE ONLY vt_county
    ADD CONSTRAINT "vt_county_govCountyId_key" UNIQUE ("govCountyId");

ALTER TABLE ONLY vt_county
    ADD CONSTRAINT vt_county_pkey PRIMARY KEY ("countyId");
