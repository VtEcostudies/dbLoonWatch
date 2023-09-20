--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

-- Started on 2023-09-20 13:34:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS loonweb;
--
-- TOC entry 3957 (class 1262 OID 76453)
-- Name: loonweb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE loonweb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';


ALTER DATABASE loonweb OWNER TO postgres;

\connect loonweb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 90789)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 940 (class 1255 OID 92084)
-- Name: valid_email(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.valid_email(e_mail text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
BEGIN
	IF (e_mail ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$')
	THEN RETURN email;
	ELSE RETURN null;
	END IF;
END;
$_$;


ALTER FUNCTION public.valid_email(e_mail text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 92508)
-- Name: loonwatch_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loonwatch_event (
    lweventid integer NOT NULL,
    lweventwaterbodyid text NOT NULL,
    lweventtownid integer,
    lweventdate date NOT NULL,
    lweventobserveremail text[],
    lweventobservername text[],
    lweventobservercount integer,
    lweventstart time without time zone,
    lweventstop time without time zone,
    lweventcomment text,
    lweventsketchurl text
);


ALTER TABLE public.loonwatch_event OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 92506)
-- Name: loonwatch_event_lweventid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loonwatch_event_lweventid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loonwatch_event_lweventid_seq OWNER TO postgres;

--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 212
-- Name: loonwatch_event_lweventid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loonwatch_event_lweventid_seq OWNED BY public.loonwatch_event.lweventid;


--
-- TOC entry 215 (class 1259 OID 92709)
-- Name: loonwatch_ingest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loonwatch_ingest (
    lwingestlocation text NOT NULL,
    lwingesttownname text NOT NULL,
    lwingestobservername text,
    lwingestdate date NOT NULL,
    lwingeststart time without time zone,
    lwingeststop time without time zone,
    lwingestadult integer DEFAULT 0,
    lwingestchick integer DEFAULT 0,
    lwingestsubadult integer DEFAULT 0,
    lwingestsurvey integer,
    lwingestcomment text
);


ALTER TABLE public.loonwatch_ingest OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 92529)
-- Name: loonwatch_observation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loonwatch_observation (
    lwobseventid integer NOT NULL,
    lwobstime time without time zone,
    lwobsgeolocation public.geometry(Geometry,4326),
    lwobsadult integer DEFAULT 0,
    lwobsadultphotourl text[],
    lwobssubadult integer DEFAULT 0,
    lwobssubadultphotourl text[],
    lwobschick integer DEFAULT 0,
    lwobschickphotourl text[],
    lwobsloonlocationdirection text,
    lwobseagle text,
    lwobsosprey text,
    lwobsother text
);


ALTER TABLE public.loonwatch_observation OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 90751)
-- Name: vt_county; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vt_county (
    "countyId" integer NOT NULL,
    "govCountyId" integer,
    "countyName" character varying(50) NOT NULL
);


ALTER TABLE public.vt_county OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 90719)
-- Name: vt_loon_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vt_loon_locations (
    locationname text,
    locationtown text,
    locationregion text,
    locationarea integer,
    waterbodyid text,
    locationtownid integer,
    exportname text
);


ALTER TABLE public.vt_loon_locations OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 90766)
-- Name: vt_town; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vt_town (
    "townId" integer NOT NULL,
    "townName" character varying(50) NOT NULL,
    "townCountyId" integer NOT NULL,
    "townAlias" text
);


ALTER TABLE public.vt_town OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 90727)
-- Name: vt_water_body; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vt_water_body (
    wbtextid text NOT NULL,
    wbofficialname text,
    wbtownname text,
    wbregion text,
    wbarea integer,
    wbbasinarea integer,
    wbelevation integer,
    wbmaxdepth integer,
    wbmeandepth integer,
    wboutlettype text,
    wbfullname text,
    wbtype text,
    wbcenterlatitude numeric,
    wbcenterlongitude numeric,
    wbgeocentroid public.geometry(Geometry,4326),
    wbgeoborder public.geometry(Geometry,4326)
);


ALTER TABLE public.vt_water_body OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 92765)
-- Name: loonwatch_sampling_event; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.loonwatch_sampling_event AS
 SELECT ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) AS "eventID",
    'Area Survey'::text AS "samplingProtocol",
    'Observer Time'::text AS "samplingEffort",
    ll.locationarea AS "sampleSizeValue",
    'Acre'::text AS "sampleSizeUnit",
    li.lwingestdate AS "eventDate",
    date_part('year'::text, li.lwingestdate) AS year,
    date_part('month'::text, li.lwingestdate) AS month,
    date_part('day'::text, li.lwingestdate) AS day,
        CASE
            WHEN (li.lwingeststart IS NOT NULL) THEN
            CASE
                WHEN (li.lwingeststop IS NOT NULL) THEN (((li.lwingeststart)::text || '/'::text) || (li.lwingeststop)::text)
                ELSE (li.lwingeststart)::text
            END
            ELSE NULL::text
        END AS "eventTime",
    date_part('doy'::text, li.lwingestdate) AS "startDayOfYear",
    'United States of America'::text AS country,
    'USA'::text AS "countryCode",
    'Vermont'::text AS "stateProvince",
    vt_county."countyName" AS county,
    ll.locationtown AS municipality,
    ll.waterbodyid AS "locationID",
    ll.waterbodyid AS "waterBody",
    wb.wbcenterlatitude AS "decimalLatitude",
    wb.wbcenterlongitude AS "decimalLongitude",
    'WGS84'::text AS "geodeticDatum",
    10 AS "coordinateUncertaintyInMeters",
    'Event'::text AS type,
    'VCE'::text AS "ownerInstitutionCode",
    li.lwingestcomment AS "eventRemarks"
   FROM ((((public.loonwatch_ingest li
     JOIN public.vt_loon_locations ll ON ((ll.locationname = li.lwingestlocation)))
     JOIN public.vt_water_body wb ON ((wb.wbtextid = ll.waterbodyid)))
     JOIN public.vt_town ON ((ll.locationtownid = vt_town."townId")))
     JOIN public.vt_county ON ((vt_town."townCountyId" = vt_county."govCountyId")))
  ORDER BY ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname));


ALTER TABLE public.loonwatch_sampling_event OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 92794)
-- Name: loonwatch_sampling_occurrence; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.loonwatch_sampling_occurrence AS
 SELECT occ."eventID",
    occ."occurrenceID",
    occ."basisOfRecord",
    occ."recordedBy",
    occ."individualCount",
    occ."lifeStage",
    occ."occurrenceStatus",
    occ."scientificName",
    occ.kingdom,
    occ.phylum,
    occ.class,
    occ."order",
    occ.family,
    occ."taxonRank",
    occ.type,
    occ."ownerInstitutionCode"
   FROM ( SELECT ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) AS "eventID",
            (((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) || '-Ad'::text) AS "occurrenceID",
            'HumanObservation'::text AS "basisOfRecord",
            li.lwingestobservername AS "recordedBy",
            li.lwingestadult AS "individualCount",
            'Adult'::text AS "lifeStage",
            'Present'::text AS "occurrenceStatus",
            'Gavia immer'::text AS "scientificName",
            'Animalia'::text AS kingdom,
            'Chordata'::text AS phylum,
            'Aves'::text AS class,
            'Gaviiformes'::text AS "order",
            'Gaviidae'::text AS family,
            'Species'::text AS "taxonRank",
            'Event'::text AS type,
            'VCE'::text AS "ownerInstitutionCode"
           FROM ((public.loonwatch_ingest li
             JOIN public.vt_loon_locations ll ON ((ll.locationname = li.lwingestlocation)))
             JOIN public.vt_water_body wb ON ((wb.wbtextid = ll.waterbodyid)))
          WHERE (li.lwingestadult > 0)
        UNION
         SELECT ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) AS "eventID",
            (((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) || '-SA'::text) AS "occurrenceID",
            'HumanObservation'::text AS "basisOfRecord",
            li.lwingestobservername AS "recordedBy",
            li.lwingestsubadult AS "individualCount",
            'SubAdult'::text AS "lifeStage",
            'Present'::text AS "occurrenceStatus",
            'Gavia immer'::text AS "scientificName",
            'Animalia'::text AS kingdom,
            'Chordata'::text AS phylum,
            'Aves'::text AS class,
            'Gaviiformes'::text AS "order",
            'Gaviidae'::text AS family,
            'Species'::text AS "taxonRank",
            'Event'::text AS type,
            'VCE'::text AS "ownerInstitutionCode"
           FROM ((public.loonwatch_ingest li
             JOIN public.vt_loon_locations ll ON ((ll.locationname = li.lwingestlocation)))
             JOIN public.vt_water_body wb ON ((wb.wbtextid = ll.waterbodyid)))
          WHERE (li.lwingestsubadult > 0)
        UNION
         SELECT ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) AS "eventID",
            (((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) || '-Ch'::text) AS "occurrenceID",
            'HumanObservation'::text AS "basisOfRecord",
            li.lwingestobservername AS "recordedBy",
            li.lwingestchick AS "individualCount",
            'Chick'::text AS "lifeStage",
            'Present'::text AS "occurrenceStatus",
            'Gavia immer'::text AS "scientificName",
            'Animalia'::text AS kingdom,
            'Chordata'::text AS phylum,
            'Aves'::text AS class,
            'Gaviiformes'::text AS "order",
            'Gaviidae'::text AS family,
            'Species'::text AS "taxonRank",
            'Event'::text AS type,
            'VCE'::text AS "ownerInstitutionCode"
           FROM ((public.loonwatch_ingest li
             JOIN public.vt_loon_locations ll ON ((ll.locationname = li.lwingestlocation)))
             JOIN public.vt_water_body wb ON ((wb.wbtextid = ll.waterbodyid)))
          WHERE (li.lwingestchick > 0)
        UNION
         SELECT ((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) AS "eventID",
            (((((date_part('year'::text, li.lwingestdate) || '-'::text) || upper(ll.exportname)) || '-'::text) || row_number() OVER (PARTITION BY (date_part('year'::text, li.lwingestdate)), ll.exportname ORDER BY (date_part('year'::text, li.lwingestdate)), ll.exportname)) || '-00'::text) AS "occurrenceID",
            'HumanObservation'::text AS "basisOfRecord",
            li.lwingestobservername AS "recordedBy",
            0 AS "individualCount",
            NULL::text AS "lifeStage",
            'Absent'::text AS "occurrenceStatus",
            'Gavia immer'::text AS "scientificName",
            'Animalia'::text AS kingdom,
            'Chordata'::text AS phylum,
            'Aves'::text AS class,
            'Gaviiformes'::text AS "order",
            'Gaviidae'::text AS family,
            'Species'::text AS "taxonRank",
            'Event'::text AS type,
            'VCE'::text AS "ownerInstitutionCode"
           FROM ((public.loonwatch_ingest li
             JOIN public.vt_loon_locations ll ON ((ll.locationname = li.lwingestlocation)))
             JOIN public.vt_water_body wb ON ((wb.wbtextid = ll.waterbodyid)))
          WHERE ((COALESCE(li.lwingestadult, 0) = 0) AND (COALESCE(li.lwingestsubadult, 0) = 0) AND (COALESCE(li.lwingestchick, 0) = 0))) occ
  ORDER BY occ."occurrenceID";


ALTER TABLE public.loonwatch_sampling_occurrence OWNER TO postgres;

--
-- TOC entry 3773 (class 2604 OID 92511)
-- Name: loonwatch_event lweventid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_event ALTER COLUMN lweventid SET DEFAULT nextval('public.loonwatch_event_lweventid_seq'::regclass);


--
-- TOC entry 3949 (class 0 OID 92508)
-- Dependencies: 213
-- Data for Name: loonwatch_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.loonwatch_event VALUES (1, 'ABENAKI', 131, '2023-09-10', '{ehanson@vtecostudies.org,jloomis@vtecostudies.org}', NULL, NULL, '08:00:00', '09:00:00', NULL, NULL);


--
-- TOC entry 3951 (class 0 OID 92709)
-- Dependencies: 215
-- Data for Name: loonwatch_ingest; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, 'nesting');
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2011-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2011-07-15', NULL, NULL, 2, 2, NULL, 1, 'Friday pm');
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2011-07-16', NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', 'Henry', '2011-07-16', '15:00:00', NULL, 0, 0, NULL, 1, 'henry 3 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Blake', 'Sheffield', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bliss', 'Calais', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2011-07-16', NULL, NULL, 0, 0, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2011-07-16', '15:00:00', NULL, 2, 1, 0, 1, '3pm');
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2011-07-16', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bristol (Winona)', 'Bristol', NULL, '2011-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2011-07-16', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, '1 ad flew off 8am (to Tildy?); 2 eggs in nest');
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 2, 0, 1, 1, '1 ad flew time??');
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', 'Beth', '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '1 at 11 am Beth');
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2011-07-16', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '1 ad 10 am might have flown in from Bruce so not counted.');
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '1 ad flew in 4 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', 'Connie Barton', '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '0 Connie Barton');
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', 'Peg Chaffee', '2011-07-16', NULL, NULL, 1, 0, NULL, 1, 'Peg Chaffee???? Contact');
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2011-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Duck (Craftsbury)', 'Craftsbury', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2011-07-16', NULL, NULL, 0, 0, 2, 1, 'lost pair?');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, '3rd loon flying 9:35, 2 ad obs 8:50');
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Emerald', 'Dorset', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, 'no loons obs by park ranger');
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', 'Jim Wilson', '2011-07-16', NULL, NULL, 2, 0, NULL, 1, 'Jim Wilson obs 3 ad time? Roosa''s retired? Or 2012');
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '40748');
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, 'heard another one; not there on return trip');
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2011-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2011-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2011-07-16', NULL, NULL, 5, 0, NULL, 1, 'Possibly 2 double counted (tally as 5 not 7); no chick obs.w/ inlet pair');
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2011-07-16', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2011-07-16', NULL, NULL, 9, 2, NULL, 1, 'likely missed 1 chick');
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2011-07-16', NULL, NULL, 4, 3, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', 'Henry', '2011-07-16', '17:50:00', NULL, 1, 0, NULL, 1, '1 ad 5:50 pm henry; 1 ad 7:15 am vycc');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2011-07-16', NULL, NULL, 0, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2011-07-16', NULL, NULL, 1, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '2nd hand report');
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2011-07-16', NULL, NULL, 3, 1, NULL, 1, '513 shoreline road');
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2011-07-16', NULL, NULL, 6, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2011-07-16', NULL, NULL, 7, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2011-07-16', NULL, NULL, 5, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '1 ad flyover');
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Elmore', 'Elmore', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2011-07-16', NULL, NULL, 4, 0, NULL, 1, '1 ad flew over at 9:30 am');
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, '1 ad flew over');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower (Hinesburg)', 'Hinesburg', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2011-07-16', NULL, NULL, 5, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2011-07-16', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marl', 'Sutton', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2011-07-16', NULL, NULL, 2, 2, NULL, 1, '1 flew 8:30 ese');
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2011-07-16', NULL, NULL, 6, 0, NULL, 1, 'possibly 4 loons;  2 flew east at 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, '4 ad s and w of islands');
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mill', 'Windsor', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, 'vol documentation');
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2011-07-16', NULL, NULL, 4, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2011-07-16', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2011-07-16', NULL, NULL, 2, 2, NULL, 1, 'chick stashed; killed next day');
INSERT INTO public.loonwatch_ingest VALUES ('North Montpelier', 'East Montpelier', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2011-07-16', NULL, NULL, 6, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2011-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2011-07-16', NULL, NULL, 11, 3, NULL, 1, 'also 2 ad joan hudson');
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2011-07-16', NULL, NULL, 2, 2, NULL, 1, 'possibly 13 ad');
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, 'check with Jean roberts');
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2011-07-16', NULL, NULL, 0, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2011-07-16', NULL, NULL, 3, 2, NULL, 1, '1 ad Friday');
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2011-07-16', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2011-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2011-07-16', NULL, NULL, 8, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, 'Coordinate with Charles Woods ');
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2011-07-16', NULL, NULL, 7, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2011-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2011-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2011-07-16', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, 'possibly 3 ad only');
INSERT INTO public.loonwatch_ingest VALUES ('Toad', 'Charleston', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2011-07-16', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2011-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2011-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2011-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2011-07-16', NULL, NULL, 11, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2011-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2011-07-15', NULL, NULL, 2, 1, NULL, 1, 'Friday obs.');
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2011-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2011-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ball Mountain', 'Jamaica', 'C Davis', '2012-07-20', NULL, NULL, 0, 0, NULL, 1, '7/20 c davis');
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', 'Henry', '2012-07-21', '15:30:00', NULL, 0, 0, NULL, 1, 'henry 3:30 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2012-07-21', NULL, NULL, 3, 0, 3, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bliss', 'Calais', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', 'Henry', '2012-07-21', '18:30:00', NULL, 2, 1, NULL, 1, 'henry 6:30 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', 'Henry', '2012-07-21', '16:30:00', NULL, 0, 0, NULL, 1, 'henry 4:30 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, 'nest; 1 flew over ');
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 5, 0, NULL, 1, '1 flew in 9 am');
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2012-07-21', NULL, NULL, 2, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', 'Marshalls', '2012-07-21', NULL, NULL, 1, 0, NULL, 1, 'Marshalls');
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2012-07-21', NULL, NULL, 3, 2, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', 'Johnny', '2012-07-22', NULL, NULL, 0, 0, NULL, 1, '7/22 johnny');
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2012-07-21', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', 'Liz', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'Liz');
INSERT INTO public.loonwatch_ingest VALUES ('Cranberry Meadow', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cutter', 'Williamstown', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, '8:45 1 flew, then 2 flew over');
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2012-07-21', NULL, NULL, 6, 2, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2012-07-21', NULL, NULL, 7, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2012-07-21', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2012-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2012-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2012-07-21', NULL, NULL, 4, 1, NULL, 1, '6a 1c on 7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2012-07-21', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2012-07-21', NULL, NULL, 9, 3, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Griffith', 'Peru', 'Richard Andrews', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'Richard Andrews');
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2012-07-21', NULL, NULL, 6, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', 'Henry', '2012-07-21', '14:00:00', NULL, 0, 0, NULL, 1, '2 pm henry');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2012-07-21', NULL, NULL, 1, 1, 0, 1, 'Check for chick');
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', 'Henry', '2012-07-20', NULL, NULL, 1, 0, NULL, 1, '7-20 henry');
INSERT INTO public.loonwatch_ingest VALUES ('Hartland dam', 'Hartland', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2012-07-21', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', 'Linda Mcelvany', '2012-07-20', NULL, NULL, 0, 0, NULL, 1, '7/20 linda mcelvany');
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2012-07-21', NULL, NULL, 7, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2012-07-21', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lamoille', 'Hyde Park', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', 'Marshals', '2012-07-21', NULL, NULL, 1, 0, NULL, 1, '7/20 Rachel, 7/21 1 a marshals');
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2012-07-21', NULL, NULL, 7, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Rock', 'Wallingford', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2012-07-21', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2012-07-21', NULL, NULL, 7, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', 'Martha Gordon', '2012-07-21', NULL, NULL, 4, 0, NULL, 1, 'martha gordon');
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', 'Eric', '2012-07-21', NULL, NULL, 2, 0, NULL, 1, 'eric');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2012-07-21', NULL, NULL, 8, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2012-07-21', NULL, NULL, 3, 2, NULL, 1, 'possibly missed south pair');
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', 'Liz', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'liz');
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2012-07-21', NULL, NULL, 0, 0, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2012-07-21', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', 'Baea', '2012-07-21', NULL, NULL, 4, 0, NULL, 1, 'baea');
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2012-07-21', NULL, NULL, 8, 4, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', 'Marshall', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'marshall');
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2012-07-21', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2012-07-21', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', 'Karen Dusini', '2012-07-21', NULL, NULL, 11, 0, NULL, 1, 'karen dusini');
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pleiad', 'Hancock', 'Henry', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'henry');
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, '1 ad 7/18');
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', 'Charles|Denis', '2012-07-30', NULL, NULL, 9, 2, NULL, 1, '7/30 charles and denis');
INSERT INTO public.loonwatch_ingest VALUES ('Sherman Reservoir', 'Whitingham', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2012-07-21', NULL, NULL, 6, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', 'Marshall', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'marshall');
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2012-07-21', NULL, NULL, 6, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Star', 'Mount Holly', 'Bob Tucker', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'bob tucker');
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', 'LIz', '2012-07-21', NULL, NULL, 1, 0, NULL, 1, 'liz');
INSERT INTO public.loonwatch_ingest VALUES ('Stoughton', 'Weathersfield', 'Julie Lloyd Wright', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'julie lloyd wright');
INSERT INTO public.loonwatch_ingest VALUES ('Stratton', 'Stratton', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2012-07-21', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', 'Janet Steward', '2012-07-21', NULL, NULL, 2, 1, NULL, 1, 'janet steward');
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Toad', 'Charleston', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Townshend Res.', 'Townshend', 'Charles Davis', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'charles davis');
INSERT INTO public.loonwatch_ingest VALUES ('Twin', 'Brookfield', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', 'Charles Davis', '2012-07-21', NULL, NULL, 2, 0, NULL, 1, 'charles davis');
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', 'Liz', '2012-07-21', NULL, NULL, 1, 0, NULL, 1, 'liz');
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', 'Rollin Tebbets|Wiesen', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'rollin tebbets, wiesen, ');
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2012-07-21', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2012-07-21', NULL, NULL, 5, 0, NULL, 1, 'choppy north 1/2 - could have missed many');
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2012-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2012-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2012-07-21', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2012-07-21', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', 'Roy Pilcher', '2012-07-21', NULL, NULL, 0, 0, NULL, 1, 'roy pilcher');
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2012-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2012-07-21', NULL, NULL, 9, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2012-07-21', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2013-07-20', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, 'flying during the hour');
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', 'Chris Owen', '2013-07-20', NULL, NULL, 2, 0, 0, 1, 'Chris owen; incubating');
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', 'Eric', '2013-07-19', NULL, NULL, 0, 0, 0, 1, 'eric 7/19');
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2013-07-20', NULL, NULL, 1, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bliss', 'Calais', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2013-07-19', NULL, NULL, 0, 0, 0, 1, 'wavy 7/19');
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, 'keep jeff rand on list');
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, '19-Jul');
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2013-07-21', NULL, NULL, 1, 0, 0, 1, '7/21 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2013-07-20', '19:00:00', NULL, 0, 0, 0, 1, 'sat. 7 pm, Friday pm 3ad terry');
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, 'incubating');
INSERT INTO public.loonwatch_ingest VALUES ('Cole', 'Jamaica', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, '16-Jul');
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cranberry Meadow', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', 'Ellen', '2013-07-20', '05:30:00', NULL, 2, 0, 0, 1, 'ellen 5:30 am, stan did survey- results?');
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2013-07-20', NULL, NULL, 5, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, '1 ad flying 30 min after obs. 2A');
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2013-07-20', NULL, NULL, 3, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2013-07-20', NULL, NULL, 3, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2013-07-20', NULL, NULL, 6, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2013-07-20', NULL, NULL, 11, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', 'Sarah Hingston', '2013-07-20', NULL, NULL, 2, 1, 0, 1, 'sarah hingston 2a 1 c');
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2013-07-20', NULL, NULL, 7, 0, 0, 1, '1');
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', 'Frank Thompson', '2013-07-20', NULL, NULL, 0, 0, 0, 1, 'Frank thompson');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, 'keep sheila lapoing on list');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, '7/21 2 ad 3 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', 'Henry', '2013-07-19', NULL, NULL, 1, 0, 0, 1, 'Friday henry; 7/21 0 ruth stewart partial survey');
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', 'Amelia Fritze', '2013-07-20', NULL, NULL, 1, 0, 0, 1, 'Amelia fritze');
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2013-07-20', NULL, NULL, 2, 1, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', 'Chris Owen', '2013-07-20', NULL, NULL, 4, 0, 0, 1, '4 ad chris owen; 6 ad listed by Lauren - not sure source; change back to 6 if locate');
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', NULL, '2013-07-21', NULL, NULL, 0, 0, 0, 1, 'Sunday');
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2013-07-21', '08:00:00', NULL, 0, 0, 0, 1, '8 am 7/21 Sunday');
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', 'Marshall', '2013-07-20', NULL, NULL, 8, 1, 0, 1, 'marshall');
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2013-07-20', NULL, NULL, 4, 3, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', 'Cindy Grimes', '2013-07-20', NULL, NULL, 2, 1, 0, 1, 'cindy grimes');
INSERT INTO public.loonwatch_ingest VALUES ('Lamoille', 'Hyde Park', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', 'Marshall', '2013-07-20', NULL, NULL, 2, 0, 0, 1, 'Marshall; 1 ad Friday rachel');
INSERT INTO public.loonwatch_ingest VALUES ('Lily', 'Poultney', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little (Wells)', 'Wells', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2013-07-20', NULL, NULL, 9, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', 'Tom Wells|Linda Wells', '2013-07-20', NULL, NULL, 1, 0, 0, 1, 'tom and linda wells surveyed; cannot find data sheet');
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', 'Eric', '2013-07-20', '12:00:00', NULL, 0, 0, 0, 1, 'eric 12 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', 'Phyllis', '2013-07-20', NULL, NULL, 2, 2, 0, 1, '1 phyllis');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, '1 flyover');
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2013-07-20', NULL, NULL, 5, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2013-07-20', NULL, NULL, 4, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2013-07-22', NULL, NULL, 3, 0, 1, 1, '7/22 1st calm water since 7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2013-07-20', NULL, NULL, 5, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, 'chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2013-07-20', NULL, NULL, 5, 1, 0, 1, 'Rollin 2A 1C, rick scholes 5A 1ch');
INSERT INTO public.loonwatch_ingest VALUES ('Monkton (Cedar)', 'Monkton', 'Eric', '2013-07-19', NULL, NULL, 0, 0, 0, 1, 'eric 7/19');
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2013-07-20', NULL, NULL, 1, 0, 1, 1, '3-7 usual, one day 9');
INSERT INTO public.loonwatch_ingest VALUES ('Moses', 'Weston', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', 'Lauren', '2013-07-20', NULL, NULL, 0, 0, 0, 1, 'Lauren obs');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2013-07-20', NULL, NULL, 1, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norford', 'Thetford', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2013-07-20', NULL, NULL, 11, 4, 0, 1, '1 ad south end incubating');
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2013-07-20', NULL, NULL, 14, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pleiad', 'Hancock', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, 'no sightings for a month');
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, 'chicks missing');
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sadawga', 'Whitingham', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2013-07-20', NULL, NULL, 10, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', 'Kane-Rohloff', '2013-07-20', NULL, NULL, 3, 1, 0, 1, '2a 1 ch Kane-Rohloff, 1 ad loretta');
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2013-07-20', NULL, NULL, 8, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2013-07-20', NULL, NULL, 4, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', 'Eric', '2013-07-19', NULL, NULL, 1, 0, 0, 1, '7/19 eric');
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', 'Jean Roberts', '2013-07-20', NULL, NULL, 0, 0, 0, 1, 'jean roberts');
INSERT INTO public.loonwatch_ingest VALUES ('Star', 'Mount Holly', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, 'mid a.m.');
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', 'Lauren', '2013-07-20', NULL, NULL, 3, 0, 0, 1, 'Lauren obs.; 0 kane-rohloff');
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Toad', 'Charleston', 'Chris Owen', '2013-07-20', NULL, NULL, 2, 0, 0, 1, 'chris owen');
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2013-07-20', NULL, NULL, 1, 2, 0, 1, 'windy');
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, 'bob tucker did survey, not marie haskins');
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', 'Bob Tucker', '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, 'east arm and south');
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2013-07-20', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2013-07-20', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2013-07-20', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2013-07-20', NULL, NULL, 6, 0, 0, 1, '10 Ad on Friday');
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2013-07-20', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2013-07-20', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2013-07-20', NULL, NULL, 2, 1, 0, 1, '1');
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2013-07-20', NULL, NULL, 3, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Abenaki', 'Thetford', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2014-07-19', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2014-07-19', NULL, NULL, 0, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, '0 by Thompson');
INSERT INTO public.loonwatch_ingest VALUES ('Bliss', 'Calais', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2014-07-19', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2014-07-19', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chipman (Tinmouth)', 'Tinmouth', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2014-07-19', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cole', 'Jamaica', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cranberry Meadow', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Danby', 'Danby', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Deweys Mill', 'Hartford', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2014-07-19', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', 'Isobel', '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, 'Angela checked again for chick 8/9, no chick');
INSERT INTO public.loonwatch_ingest VALUES ('Emerald', 'Dorset', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2014-07-19', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2014-07-19', NULL, NULL, 8, 3, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2014-07-19', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2014-07-19', NULL, NULL, 10, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2014-07-19', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Hartland dam', 'Hartland', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2014-07-19', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2014-07-19', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', 'Isobel', '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'check location');
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, 'ebird');
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2014-07-19', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2014-07-19', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2014-07-19', NULL, NULL, 5, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Elmore', 'Elmore', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2014-07-19', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2014-07-19', NULL, NULL, 7, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2014-07-19', NULL, NULL, 2, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2014-07-19', NULL, NULL, 10, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2014-07-19', NULL, NULL, 5, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2014-07-19', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Monkton (Cedar)', 'Monkton', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', 'Kellie', '2014-07-19', NULL, NULL, 0, NULL, 1, 1, '1 by Kellie, 2 by Angela');
INSERT INTO public.loonwatch_ingest VALUES ('Moses', 'Weston', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, '3-4 adults missing from the area - NH?');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2014-07-19', NULL, NULL, 8, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2014-07-19', NULL, NULL, 13, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pinneo', 'Hartford', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pleiad', 'Hancock', NULL, '2014-07-19', NULL, NULL, 1, NULL, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2014-07-19', NULL, NULL, 7, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2014-07-19', NULL, NULL, 8, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2014-07-19', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Star', 'Mount Holly', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'ebird');
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2014-07-19', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Toad', 'Charleston', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2014-07-19', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2014-07-19', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2014-07-19', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2014-07-19', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2014-07-19', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2014-07-19', NULL, NULL, 8, NULL, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2014-07-19', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2014-07-19', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2014-07-19', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2014-07-19', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2015-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, '7/20 Martha Gordon 1A1C');
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bliss', 'Calais', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, '7/?? Frank thompson 1A');
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2015-07-18', NULL, NULL, 14, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2015-07-18', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', 'Filiberti', '2015-07-19', NULL, NULL, 0, NULL, NULL, 1, '0 A 7/19 Filiberti');
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2015-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2015-07-18', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2015-07-18', NULL, NULL, 4, 2, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', 'Isobel', '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, 'Isobel');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2015-07-15', NULL, NULL, 2, 2, NULL, 1, '7/15 back up survey 2A2C?  Check');
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, 'Forest Lake (Nelson Pond) - Calais (133 acres)');
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2015-07-18', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2015-07-18', NULL, NULL, 5, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2015-07-18', NULL, NULL, 5, NULL, NULL, 1, '7/23 6A 3Ch 1SA Henrickson');
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2015-07-18', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, 'Male, Juvenile (1); Unknown Sex and Age (2); Female, Immature (1)'' ;Not sure if should accept');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', 'Isobel', '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2015-07-18', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', 'Isobel', '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, 'Isobel');
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2015-07-18', NULL, NULL, 3, 2, NULL, 1, '2A 2C 6:15 am David Eberly');
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little (Wells)', 'Wells', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2015-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Elmore', 'Elmore', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Rock', 'Wallingford', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, '7/18 7:15 am 2A Henry Marshal');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2015-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2015-07-18', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, 'done 7/18');
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', 'Isobel', '2015-07-18', NULL, NULL, 9, NULL, 2, 1, '7A don c. 2A2SA king');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2015-07-18', NULL, NULL, 4, NULL, 2, 1, 'possibly 2 more SA that flew off.  Counting 2 SA.');
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, 'Mollys Falls Reservoir');
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2015-07-18', NULL, NULL, 4, NULL, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, 'ebird has Forest lake as name');
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2015-07-18', NULL, NULL, 2, 2, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', 'isobel', '2015-07-13', NULL, NULL, 0, NULL, NULL, 1, '7/13Isobel ');
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2015-07-18', NULL, NULL, 6, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, 'often observe 3; report of 5 once');
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2015-07-18', NULL, NULL, 11, NULL, NULL, 1, '5 Ad Cindy Grimes from access 3 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, 'kit walker 1A 2C');
INSERT INTO public.loonwatch_ingest VALUES ('Perch (Benson)', 'Benson', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pleiad', 'Hancock', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2015-07-18', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2015-07-18', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2015-07-18', NULL, NULL, 10, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2015-07-13', NULL, NULL, 2, NULL, NULL, 1, '7/13 survey');
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2015-07-18', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, '3A total on perch, sunrise, sunset on 7/17.  2A on sunset/sunrise 7/19');
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2015-07-18', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, '1A on nest');
INSERT INTO public.loonwatch_ingest VALUES ('Tiny', 'Plymouth', 'Isobel', '2015-07-17', NULL, NULL, 1, NULL, NULL, 1, '7/17 1A Isobel');
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, 'Said they entered ebird - no entry found');
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2015-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, '0 north end');
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2015-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2015-07-18', NULL, NULL, 6, NULL, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2015-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2015-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2015-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2015-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2015-07-18', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Adams Res.', 'Woodford', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', 'Janet Dyer', '2016-07-14', NULL, NULL, 1, 1, NULL, 1, 'janet dyer on 7/14');
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2016-07-16', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Big (Woodford Lake)', 'Woodford', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', 'William Garrison', '2016-07-16', '08:15:00', NULL, 0, NULL, NULL, 1, 'William Garrison 0 8:15 a.m');
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, '1A flew in 8:20 am; chick gone or hiding');
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2016-07-16', NULL, NULL, 6, NULL, NULL, 1, '1 on nest; 1 flying but did not count in total in case one of previously observed');
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2016-07-16', NULL, NULL, 5, 3, NULL, 1, '3 in flight 80 minutes after 1st sighting.  Could be 1-3 extras? Count as 1 extra since unlikely 3 of 4 breeding adults all together.');
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2016-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2016-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crescent', 'Sharon', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, 'NEW lake');
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2016-07-17', NULL, NULL, 2, 2, NULL, 1, 'survey 7/17; 0 found in rain on 7/16');
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2016-07-16', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, 'Loon heard tremoloing in flight at 7:20 a.m.');
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, 'Flew in at 9:03 am');
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2016-07-16', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2016-07-16', NULL, NULL, 3, 1, NULL, 1, 'ebird report of 4; did not distinguish between adult and chick (one chick known to be on pond)');
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', 'Hanson|Willean', '2016-07-16', NULL, NULL, 9, 2, NULL, 1, 'hanson and willean');
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2016-07-16', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2016-07-19', NULL, NULL, 0, NULL, NULL, 1, 'Survey 7/19 check for others');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2016-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2016-07-22', NULL, NULL, 1, 2, NULL, 1, 'Survey 7/22 count 2Ad or not?');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, '7/16 survey 2A 1C');
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2016-07-16', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2016-07-16', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2016-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', 'Grace M', '2016-07-16', NULL, NULL, 2, 0, NULL, 1, 'Grace M.- 1A on nest, 1A in water afternoon survey');
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2016-07-16', NULL, NULL, 11, 1, NULL, 1, 'nest empty - no eggs');
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2016-07-16', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, '1 flew in 8:30, then flew off near 9 a.m.');
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little (Wells)', 'Wells', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2016-07-16', NULL, NULL, 9, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, '1A flew from pond 8 a.m');
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, '1 adult flying 7:30 am');
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2016-07-09', NULL, NULL, 7, 2, NULL, 1, 'july 9 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, 'missed - vol. ill');
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2016-07-16', NULL, NULL, 10, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, 'missed ');
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', 'Karen Lippens|Don C', '2016-07-16', NULL, NULL, 3, 0, NULL, 1, '1 Karen Lippens -south, 1 Don C - east, 8+1SA King west and north');
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Minards', 'Rockingham', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2016-07-16', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2016-07-16', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2016-07-16', NULL, NULL, 1, 0, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2016-07-16', NULL, NULL, 9, 5, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2016-07-16', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, '1 chick missed');
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Runnemede', 'Windsor', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sadawga', 'Whitingham', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2016-07-16', NULL, NULL, 9, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2016-07-16', NULL, NULL, 0, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shelburne', 'Shelburne', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, 'Charles woods had 11 adults');
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2016-07-16', NULL, NULL, 8, 3, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2016-07-16', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, 'still incubating');
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2016-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', 'Hanson', '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, 'hanson');
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2016-07-16', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2016-07-16', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2016-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, 'incubating; 2 ad flew 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2016-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2016-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2016-07-16', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2016-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2016-07-16', NULL, NULL, 2, NULL, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, 'missed - default');
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2016-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2016-07-16', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, 'flying 8:30 did not see land but not other water nearby so likely landed at some point');
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, 'missed');
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2016-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'no loons heard or seen');
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Brookfield)', 'Brookfield', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'Observed from shore for 45 minutes 2 adult loons 1 chick on parents back');
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'nesting site half in water');
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2017-07-15', NULL, NULL, 11, 1, NULL, 1, '2 diving, 1 diving and calling, 5 rafted up, 2 were sitting, adult and chick swimming slowly NW bay');
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'The nesting pair seemed interested in the nesting raft. "Cupping" activity was evident in the nesting bowl, but no egg shell fragments or sign of a chick was observed.');
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'Two adults and a newly hatched chick.');
INSERT INTO public.loonwatch_ingest VALUES ('Chipman (Tinmouth)', 'Tinmouth', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2017-07-15', NULL, NULL, 4, 4, NULL, 1, '2 adults & 2 chicks near eastern nesting raft, 2 adults & 2 chicks middle of western section just above Mountain Top cove');
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, '2 adults swimming together');
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'No loons observed');
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'surveyed entire pond ... no loons');
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, '2 adults & 1 chick (2 weeks old)');
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cranberry Meadow', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2017-07-15', NULL, NULL, 6, NULL, NULL, 1, 'Adults feeding north end of lake');
INSERT INTO public.loonwatch_ingest VALUES ('Danby', 'Danby', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, '2 Loons were fishing together, a 3rd one flew in and joined them, all adults');
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 4, 2, NULL, 1, 'One breeding pair with two, one month old chicks (hatched mid June), and 2 adult loons');
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, '5 birds seen. 4 being reported as onearly bird is likely to be the same individual. Mailing in the map of the lake where they were seen');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'Incubating??');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'No loons observed');
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2017-07-15', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'I Saw the male and female plus 2 chicks');
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2017-07-15', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Emerald', 'Dorset', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'We saw a nesting pair of loons with two chicks');
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2017-07-15', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, '2 adults and 1 chick feeding and diving');
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, 'We saw 1 loon in the southeast end of the lake off the sand beach., at 09:00. A second loon was sighted off the point on the south end of the lake at 09:10. A pair of loons as seen at the northwest end of the lake, at the nesting raft, at the northwest end of the lake, 1 was on the nest and slid off into the water while we were observing them. This was at 09:25. A total of 4 loons were seen. We also saw a bald eagle flying along the east shore near the south end, and 2 canada geese on the shore at waters edge, at the northwest end of the lake.');
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2017-07-15', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Abenaki', 'Thetford', NULL, '2018-07-20', NULL, NULL, 0, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, '3 ad on 7/23 michael foster');
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2018-07-20', NULL, NULL, 0, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2017-07-15', NULL, NULL, 12, 3, NULL, 1, 'Survey was done by 4 teams departing from the same location and  then surveying in 4 designated areas. Totals compiled avoiding any duplication. North (north of campsites 17-11) - near Loon Island, one adult and one chick; Central Area (south of campsites 17-11 and north of campsites 30-6) one adult; South East (south of campsites 30-6 and east of Big Island and campsite 1) 8 adults; South West (West of campsites 20-12, Big Island, and campsites 30-1, this area  includes Merganser Inlet and the Access Bay) 2 adults and 2 chicks. Detailed map with locations of each sighting sent by mail to Eric Hansen. The 12 adults seen are assumed to be the 4 breeding pairs, two of which produced chicks ,  and 4 visiting adults. Survey done by members of the Friends of Green River Board - Charlotte and Tom Kastner, Sheila Goss, Ronald Kelley, and Sally Laughlin.');
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'One on nest, one SE lake.');
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2017-07-15', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'For info on the First adult see comments  under the photo submitted. The second adult was seen in the middle of the pond favoring the northern end.');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, 'Assume saw at least 1A and 1C');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartland dam', 'Hartland', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'Not sure - misentry into ebird');
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, '2 adults and one chick in western area of lake. One adult on east side of lake.');
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, 'Seven loons observed in total, including two pair on Holland Pond, plus a pair and a chick at Beaver Pond.  No loons seen on Turtle or Round Ponds, all in the town of Holland.  No successful loon nesting on Holland Pond this year.  Southern pair have not taken to nesting raft; northern pair attempted but nest bowl was flooded by rain storm in June.');
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'scanned entire reservoir but no sighting today, had seen and VT ebird-reported a single adult loon here during the previous week');
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'Unsure if 2A and 1C or 1A and 2C; also check if Island Pond or not');
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2017-07-15', NULL, NULL, 4, 1, NULL, 1, '1 adult and 1 chick nw Joe''s Pond at 8:16am, 2 adults sited at south side of 3rd pond at 8:40am, 1 adult sited so side of Priests island at 9:29a,');
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, '1 adult Loon.  I heard it calling earlier in the day, prior to observing.  Also saw it by itself in the afternoon.  kept watch to see if any more Loons might arrive on the pond.  Loon called off and on earlier in the day.');
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2017-07-15', NULL, NULL, 3, 1, NULL, 1, 'Initially observed (2) adult loons and (1) juvenile on the southwest side of the pond.  A third adult approached from the north end of the pond.  The two original adults left the juvenile close to shore and appeared to escort the 3rd adult away, to the north.  Some aggression was witnessed, for the third adult appeared to be an intruder.  Shortly thereafter, the two original adults swan south on western shore toward juvenile.  The third, (or intruder) seems to be no where in sight now.');
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, 'Possible 2nd adult on nest. EH');
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2017-07-15', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'Loon (1) floating, fishing at boat access.  Loon (2) off nest initially, floating just west of large island for about 10 minutes then on nest for remainder of survey');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'The adult loon pair were hanging out at the further end of the pond from the nesting site. One often dove for fish and mostly vegetation a gave it to the other. The other had a small chick on its back.  Intermittent calls, non-threatening. One bald eagle did fly around but did not bother them. Same with the geese.');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2017-07-15', NULL, NULL, 9, NULL, NULL, 1, 'Found one loon on the east shore near state day use area.  Spotted six loons together toward the west shore about mid-way down the lake. Two more seen near the island in the middle south end.  One loon see flying from south to north.');
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2017-07-15', NULL, NULL, 6, NULL, NULL, 1, 'Check Don and others?');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'Observed 2 loons,  One in the water and the other on a nest.  Loons have been on this nest since May 18.');
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mill', 'Windsor', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Minards', 'Rockingham', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, '2 Loons sighted at SW portion of pond.  No apparent nesting.  Fishing together and some courting behavior.   Chased duck away.');
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2017-07-15', NULL, NULL, 5, 2, NULL, 1, '5 adults & 2 chicks; the chicks were with a single adult; all loons observed in the center of the entire pond, i.e. not at the Route 2 boat launch or at the far south end where the river is. Adult and 2 chicks swimming south on western shore; 2 swimming adults just lateral to this family but equidistant from west/east shores (center of pond); 2 adults slightly more north of aforementioned loons in deep water diving & surfacing.');
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'No loons seen or heard');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', 'Kirsti Carr', '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, 'Kirsti Carr observed 1 adult at 9:07');
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, '2 adults in main pond');
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, '2 adults and 2 chicks feeding in front of our camp.  very foggy');
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, '0A anna autillo ebird');
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, 'possible chick just hatched');
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'I saw two adult loons and a chick in the western and west-central part of the lake.  First I heard a call, then I saw one adult, then another call near the shore and when I kayaked over, it was the other adult (presumably mother?) with the chick. She would make a soothing sort of coo sometimes, a sound I''d never heard. Then they swam over to the other adult and after that they all swam together, except when the adults would dive and come up a distance away, then swim back to the chick. The chick took a couple of brief dives too.  They are so beautiful!  I was the only a human on the lake, privileged to be with the loon family.');
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2017-07-15', NULL, NULL, 12, 3, NULL, 1, 'There were 3 breeding/ nesting pairs on the lake, and many lone individuals.');
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, 'No loons seen during the observation period from eastern shore.');
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2017-07-15', NULL, NULL, 6, NULL, NULL, 1, '2 that appear to be the pair usually on North arm of lake were near dam. Other 4 together in SW cove but also seen all along southern shore.');
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'Two adult loons and two recently hatched chicks were observed swimming, feeding and diving.');
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, 'Flew in near red bridge. After a few minutes it dived down and then came up about 250 feet from me (you could imagine my surprise). It groomed itself as I sat there and it gave a wail twice. I paddled parallel until it was behind me as I went back to the boat ramp. I heard it wail one more time but no one answered it.');
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'Observed family of common loons (2 juveniles, 2 adults) from 8:35 to 10:40 AM on 7/15/17, swimming, diving, & floating. I was unable to pinpoint their nest, but an artificial nest platform was seen in an area of Ricker Pond where loons nested in 2015 successfully. One adult "hooted" (sounding like "woo-oo") probably to the 2 juveniles; another time one adult rose out of the water and flapped its wings. One adult came within about 10 feet of a canoe with 2 paddlers. Weather was cloudy with sunbreaks and light airs to breezes; 60s air temperature (F).');
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Newbury)', 'Newbury', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Runnemede', 'Windsor', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sadawga', 'Whitingham', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, 'Saw 3 adult loons feeding together out on lake in the southeast quadrant, 1 adult loon feeding alone toward center of lake not too far from the other 3, and 1 adult loon flew over our head in the direction of little lake salem');
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2017-07-15', NULL, NULL, 10, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'one on lake and one on nest');
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shelburne', 'Shelburne', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, '1 Adult was on the nest,  Another adult was away from the nest on the lake.');
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2017-07-15', NULL, NULL, 6, 2, NULL, 1, '1 adult prior to narrows, 2 adults Dandeneau cove 1 on the nest, 1 adult NW trib, 2 adults and 2 chicks NE trib');
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'From my kayak I, observed 2 adult loons and 2 chicks (about 1 month old). They were in the SE area of the pond. Both parents were somewhat distant from the 2 chicks.');
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, 'lone adult in middle of south bay');
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2017-07-15', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, 'two adults out on the water, seen fishing most of the time I was there. No chicks seen.');
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2017-07-15', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stoughton', 'Weathersfield', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, 'pair of loons and one chick , NE cove in fog');
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, '1 adult and 1 chick');
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2017-07-15', NULL, NULL, 2, 1, NULL, 1, '2 adults and one 4-week old chick initially observed resting near mid-western shore. All gradually made their way toward center of reservoir, where parents started diving for food and then feeding the chick. Chick was also observed diving for short periods of time. After ~ one hour, adults were alerted to an eagle, which was soaring high over the area. After wailing for a short time, the eagle flew out of view. Shortly after, the adults wailed again, where upon an osprey flew over the water and perched on tree at far northern shore. Loons did not vocalize again before I left. Osprey was still perched on same tree when I departed.');
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'observed 2 adults and 2 chicks');
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, 'breeding pair with two chicks hatched in last 48 hours');
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2017-07-15', NULL, NULL, 4, NULL, NULL, 1, 'Three adults together, talking quietly to each other, not far from dam.');
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2017-07-15', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2017-07-15', NULL, NULL, 5, 1, NULL, 1, '5 adults , 1 juvenille');
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2017-07-15', NULL, NULL, 2, NULL, NULL, 1, '2 adults swimming on NW shore, within site of boat launch. One called to the other. they were diving, 20-50 secs in duration. occasionally they floated next to each other and bobbed their heads together, like they were kissing each other. Also, when they were side by side, they one time quickly and repeatedly duck their heads in & out of the water.  At 9:40, when we were leaving the pond, we couls hear one of them call, but could not see them.  EH note: possible intruder, 2 chicks on the pond but not observed');
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2017-07-15', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2017-07-15', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2017-07-15', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2018-07-21', NULL, NULL, 1, 1, NULL, 1, '3A on ebird at 7pm');
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2018-07-21', NULL, NULL, 3, 0, NULL, 1, '7/18/2018 1A');
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2018-07-21', NULL, NULL, 0, NULL, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2018-07-20', NULL, NULL, 1, NULL, NULL, 1, '7/20/2018, 1A 7/22 Noah Kahn and 7/19 Emenaker');
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2018-07-21', NULL, NULL, 13, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, '0 Ad Ellen Valley');
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2018-07-21', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, 'from shore');
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2018-07-21', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, '2 flew off 8:30 and 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, 'possible late nest hidden');
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Deweys Mill', 'Hartford', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, '7/18 1A Sarah Carline');
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2018-07-21', '07:30:00', NULL, 2, NULL, NULL, 1, '7:30 4A+2A flying.  8:15 only 2A obs.');
INSERT INTO public.loonwatch_ingest VALUES ('Duck (Craftsbury)', 'Craftsbury', 'Melinda Patterson', '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, 'Often 1A - melinda patterson');
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2018-07-21', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2018-07-21', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Emerald', 'Dorset', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2018-07-21', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2018-07-21', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2018-07-21', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2018-07-21', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2018-07-21', NULL, NULL, 14, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2018-07-21', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, '0 on 7/21, 7/20 2A charles davis');
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Happenstance Farm', 'Goshen', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2018-07-23', NULL, NULL, 2, 1, NULL, 1, '7/23');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2018-07-22', NULL, NULL, 2, NULL, NULL, 1, '7/22/2018; 7/19 1A Charles Caron');
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2018-07-21', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2018-07-21', '10:00:00', NULL, 3, NULL, NULL, 1, 'mid a.m. 7/21 Karen Bourque');
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, 'Not assigned but did survey this day');
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2018-07-21', '10:00:00', NULL, 5, 1, NULL, 1, '10 a.m.  7/21 Barry Hughes 1A1C 8:07 a.m');
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2018-07-21', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, 'Other A on hidden nest, 1 on 7/22/2018');
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2018-07-22', NULL, NULL, 0, NULL, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, '7/14 6Ad');
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, '2 flew 8:30,  10 min. later 2 obs. Other endâ€¦likely 1 came back and joined the one that did not fly.');
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2018-07-22', NULL, NULL, 2, 1, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2018-07-21', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, '2A in flight 8 am., then 1 kept going toward Willoughby, other landed');
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2018-07-21', NULL, NULL, 6, 4, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, 'chick in hiding, obs. Later in day.  2A flew in at 8:05');
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2018-07-20', NULL, NULL, 0, NULL, NULL, 1, '20-Jul');
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2018-07-21', NULL, NULL, 10, NULL, NULL, 1, '5 zones: 4 surveyors.  Zone 2-5A, Z3-3A, Z2-1A, Z5-1A');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2018-07-21', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mill', 'Windsor', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2018-07-21', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2018-07-22', NULL, NULL, 0, NULL, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Montpelier', 'East Montpelier', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('North Springfield', 'Springfield', NULL, '2018-07-22', NULL, NULL, 0, NULL, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2018-07-21', NULL, NULL, 8, 2, 2, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Old Marsh', 'Fair Haven', 'Keith Hanf', '2018-07-20', NULL, NULL, 1, 1, NULL, 1, '7/20 Keith Hanf 1A1C');
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, '7/22 Tim Blanshard 3A2C');
INSERT INTO public.loonwatch_ingest VALUES ('Page', 'Albany', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2018-07-21', NULL, NULL, 13, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Perch (Benson)', 'Benson', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2018-07-22', NULL, NULL, 2, 2, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Pinneo', 'Hartford', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2018-07-21', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, '2A bruce flewlling');
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2018-07-20', NULL, NULL, 1, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, '12/30');
INSERT INTO public.loonwatch_ingest VALUES ('Round (Newbury)', 'Newbury', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Runnemede', 'Windsor', 'MIchael Foster', '2018-07-22', NULL, NULL, 0, NULL, NULL, 1, '7/22 Michael Foster 0A');
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2018-07-21', NULL, NULL, 10, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2018-07-21', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shelburne', 'Shelburne', NULL, '2018-07-20', NULL, NULL, 0, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2018-07-20', NULL, NULL, 0, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2018-07-21', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2018-07-21', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2018-07-21', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2018-07-21', NULL, NULL, 1, 2, NULL, 1, '0 obs. At 8 am, entire family there at 10:15 so at least 1A and 2C missed at 8 am');
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2018-07-21', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stratton', 'Stratton', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2018-07-21', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2018-07-20', NULL, NULL, 2, NULL, NULL, 1, '7/20');
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2018-07-21', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2018-07-21', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, '2 flew off 7:45 to SE');
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2018-07-21', NULL, NULL, 2, 1, NULL, 1, '7/19 5A1C charles davis');
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2018-07-21', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2018-07-22', NULL, NULL, 2, 1, NULL, 1, '7/22');
INSERT INTO public.loonwatch_ingest VALUES ('Abenaki', 'Thetford', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Adamant', 'Calais', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2019-07-20', NULL, NULL, 5, NULL, NULL, 1, '10:30 am 2A');
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2019-07-20', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2019-07-20', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2019-07-20', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, '4A 7/23 near state park');
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2019-07-20', NULL, NULL, 10, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, 'Lefferts 0Ad - not including as too marshy I think for loons');
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2019-07-19', NULL, NULL, 2, NULL, NULL, 1, '7/19 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2019-07-20', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2019-07-20', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2019-07-19', NULL, NULL, 2, 2, NULL, 1, '7/19 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2019-07-20', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2019-07-20', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2019-07-20', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2019-07-20', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2019-07-20', NULL, NULL, 15, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2019-07-20', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2019-07-20', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2019-07-20', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2019-07-19', NULL, NULL, 1, NULL, 3, 1, '7/19 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Hartland dam', 'Hartland', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, 'partial view from dam');
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2019-07-20', NULL, NULL, 5, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2019-07-20', NULL, NULL, 4, 3, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', NULL, '2019-07-21', NULL, NULL, 0, NULL, NULL, 1, '7/21 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2019-07-20', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2019-07-20', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Rock', 'Wallingford', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, '7/19 2A');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2019-07-20', NULL, NULL, 7, 5, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2019-07-20', NULL, NULL, 15, NULL, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mill', 'Windsor', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Minards', 'Rockingham', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, '3rd flew over ');
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2019-07-20', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2019-07-20', NULL, NULL, 6, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2019-07-20', NULL, NULL, 11, 4, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Old Marsh', 'Fair Haven', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2019-07-20', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2019-07-20', NULL, NULL, 9, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Perch (Benson)', 'Benson', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, 'possible 2nd Adult');
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Runnemede', 'Windsor', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sadawga', 'Whitingham', NULL, '2019-07-21', NULL, NULL, 0, NULL, NULL, 1, '7/21 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, '1 Adult flew over 7:00 am');
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2019-07-20', NULL, NULL, 7, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2019-07-20', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shelburne', 'Shelburne', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sherman Reservoir', 'Whitingham', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2019-07-20', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2019-07-20', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stoughton', 'Weathersfield', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stratton', 'Stratton', NULL, '2019-07-21', NULL, NULL, 2, NULL, NULL, 1, '7/21 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2019-07-20', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2019-07-20', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2019-07-20', NULL, NULL, 8, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2019-07-20', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2019-07-20', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2019-07-20', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2019-07-20', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Adamant', 'Calais', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2020-07-17', NULL, NULL, 0, NULL, NULL, 1, '17-Jul');
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, '1 A flyover');
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bristol (Winona)', 'Bristol', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2020-07-18', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2020-07-18', NULL, NULL, 3, 3, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, '3rd Ad flew mid a.m.');
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Cranberry Meadow', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, '5:30 am 2A, 1 flew');
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, '3rd Ad flew 9:30');
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2020-07-18', NULL, NULL, 5, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, '1 Ad 5:45 a.m.');
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, '2 chicks present but not seen');
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, '2 Ad in fight heading SW - to L. A or Norton?');
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2020-07-18', NULL, NULL, 17, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2020-07-18', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Happenstance Farm', 'Goshen', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2020-07-18', '13:00:00', NULL, 2, 1, NULL, 1, '1:00 PM');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2020-07-17', NULL, NULL, 2, NULL, NULL, 1, '17-Jul');
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, '1 Ad flew in 12:30 pm');
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2020-07-18', NULL, NULL, 8, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2020-07-18', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, 'possible SA');
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2020-07-18', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, 'likey 1A also on nest but not observed');
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little (Wells)', 'Wells', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2020-07-18', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, '1 on nest, missed');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2020-07-18', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2020-07-18', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2020-07-18', NULL, NULL, 3, 2, NULL, 1, '2 chicks stashed');
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2020-07-18', NULL, NULL, 7, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2020-07-18', '14:00:00', NULL, 1, NULL, NULL, 1, '2:00 PM');
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2020-07-18', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, '2 Ad flew 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys', 'Cabot', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, '2 chicks observed late july');
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, 'missed other family');
INSERT INTO public.loonwatch_ingest VALUES ('Monkton (Cedar)', 'Monkton', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2020-07-18', '14:00:00', NULL, 0, NULL, NULL, 1, '2:00 PM');
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 6, NULL, NULL, 1, '3 flew 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2020-07-18', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2020-07-18', NULL, NULL, 10, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Old Marsh', 'Fair Haven', NULL, '2020-07-18', NULL, NULL, 1, 1, NULL, 1, '2nd Ad flew 6:20 toward Inman');
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2020-07-18', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Newbury)', 'Newbury', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sadawga', 'Whitingham', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2020-07-18', NULL, NULL, 18, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shelburne', 'Shelburne', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2020-07-18', NULL, NULL, 11, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2020-07-18', NULL, NULL, 3, 1, NULL, 1, '8:34 3rd Ad fly toward Isl. Pond');
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2020-07-18', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2020-07-18', NULL, NULL, 3, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stannard', 'Stannard', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, 'added to lake list; need to adjust other years');
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2020-07-18', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2020-07-18', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2020-07-18', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2020-07-18', NULL, NULL, 5, NULL, NULL, 1, '2 obs. South end; 4 obs. North arm, 1 of which flew in from south, 2 flew south and 2 flew north but then rejoined as group of 3A.  1 of these could have been obs. In south end.');
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2020-07-18', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2020-07-18', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2020-07-18', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2020-07-18', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2020-07-18', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Abenaki', 'Thetford', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Adamant', 'Calais', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2021-07-17', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Arrowhead', 'Milton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Brookfield)', 'Brookfield', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, 'new volunteer - findâ€¦.');
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2021-07-17', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2021-07-17', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2021-07-17', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, 'taking over from gilberts');
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2021-07-17', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2021-07-17', NULL, NULL, 5, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', NULL, '2021-07-17', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde River - Buck Flats', 'Charleston', NULL, '2021-07-17', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2021-07-17', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, 'switched from ricker');
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Deweys Mill', 'Hartford', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 4, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2021-07-17', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, 'watch from a distance');
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2021-07-17', NULL, NULL, 3, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2021-07-17', NULL, NULL, 1, 2, NULL, 1, 'find someone else??');
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2021-07-17', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Gale Meadows', 'Londonderry', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2021-07-17', NULL, NULL, 6, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2021-07-17', NULL, NULL, 6, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2021-07-17', NULL, NULL, 9, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, 'prentiss did 2021');
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, 'contact one of new volunteers');
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2021-07-17', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2021-07-17', NULL, NULL, 5, 1, NULL, 1, 'back-up');
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', NULL, '2021-07-17', NULL, NULL, 4, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2021-07-17', NULL, NULL, 4, NULL, NULL, 1, 'missed 2020??');
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2021-07-17', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2021-07-17', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', NULL, '2021-07-17', NULL, NULL, 4, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Martin''s', 'Peacham', NULL, '2021-07-17', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2021-07-17', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2021-07-17', NULL, NULL, 12, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mill', 'Windsor', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2021-07-17', NULL, NULL, 6, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Peacham)', 'Peacham', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2021-07-17', NULL, NULL, 3, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2021-07-17', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2021-07-17', NULL, NULL, 11, 5, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Old Marsh', 'Fair Haven', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Parker', 'Glover', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2021-07-17', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2021-07-17', NULL, NULL, 1, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ritterbush', 'Eden', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Runnemede', 'Windsor', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, 'Mike Backman can cover as he''s doing  other Windsor pond');
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2021-07-17', NULL, NULL, 10, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sherman Reservoir', 'Whitingham', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2021-07-17', NULL, NULL, 13, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2021-07-17', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stratton', 'Stratton', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sugar Hill Res.', 'Goshen', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2021-07-17', NULL, NULL, 5, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Tiny', 'Plymouth', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2021-07-17', NULL, NULL, 2, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wantastiquet', 'Weston', NULL, '2021-07-17', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2021-07-17', NULL, NULL, 3, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', NULL, '2021-07-17', NULL, NULL, 4, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2021-07-17', NULL, NULL, 8, 0, 1, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2021-07-17', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2021-07-17', NULL, NULL, 1, 2, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2021-07-17', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2021-07-17', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2021-07-17', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Abenaki', 'Thetford', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, 'remove ''23; too shallow and vegetated');
INSERT INTO public.loonwatch_ingest VALUES ('Adamant', 'Calais', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, 'was not surveyed on the 16th but someone else heard/see one loon on the morning of the 17th');
INSERT INTO public.loonwatch_ingest VALUES ('Amherst (Plymouth)', 'Plymouth', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Baker (Barton)', 'Barton', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bald Hill', 'Westmore', NULL, '2022-07-16', NULL, NULL, 4, 0, 0, 1, '2 flew over - did not land.  Possibly one flew from Newark and returned?');
INSERT INTO public.loonwatch_ingest VALUES ('Bean (Sutton)', 'Sutton', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beaver', 'Holland', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Hub)', 'Hubbardton', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beebe (Sund)', 'Sunderland', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Beecher', 'Brighton', 'Eric H.', '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, 'eric h.');
INSERT INTO public.loonwatch_ingest VALUES ('Berlin', 'Berlin', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'from master ebird list. Chick stashed? Parents flying.');
INSERT INTO public.loonwatch_ingest VALUES ('Bomoseen', 'Castleton', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Bourn', 'Sunderland', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list, chick? Ebird reported 3 loons (2a+1c)');
INSERT INTO public.loonwatch_ingest VALUES ('Branch', 'Sunderland', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Brownington', 'Brownington', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'George Lague loon survey, He doesn''t mention the name of the lake, Is this the correct one? Maury Tinker reports 3A (new vol.) Check w/ George next year as he did not respond to being able to the survey but he did do it (I think).');
INSERT INTO public.loonwatch_ingest VALUES ('Bruce', 'Sutton', 'Jeff Rand', '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, 'jeff rand');
INSERT INTO public.loonwatch_ingest VALUES ('Buck', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Burr', 'Sudbury', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Carmi', 'Franklin', NULL, '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Caspian', 'Greensboro', NULL, '2022-07-16', NULL, NULL, 8, 2, 0, 1, 'from master ebird list 10 loons.  8A2C');
INSERT INTO public.loonwatch_ingest VALUES ('Center', 'Newark', NULL, '2022-07-16', NULL, NULL, 3, 1, NULL, 1, '8:45 2A1C at 8:20 john conner');
INSERT INTO public.loonwatch_ingest VALUES ('Chandler', 'Wheelock', 'Ken Stowe', '2022-07-16', NULL, NULL, 1, 1, NULL, 1, 'Ken Stowe');
INSERT INTO public.loonwatch_ingest VALUES ('Charleston (Charleston)', 'Charleston', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Chittenden', 'Chittenden', NULL, '2022-07-16', NULL, NULL, 6, 3, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clarks (Tildys)', 'Glover', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Clyde', 'Derby', 'Maury Tinker', '2022-07-16', NULL, NULL, 1, 2, 0, 1, 'Maury Tinker');
INSERT INTO public.loonwatch_ingest VALUES ('Clyde River - Buck Flats', 'Charleston', NULL, '2022-07-16', NULL, NULL, 1, 1, 0, 1, 'unsure who surveyed');
INSERT INTO public.loonwatch_ingest VALUES ('Coits', 'Cabot', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'one flying over on to Nichols or East Long at 7h45 am not included');
INSERT INTO public.loonwatch_ingest VALUES ('Colby', 'Plymouth', 'Karli F.', '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'Karli F.');
INSERT INTO public.loonwatch_ingest VALUES ('Colchester', 'Colchester', NULL, '2022-07-16', NULL, NULL, 4, 0, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Cole', 'Jamaica', NULL, '2022-07-16', NULL, NULL, 3, NULL, NULL, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Coles', 'Walden', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Collins', 'Hyde Park', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Comerford', 'Waterford', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, 'Carole Brando');
INSERT INTO public.loonwatch_ingest VALUES ('Crystal', 'Barton', NULL, '2022-07-16', NULL, NULL, 2, 0, NULL, 1, '7/15 4Ad');
INSERT INTO public.loonwatch_ingest VALUES ('Curtis', 'Calais', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels - West (Rodgers)', 'Glover', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Daniels Pond', 'Glover', NULL, '2022-07-16', NULL, NULL, 2, 0, NULL, 1, '7/17 3A');
INSERT INTO public.loonwatch_ingest VALUES ('Derby', 'Derby', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Dog (Valley)', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 3, 0, NULL, 1, '8:10 1A flew toward Greenwood');
INSERT INTO public.loonwatch_ingest VALUES ('Dunmore', 'Salisbury', NULL, '2022-07-16', NULL, NULL, 4, 2, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('East Long', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 1, 1, NULL, 1, 'at 8:15 only 1A obs. 12:15 2A1C.  Ch by itself and not seen or w/ other adult. Count as 1and1.');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Charleston)', 'Charleston', NULL, '2022-07-16', NULL, NULL, 2, 1, NULL, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Hub)', 'Hubbardton', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Echo (Plymouth)', 'Plymouth', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Eden', 'Eden', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Elligo', 'Greensboro', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Elmore', 'Elmore', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Emerald', 'Dorset', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ewell', 'Peacham', NULL, '2022-07-16', NULL, NULL, 4, NULL, NULL, 1, '3A on water, 1 on nest.  1 flew and returned');
INSERT INTO public.loonwatch_ingest VALUES ('Fairfield', 'Fairfield', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'see Dennis Hendy''s email. He mentioned seing 2 A and 1C at 9am and again 2A and 1C at 10am so am assuming its the same family?');
INSERT INTO public.loonwatch_ingest VALUES ('Fairlee', 'Fairlee', NULL, '2022-07-16', NULL, NULL, 7, 1, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Fern', 'Leicester', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Flagg', 'Wheelock', NULL, '2022-07-15', NULL, NULL, 2, 2, 0, 1, 'but survey was done on the 15th Friday');
INSERT INTO public.loonwatch_ingest VALUES ('Forest', 'Averill', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Fosters', 'Peacham', NULL, '2022-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Glen', 'Fair Haven', NULL, '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Great Averill', 'Averill', NULL, '2022-07-16', NULL, NULL, 8, NULL, NULL, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Great Hosmer', 'Craftsbury', NULL, '2022-07-16', NULL, NULL, 6, NULL, NULL, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Green River', 'Hyde Park', NULL, '2022-07-16', NULL, NULL, 13, 4, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Greenwood', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Groton', 'Groton', NULL, '2022-07-16', NULL, NULL, 9, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Grout', 'Stratton', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Halls', 'Newbury', NULL, '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Hardwick', 'Hardwick', NULL, '2022-07-16', NULL, NULL, 2, 1, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hardwood', 'Elmore', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harriman', 'Whitingham', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, '7/15 Henry obs. 2 A.  Olivier''s paddled north 2/3''s.');
INSERT INTO public.loonwatch_ingest VALUES ('Hartwell', 'Albany', NULL, '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Harveys', 'Barnet', NULL, '2022-07-16', NULL, NULL, 5, 0, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Holland', 'Holland', NULL, '2022-07-16', NULL, NULL, 5, 3, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Hortonia', 'Hubbardton', NULL, '2022-07-16', NULL, NULL, 3, 0, 0, 1, '1 loon on nest');
INSERT INTO public.loonwatch_ingest VALUES ('Howe', 'Readsboro', 'Henry', '2022-07-04', NULL, NULL, 0, NULL, NULL, 1, 'henry 7/4');
INSERT INTO public.loonwatch_ingest VALUES ('Indian Brook', 'Essex', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Inman', 'Fair Haven', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Iroquois', 'Hinesburg', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Island', 'Brighton', NULL, '2022-07-16', NULL, NULL, 5, 1, NULL, 1, 'possible 6th but definite 5.');
INSERT INTO public.loonwatch_ingest VALUES ('Jobs', 'Westmore', NULL, '2022-07-16', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Joe''s', 'Danville', NULL, '2022-07-15', NULL, NULL, 5, 2, NULL, 1, '7/15 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Johnson Pond', 'Shrewsbury', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'check if Rondinone did the survey');
INSERT INTO public.loonwatch_ingest VALUES ('Keiser', 'Danville', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Kent', 'Killington', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Kettle', 'Peacham', NULL, '2022-07-16', NULL, NULL, 1, 2, 0, 1, '2 chicks not obs. But present');
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2022-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br2', 'Cavendish', NULL, '2022-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Levi', 'Groton', NULL, '2022-07-16', NULL, NULL, 1, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lewis', 'Lewis', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Little Averill', 'Averill', 'Deb Metcalf', '2022-07-16', NULL, NULL, 5, 2, NULL, 1, 'deb metcalf.  4A2C on 7/17 who? Monica Hill?');
INSERT INTO public.loonwatch_ingest VALUES ('Little Hosmer', 'Craftsbury', NULL, '2022-07-16', NULL, NULL, 4, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Little Salem', 'Derby', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Eden)', 'Eden', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, '1A on nest.  Emily Sloan.');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Greensboro)', 'Greensboro', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, 'other loon likely on nest. Late hatch.');
INSERT INTO public.loonwatch_ingest VALUES ('Long (Sheffield)', 'Sheffield', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Long (Westmore)', 'Westmore', NULL, '2022-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Lowell', 'Londonderry', NULL, '2022-07-16', NULL, NULL, 5, NULL, NULL, 1, 'From ebird master list');
INSERT INTO public.loonwatch_ingest VALUES ('Lower Symes', 'Ryegate', NULL, '2022-07-16', NULL, NULL, 3, 2, NULL, 1, 'chick stashed but present (confirmed later).');
INSERT INTO public.loonwatch_ingest VALUES ('Lyford', 'Walden', NULL, '2022-07-16', NULL, NULL, 3, 1, 0, 1, '3rd A flew in 8:10.  chick stashed (confirmed later)');
INSERT INTO public.loonwatch_ingest VALUES ('Maidstone', 'Maidstone', 'Von Alt', '2022-07-17', NULL, NULL, 9, 0, 0, 1, '7/17 a.m. von alt');
INSERT INTO public.loonwatch_ingest VALUES ('May', 'Barton', NULL, '2022-07-16', NULL, NULL, 3, NULL, NULL, 1, 'from master ebird list. 2 reports from 2 different volunteer: oneperson said 5 and the other one said 3 loons (ann creavan).  Ann obs. At least 2A flying but only 3 on the water at one time.  Another possibly on nest.');
INSERT INTO public.loonwatch_ingest VALUES ('McConnell', 'Brighton', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Memphremagog', 'Derby', NULL, '2022-07-16', NULL, NULL, 13, 0, 0, 1, '3 counters ');
INSERT INTO public.loonwatch_ingest VALUES ('Metcalf', 'Fletcher', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Miles', 'Concord', NULL, '2022-07-16', NULL, NULL, 7, 0, NULL, 1, 'email forwarded from your personnal email to the VCE loon email have no info from Sharlene');
INSERT INTO public.loonwatch_ingest VALUES ('Miller', 'Strafford', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, '1A flew in 8:10');
INSERT INTO public.loonwatch_ingest VALUES ('Mollys Falls', 'Marshfield', NULL, '2022-07-16', NULL, NULL, 3, 3, NULL, 1, '3 ch present but not observed (confirmed later)');
INSERT INTO public.loonwatch_ingest VALUES ('Moore', 'Waterford', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Morey', 'Fairlee', NULL, '2022-07-16', NULL, NULL, 4, 0, 0, 1, '2A north 2A south');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Hyde Park)', 'Hyde Park', NULL, '2022-07-16', NULL, NULL, 1, 0, 0, 1, '1 flew off and returned 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Leicester)', 'Leicester', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Mud (Morgan)', 'Morgan', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Neal', 'Lunenberg', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Nelson', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Newark', 'Newark', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, 'one volunteer report 2 and the ebird master list says 4 loons on july 16th.  Libby 2A2C - one flew off and returned ');
INSERT INTO public.loonwatch_ingest VALUES ('Nichols', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 4, 1, NULL, 1, '8:15 4A  8:45 2A1C');
INSERT INTO public.loonwatch_ingest VALUES ('Ninevah', 'Mt. Holly', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('No. 10 (Mirror)', 'Calais', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Norton', 'Norton', NULL, '2022-07-16', NULL, NULL, 8, 3, 4, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Notch', 'Ferdinand', NULL, '2022-07-16', '14:20:00', NULL, 1, 0, 0, 1, '2:20 PM');
INSERT INTO public.loonwatch_ingest VALUES ('Noyes', 'Groton', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Nulhegan', 'Brighton', NULL, '2022-07-16', NULL, NULL, 0, 0, NULL, 1, 'who surveyed in 2022?');
INSERT INTO public.loonwatch_ingest VALUES ('Old Marsh', 'Fair Haven', NULL, '2022-07-15', NULL, NULL, 0, NULL, NULL, 1, '7/15 survey, new vol for ''23');
INSERT INTO public.loonwatch_ingest VALUES ('Osmore', 'Groton', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Peacham', 'Peacham', NULL, '2022-07-16', NULL, NULL, 6, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pensioner', 'Charleston', NULL, '2022-07-15', NULL, NULL, 1, 1, 0, 1, '7/15 survey');
INSERT INTO public.loonwatch_ingest VALUES ('Pigeon', 'Groton', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Pleiad', 'Hancock', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Raponda', 'Wilmington', NULL, '2022-07-16', NULL, NULL, 1, NULL, NULL, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Rescue', 'Ludlow', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ricker', 'Groton', NULL, '2022-07-16', NULL, NULL, 4, NULL, NULL, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Rood', 'Williamstown', NULL, '2022-07-16', NULL, NULL, 2, NULL, NULL, 1, '1A flew in from north 8:45');
INSERT INTO public.loonwatch_ingest VALUES ('Round (Holland)', 'Holland', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Round (Sheffield)', 'Sheffield', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Salem', 'Derby', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, 'but heard 2 loons calling on the south end of little salen at 8h20am');
INSERT INTO public.loonwatch_ingest VALUES ('Searsburg', 'Searsburg', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Seymour', 'Morgan', NULL, '2022-07-16', NULL, NULL, 7, 0, 0, 1, 'plus 3 in the air for a total of 10; Charles Woods had 18 (6 regulars plus 12 extras).  Using Dennis Fortin''s survey');
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Concord)', 'Concord', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Shadow (Glover)', 'Glover', NULL, '2022-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (barnard)', 'Barnard', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Georgia/Fairfax)', 'Fairfax', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Silver (Leicester)', 'Leicester', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list');
INSERT INTO public.loonwatch_ingest VALUES ('Sodom', 'Calais', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, 'was not surveyed on the 16th but someone saw or heard 1 A the next day');
INSERT INTO public.loonwatch_ingest VALUES ('Somerset', 'Somerset', NULL, '2022-07-16', NULL, NULL, 8, 0, 0, 1, 'all chicks lost');
INSERT INTO public.loonwatch_ingest VALUES ('South (Eden)', 'Eden', NULL, '2022-07-16', NULL, NULL, 2, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South (Marlboro)', 'Marlboro', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South America', 'Ferdinand', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('South Bay', 'Newport City', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Spectacle', 'Brighton', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Spring', 'Shrewsbury', NULL, '2022-07-16', NULL, NULL, 2, 2, 0, 1, '1 adult on shore edge when arrived.??? Eric note: not sure what this was.');
INSERT INTO public.loonwatch_ingest VALUES ('St. Catherine', 'Wells', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stiles', 'Waterford', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, '0A carole bando time?');
INSERT INTO public.loonwatch_ingest VALUES ('Stoughton', 'Weathersfield', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Stratton', 'Stratton', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunrise (Benson)', 'Benson', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Benson)', 'Benson', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, '1A reported by someone ???');
INSERT INTO public.loonwatch_ingest VALUES ('Sunset (Marlboro)', 'Marlboro', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Thurman Dix', 'Orange', NULL, '2022-07-16', NULL, NULL, 3, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Ticklenaked', 'Ryegate', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, 'need volunteer?');
INSERT INTO public.loonwatch_ingest VALUES ('Turtle', 'Holland', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Upper Symes', 'Ryegate', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, '3A on Lower Symes');
INSERT INTO public.loonwatch_ingest VALUES ('Wallace', 'Canaan', NULL, '2022-07-17', NULL, NULL, 1, 0, NULL, 1, '7/17 survey; Report of chick in 2020.');
INSERT INTO public.loonwatch_ingest VALUES ('Wallingford', 'Wallingford', NULL, '2022-07-16', NULL, NULL, 3, 2, 0, 1, '2 chicks stashed (confirmed later). Fight/chase obs. Nest west end. 1A flew in and landed.');
INSERT INTO public.loonwatch_ingest VALUES ('Wapanacki', 'Hardwick', NULL, '2022-07-16', NULL, NULL, 0, NULL, NULL, 1, 'not downloaded on ebird list b/c it was a zero count.');
INSERT INTO public.loonwatch_ingest VALUES ('Warden', 'Barnet', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Waterbury - South end', 'Waterbury', 'Liz|Kelsey', '2022-07-16', NULL, NULL, 3, 0, 0, 1, 'Liz and Kelsey:  3 adults around the same time in different locations.');
INSERT INTO public.loonwatch_ingest VALUES ('West Hill', 'Cabot', NULL, '2022-07-16', NULL, NULL, 2, 1, 0, 1, '3rd ad flew in 10:15; flew off shortly after (not counted)');
INSERT INTO public.loonwatch_ingest VALUES ('West Mountain', 'Maidstone', NULL, '2022-07-16', NULL, NULL, 3, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wheeler', 'Brunswick', NULL, '2022-07-16', NULL, NULL, 0, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Willoughby', 'Westmore', NULL, '2022-07-16', NULL, NULL, 7, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Wolcott', 'Wolcott', NULL, '2022-07-16', NULL, NULL, 0, 0, 0, 1, 'lw was done in the afternoon. 1 loon was seen the day before and sometimes 2 loons has been seen. Unconsistent. 7/15 2A');
INSERT INTO public.loonwatch_ingest VALUES ('Woodbury', 'Woodbury', NULL, '2022-07-16', NULL, NULL, 3, 0, 0, 1, 'from master ebird list, chick?');
INSERT INTO public.loonwatch_ingest VALUES ('Woodward', 'Plymouth', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, '1A sitting on re-nest');
INSERT INTO public.loonwatch_ingest VALUES ('Wrightsville', 'Worcester', NULL, '2022-07-16', NULL, NULL, 1, 0, NULL, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Zack Woods', 'Hyde Park', NULL, '2022-07-16', NULL, NULL, 2, 0, 0, 1, NULL);
INSERT INTO public.loonwatch_ingest VALUES ('Knapp Br1', 'Cavendish', NULL, '2014-07-18', '17:00:00', NULL, 0, NULL, NULL, 1, '5 pm Friday');


--
-- TOC entry 3950 (class 0 OID 92529)
-- Dependencies: 214
-- Data for Name: loonwatch_observation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.loonwatch_observation VALUES (1, '08:36:00', NULL, 2, NULL, 0, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.loonwatch_observation VALUES (1, '08:41:00', NULL, 0, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.loonwatch_observation VALUES (1, '08:55:00', NULL, 0, NULL, 0, NULL, 1, NULL, NULL, '', 'NE region: Osprey attacked chick. Unsuccessful.', NULL);


--
-- TOC entry 3771 (class 0 OID 91099)
-- Dependencies: 208
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3946 (class 0 OID 90751)
-- Dependencies: 205
-- Data for Name: vt_county; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vt_county VALUES (0, 0, 'Unknown');
INSERT INTO public.vt_county VALUES (1, 19, 'Orleans');
INSERT INTO public.vt_county VALUES (2, 13, 'Grand Isle');
INSERT INTO public.vt_county VALUES (3, 7, 'Chittenden');
INSERT INTO public.vt_county VALUES (4, 27, 'Windsor');
INSERT INTO public.vt_county VALUES (5, 25, 'Windham');
INSERT INTO public.vt_county VALUES (6, 3, 'Bennington');
INSERT INTO public.vt_county VALUES (7, 11, 'Franklin');
INSERT INTO public.vt_county VALUES (8, 9, 'Essex');
INSERT INTO public.vt_county VALUES (9, 15, 'Lamoille');
INSERT INTO public.vt_county VALUES (10, 5, 'Caledonia');
INSERT INTO public.vt_county VALUES (11, 17, 'Orange');
INSERT INTO public.vt_county VALUES (12, 23, 'Washington');
INSERT INTO public.vt_county VALUES (13, 21, 'Rutland');
INSERT INTO public.vt_county VALUES (14, 1, 'Addison');


--
-- TOC entry 3944 (class 0 OID 90719)
-- Dependencies: 203
-- Data for Name: vt_loon_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vt_loon_locations VALUES ('Forest', 'Averill', 'nek', 62, 'FOREST (AVERLL)', 8, 'FOREST (AVERLL)');
INSERT INTO public.vt_loon_locations VALUES ('Clyde River - Buck Flats', 'Charleston', 'nek', 50, NULL, 24, 'CLYDE RIVER BUCK FLATS');
INSERT INTO public.vt_loon_locations VALUES ('Echo (Charleston)', 'Charleston', 'nek', 550, 'ECHO (CHARTN)', 24, 'ECHO (CHARTN)');
INSERT INTO public.vt_loon_locations VALUES ('Charleston (Charleston)', 'Charleston', 'nek', 40, 'CHARLESTON', 24, 'CHARLESTON');
INSERT INTO public.vt_loon_locations VALUES ('Memphremagog', 'Derby', 'nek', 5966, 'MEMPHREMAGOG', 230, 'MEMPHREMAGOG');
INSERT INTO public.vt_loon_locations VALUES ('Adamant', 'Calais', 'nc', 20, 'ADAMANT', 81, 'ADAMANT');
INSERT INTO public.vt_loon_locations VALUES ('Little Salem', 'Derby', 'nek', 50, 'LITTLE SALEM', 230, 'LITTLE SALEM');
INSERT INTO public.vt_loon_locations VALUES ('Crystal', 'Barton', 'nek', 763, 'CRYSTAL (BARTON)', 45, 'CRYSTAL (BARTON)');
INSERT INTO public.vt_loon_locations VALUES ('Duck (Craftsbury)', 'Craftsbury', 'nc', 9, 'DUCK (CRAFBY)', 50, 'DUCK (CRAFBY)');
INSERT INTO public.vt_loon_locations VALUES ('No. 10 (Mirror)', 'Calais', 'nc', 85, 'MIRROR', 81, 'MIRROR');
INSERT INTO public.vt_loon_locations VALUES ('Amherst (Plymouth)', 'Plymouth', 'wc', 81, 'AMHERST', 146, 'AMHERST');
INSERT INTO public.vt_loon_locations VALUES ('Baker (Brookfield)', 'Brookfield', 'ec', 35, 'BAKER (BRKFLD)', 218, 'BAKER (BRKFLD)');
INSERT INTO public.vt_loon_locations VALUES ('Lily', 'Poultney', 'wc', 22, 'LILY (POULTY)', 220, 'LILY (POULTY)');
INSERT INTO public.vt_loon_locations VALUES ('Mud (Leicester)', 'Leicester', 'wc', 35, 'MUD (LEICTR)', 242, 'MUD (LEICTR)');
INSERT INTO public.vt_loon_locations VALUES ('Lewis', 'Lewis', 'nek', 68, 'LEWIS', 19, 'LEWIS');
INSERT INTO public.vt_loon_locations VALUES ('McConnell', 'Brighton', 'nek', 87, 'MCCONNELL', 29, 'MCCONNELL');
INSERT INTO public.vt_loon_locations VALUES ('Page', 'Albany', 'nc', 16, 'PAGE', 39, 'PAGE');
INSERT INTO public.vt_loon_locations VALUES ('Hartwell', 'Albany', 'nc', 16, 'HARTWELL', 39, 'HARTWELL');
INSERT INTO public.vt_loon_locations VALUES ('May', 'Barton', 'nek', 116, 'MAY', 45, 'MAY');
INSERT INTO public.vt_loon_locations VALUES ('Miles', 'Concord', 'nek', 215, 'MILES', 76, 'MILES');
INSERT INTO public.vt_loon_locations VALUES ('Harveys', 'Barnet', 'nc', 351, 'HARVEYS', 83, 'HARVEYS');
INSERT INTO public.vt_loon_locations VALUES ('Kent', 'Killington', 'wc', 99, 'KENT', 141, 'KENT');
INSERT INTO public.vt_loon_locations VALUES ('Lowell', 'Londonderry', 'gm-s', 57, 'LOWELL', 162, 'LOWELL');
INSERT INTO public.vt_loon_locations VALUES ('Gale Meadows', 'Londonderry', 'gm-s', 195, 'GALE MEADOWS', 162, 'GALE MEADOWS');
INSERT INTO public.vt_loon_locations VALUES ('Howe', 'Readsboro', 'gm-s', 52, 'HOWE', 189, 'HOWE');
INSERT INTO public.vt_loon_locations VALUES ('Maidstone', 'Maidstone', 'nek', 745, 'MAIDSTONE', 198, 'MAIDSTONE');
INSERT INTO public.vt_loon_locations VALUES ('Mollys', 'Cabot', 'nc', 38, 'MOLLYS', 202, 'MOLLYS');
INSERT INTO public.vt_loon_locations VALUES ('Minards', 'Rockingham', 'ec', 46, 'MINARDS', 235, 'MINARDS');
INSERT INTO public.vt_loon_locations VALUES ('Fern', 'Leicester', 'wc', 69, 'FERN', 242, 'FERN');
INSERT INTO public.vt_loon_locations VALUES ('Hinkum', 'Sudbury', 'wc', 60, 'HINKUM', 244, 'HINKUM');
INSERT INTO public.vt_loon_locations VALUES ('Beebe (Hub)', 'Hubbardton', 'wc', 111, 'BEEBE (HUBDTN)', 245, 'BEEBE (HUBDTN)');
INSERT INTO public.vt_loon_locations VALUES ('Black', 'Hubbardton', 'wc', 20, 'BLACK (HUBDTN)', 245, 'BLACK (HUBDTN)');
INSERT INTO public.vt_loon_locations VALUES ('Ninevah', 'Mt. Holly', 'wc', 171, 'NINEVAH', 151, 'NINEVAH');
INSERT INTO public.vt_loon_locations VALUES ('Tiny', 'Plymouth', 'wc', 29, 'TINY', 146, 'TINY');
INSERT INTO public.vt_loon_locations VALUES ('South (Marlboro)', 'Marlboro', 'gm-s', 68, 'SOUTH (MARLBR)', 187, 'SOUTH (MARLBR)');
INSERT INTO public.vt_loon_locations VALUES ('Sunset (Marlboro)', 'Marlboro', 'gm-s', 96, 'SUNSET (MARLBR)', 187, 'SUNSET (MARLBR)');
INSERT INTO public.vt_loon_locations VALUES ('Twin', 'Brookfield', 'ec', 16, 'TWIN', 218, 'TWIN');
INSERT INTO public.vt_loon_locations VALUES ('South Bay', 'Newport City', 'nek', 470, 'SOUTH BAY', 232, 'SOUTH BAY');
INSERT INTO public.vt_loon_locations VALUES ('Star', 'Mount Holly', 'wc', 63, 'STAR', 151, 'STAR');
INSERT INTO public.vt_loon_locations VALUES ('Upper Symes', 'Ryegate', 'nc', 15, 'UPPER SYMES', 213, 'UPPER SYMES');
INSERT INTO public.vt_loon_locations VALUES ('Happenstance Farm', 'Goshen', 'wc', 15, 'HAPPENSTANCE', 240, 'HAPPENSTANCE');
INSERT INTO public.vt_loon_locations VALUES ('Little Averill', 'Averill', 'nek', 467, 'LITTLE AVERILL', 8, 'LITTLE AVERILL');
INSERT INTO public.vt_loon_locations VALUES ('Pensioner', 'Charleston', 'nek', 173, 'PENSIONER', 24, 'PENSIONER');
INSERT INTO public.vt_loon_locations VALUES ('South America', 'Ferdinand', 'nek', 29, 'SOUTH AMERICA', 35, 'SOUTH AMERICA');
INSERT INTO public.vt_loon_locations VALUES ('Newark', 'Newark', 'nek', 153, 'NEWARK', 43, 'NEWARK');
INSERT INTO public.vt_loon_locations VALUES ('Center', 'Newark', 'nek', 79, 'CENTER', 43, 'CENTER');
INSERT INTO public.vt_loon_locations VALUES ('Salem', 'Derby', 'nek', 764, 'SALEM', 230, 'SALEM');
INSERT INTO public.vt_loon_locations VALUES ('Shadow (Glover)', 'Glover', 'nc', 210, 'SHADOW (GLOVER)', 47, 'SHADOW (GLOVER)');
INSERT INTO public.vt_loon_locations VALUES ('Warden', 'Barnet', 'nc', 46, 'WARDEN', 83, 'WARDEN');
INSERT INTO public.vt_loon_locations VALUES ('Fosters', 'Peacham', 'nc', 61, 'FOSTERS', 85, 'FOSTERS');
INSERT INTO public.vt_loon_locations VALUES ('Ewell', 'Peacham', 'nc', 51, 'EWELL', 85, 'EWELL');
INSERT INTO public.vt_loon_locations VALUES ('Ricker', 'Groton', 'nc', 95, 'RICKER', 95, 'RICKER');
INSERT INTO public.vt_loon_locations VALUES ('Sunset (Benson)', 'Benson', 'wc', 202, 'SUNSET (BENSON)', 139, 'SUNSET (BENSON)');
INSERT INTO public.vt_loon_locations VALUES ('Pinneo', 'Hartford', 'ec', 50, 'PINNEO', 140, 'PINNEO');
INSERT INTO public.vt_loon_locations VALUES ('Colby', 'Plymouth', 'wc', 20, 'COLBY', 146, 'COLBY');
INSERT INTO public.vt_loon_locations VALUES ('Mud (Morgan)', 'Morgan', 'nek', 35, 'MUD (MORGAN)-N', 18, 'MUD (MORGAN)-N');
INSERT INTO public.vt_loon_locations VALUES ('Toad', 'Charleston', 'nek', 22, 'TOAD (CHARTN)', 24, 'TOAD (CHARTN)');
INSERT INTO public.vt_loon_locations VALUES ('Round (Newbury)', 'Newbury', 'nc', 30, 'ROUND (NEWBRY)', 214, 'ROUND (NEWBRY)');
INSERT INTO public.vt_loon_locations VALUES ('Sugar Hill Res.', 'Goshen', 'wc', 63, 'SUGAR HILL', 240, 'SUGAR HILL');
INSERT INTO public.vt_loon_locations VALUES ('Silver (Leicester)', 'Leicester', 'wc', 101, 'SILVER (LEICTR)', 242, 'SILVER (LEICTR)');
INSERT INTO public.vt_loon_locations VALUES ('Unknown', 'Avery''s Gore', 'nek', 19, 'UNKNOWN (AVYGOR)', 14, 'UNKNOWN (AVYGOR)');
INSERT INTO public.vt_loon_locations VALUES ('Adams Res.', 'Woodford', 'gm-s', 21, 'ADAMS (WOODFD)', 184, 'ADAMS (WOODFD)');
INSERT INTO public.vt_loon_locations VALUES ('Big (Woodford Lake)', 'Woodford', 'gm-s', 31, 'BIG', 184, 'BIG');
INSERT INTO public.vt_loon_locations VALUES ('Harriman', 'Whitingham', 'gm-s', 2040, 'HARRIMAN (WHITHM)', 192, 'HARRIMAN (WHITHM)');
INSERT INTO public.vt_loon_locations VALUES ('Sherman Reservoir', 'Whitingham', 'gm-s', 160, 'SHERMAN', 192, 'SHERMAN');
INSERT INTO public.vt_loon_locations VALUES ('Chipman (Tinmouth)', 'Tinmouth', 'wc', 79, 'CHIPMAN', 221, 'CHIPMAN');
INSERT INTO public.vt_loon_locations VALUES ('Burr', 'Sudbury', 'wc', 85, 'BURR (SUDBRY)', 244, 'BURR (SUDBRY)');
INSERT INTO public.vt_loon_locations VALUES ('Townshend Res.', 'Townshend', 'gm-s', 108, 'TOWNSHEND', 169, 'TOWNSHEND');
INSERT INTO public.vt_loon_locations VALUES ('Indian Brook', 'Essex', 'cha-n', 50, 'INDIAN BROOK (ESSEX)', 212, 'INDIAN BROOK (ESSEX)');
INSERT INTO public.vt_loon_locations VALUES ('Brownington', 'Brownington', 'nek', 139, 'BROWNINGTON', 26, 'BROWNINGTON');
INSERT INTO public.vt_loon_locations VALUES ('Fairfield', 'Fairfield', 'cha-n', 446, 'FAIRFIELD', 27, 'FAIRFIELD');
INSERT INTO public.vt_loon_locations VALUES ('Beecher', 'Brighton', 'nek', 15, 'BEECHER', 29, 'BEECHER');
INSERT INTO public.vt_loon_locations VALUES ('Baker (Barton)', 'Barton', 'nc', 51, 'BAKER (BARTON)', 45, 'BAKER (BARTON)');
INSERT INTO public.vt_loon_locations VALUES ('Elmore', 'Elmore', 'nc', 219, 'ELMORE', 70, 'ELMORE');
INSERT INTO public.vt_loon_locations VALUES ('Bliss', 'Calais', 'nc', 46, 'BLISS', 81, 'BLISS');
INSERT INTO public.vt_loon_locations VALUES ('Curtis', 'Calais', 'nc', 72, 'CURTIS', 81, 'CURTIS');
INSERT INTO public.vt_loon_locations VALUES ('Berlin', 'Berlin', 'nc', 293, 'BERLIN', 99, 'BERLIN');
INSERT INTO public.vt_loon_locations VALUES ('Morey', 'Fairlee', 'ec', 547, 'MOREY', 123, 'MOREY');
INSERT INTO public.vt_loon_locations VALUES ('Deweys Mill', 'Hartford', 'ec', 56, 'DEWEYS MILL', 140, 'DEWEYS MILL');
INSERT INTO public.vt_loon_locations VALUES ('Inman', 'Fair Haven', 'wc', 85, 'INMAN', 144, 'INMAN');
INSERT INTO public.vt_loon_locations VALUES ('Danby', 'Danby', 'wc', 56, 'DANBY', 153, 'DANBY');
INSERT INTO public.vt_loon_locations VALUES ('Emerald', 'Dorset', 'wc', 28, 'EMERALD', 159, 'EMERALD');
INSERT INTO public.vt_loon_locations VALUES ('Eden', 'Eden', 'nc', 194, 'EDEN', 197, 'EDEN');
INSERT INTO public.vt_loon_locations VALUES ('Colchester', 'Colchester', 'cha-n', 186, 'COLCHESTER', 199, 'COLCHESTER');
INSERT INTO public.vt_loon_locations VALUES ('Coits', 'Cabot', 'nc', 40, 'COITS', 202, 'COITS');
INSERT INTO public.vt_loon_locations VALUES ('Clyde', 'Derby', 'nek', 186, 'CLYDE', 230, 'CLYDE');
INSERT INTO public.vt_loon_locations VALUES ('Derby', 'Derby', 'nek', 207, 'DERBY', 230, 'DERBY');
INSERT INTO public.vt_loon_locations VALUES ('Chittenden', 'Chittenden', 'wc', 702, 'CHITTENDEN', 243, 'CHITTENDEN');
INSERT INTO public.vt_loon_locations VALUES ('Bomoseen', 'Castleton', 'wc', 2360, 'BOMOSEEN', 246, 'BOMOSEEN');
INSERT INTO public.vt_loon_locations VALUES ('Hartland dam', 'Hartland', 'ec', 215, 'NORTH HARTLAND', 145, 'NORTH HARTLAND');
INSERT INTO public.vt_loon_locations VALUES ('Joe''s', 'Danville', 'nc', 396, 'JOES (DANVLL)', 200, 'JOES (DANVLL)');
INSERT INTO public.vt_loon_locations VALUES ('Thurman Dix', 'Orange', 'nc', 123, 'THURMAN W. DIX', 103, 'THURMAN W. DIX');
INSERT INTO public.vt_loon_locations VALUES ('Sunrise (Benson)', 'Benson', 'wc', 57, 'SUNRISE', 139, 'SUNRISE');
INSERT INTO public.vt_loon_locations VALUES ('Pigeon', 'Groton', 'nc', 69, 'PIGEON', 95, 'PIGEON');
INSERT INTO public.vt_loon_locations VALUES ('Pleiad', 'Hancock', 'wc', 6, 'PLEIAD', 124, 'PLEIAD');
INSERT INTO public.vt_loon_locations VALUES ('Perch (Benson)', 'Benson', 'wc', 24, 'PERCH (BENSON)', 139, 'PERCH (BENSON)');
INSERT INTO public.vt_loon_locations VALUES ('Silver (barnard)', 'Barnard', 'wc', 84, 'SILVER (BARNRD)', 138, 'SILVER (BARNRD)');
INSERT INTO public.vt_loon_locations VALUES ('Echo (Plymouth)', 'Plymouth', 'wc', 104, 'ECHO (PLYMTH)', 146, 'ECHO (PLYMTH)');
INSERT INTO public.vt_loon_locations VALUES ('Little (Franklin)', 'Franklin', 'cha-n', 95, 'LITTLE (FRANLN)', 2, 'LITTLE (FRANLN)');
INSERT INTO public.vt_loon_locations VALUES ('Griffith', 'Peru', 'gm-s', 13, 'GRIFFITH', 160, 'GRIFFITH');
INSERT INTO public.vt_loon_locations VALUES ('Great Averill', 'Averill', 'nek', 828, 'GREAT AVERILL', 8, 'GREAT AVERILL');
INSERT INTO public.vt_loon_locations VALUES ('Round (Holland)', 'Holland', 'nek', 14, 'MUD (HOLLND)', 9, 'MUD (HOLLND)');
INSERT INTO public.vt_loon_locations VALUES ('Beaver', 'Holland', 'nek', 40, 'BEAVER (HOLLND)', 9, 'BEAVER (HOLLND)');
INSERT INTO public.vt_loon_locations VALUES ('Wheeler', 'Brunswick', 'nek', 66, 'WHEELER (BRUNWK)', 36, 'WHEELER (BRUNWK)');
INSERT INTO public.vt_loon_locations VALUES ('Daniels Pond', 'Glover', 'nc', 66, 'DANIELS', 47, 'DANIELS');
INSERT INTO public.vt_loon_locations VALUES ('Daniels - West (Rodgers)', 'Glover', 'nc', 20, 'DANIELS-W', 47, 'DANIELS-W');
INSERT INTO public.vt_loon_locations VALUES ('Long (Greensboro)', 'Greensboro', 'nc', 100, 'LONG (GRNSBO)', 55, 'LONG (GRNSBO)');
INSERT INTO public.vt_loon_locations VALUES ('Mud (Hyde Park)', 'Hyde Park', 'nc', 14, 'MUD (HYDEPK)', 64, 'MUD (HYDEPK)');
INSERT INTO public.vt_loon_locations VALUES ('Holland', 'Holland', 'nek', 325, 'HOLLAND', 9, 'HOLLAND');
INSERT INTO public.vt_loon_locations VALUES ('Island', 'Brighton', 'nek', 626, 'ISLAND', 29, 'ISLAND');
INSERT INTO public.vt_loon_locations VALUES ('Metcalf', 'Fletcher', 'cha-n', 81, 'METCALF', 44, 'METCALF');
INSERT INTO public.vt_loon_locations VALUES ('Little Hosmer', 'Craftsbury', 'nc', 180, 'LITTLE HOSMER', 50, 'LITTLE HOSMER');
INSERT INTO public.vt_loon_locations VALUES ('Lamoille', 'Hyde Park', 'nc', 148, 'LAMOILLE', 64, 'LAMOILLE');
INSERT INTO public.vt_loon_locations VALUES ('Great Hosmer', 'Craftsbury', 'nc', 140, 'GREAT HOSMER', 50, 'GREAT HOSMER');
INSERT INTO public.vt_loon_locations VALUES ('Caspian', 'Greensboro', 'nc', 789, 'CASPIAN', 55, 'CASPIAN');
INSERT INTO public.vt_loon_locations VALUES ('Elligo', 'Greensboro', 'nc', 174, 'ELLIGO', 55, 'ELLIGO');
INSERT INTO public.vt_loon_locations VALUES ('Collins', 'Hyde Park', 'nc', 16, 'COLLINS', 64, 'COLLINS');
INSERT INTO public.vt_loon_locations VALUES ('Green River', 'Hyde Park', 'nc', 554, 'GREEN RIVER', 64, 'GREEN RIVER');
INSERT INTO public.vt_loon_locations VALUES ('Hardwick', 'Hardwick', 'nc', 145, 'HARDWICK', 66, 'HARDWICK');
INSERT INTO public.vt_loon_locations VALUES ('Hardwood', 'Elmore', 'nc', 44, 'HARDWOOD', 70, 'HARDWOOD');
INSERT INTO public.vt_loon_locations VALUES ('Little Elmore', 'Elmore', 'nc', 24, 'LITTLE ELMORE', 70, 'LITTLE ELMORE');
INSERT INTO public.vt_loon_locations VALUES ('Sodom', 'Calais', 'nc', 21, 'SODOM', 81, 'SODOM');
INSERT INTO public.vt_loon_locations VALUES ('Neal', 'Lunenburg', 'nek', 186, 'NEAL', 73, 'NEAL');
INSERT INTO public.vt_loon_locations VALUES ('Groton', 'Groton', 'nc', 422, 'GROTON', 95, 'GROTON');
INSERT INTO public.vt_loon_locations VALUES ('Osmore', 'Groton', 'nc', 48, 'OSMORE', 95, 'OSMORE');
INSERT INTO public.vt_loon_locations VALUES ('Bristol (Winona)', 'Bristol', 'cha-n', 248, 'WINONA', 105, 'WINONA');
INSERT INTO public.vt_loon_locations VALUES ('Fairlee', 'Fairlee', 'ec', 457, 'FAIRLEE', 123, 'FAIRLEE');
INSERT INTO public.vt_loon_locations VALUES ('Glen', 'Fair Haven', 'wc', 206, 'GLEN', 144, 'GLEN');
INSERT INTO public.vt_loon_locations VALUES ('Levi', 'Groton', 'nc', 22, 'LEVI', 95, 'LEVI');
INSERT INTO public.vt_loon_locations VALUES ('Ball Mountain', 'Jamaica', 'gm-s', 85, 'BALL MOUNTAIN', 168, 'BALL MOUNTAIN');
INSERT INTO public.vt_loon_locations VALUES ('Cole', 'Jamaica', 'gm-s', 41, 'COLE', 168, 'COLE');
INSERT INTO public.vt_loon_locations VALUES ('South (Eden)', 'Eden', 'nc', 103, 'SOUTH (EDEN)', 197, 'SOUTH (EDEN)');
INSERT INTO public.vt_loon_locations VALUES ('Long (Eden)', 'Eden', 'nc', 97, 'LONG (EDEN)', 197, 'LONG (EDEN)');
INSERT INTO public.vt_loon_locations VALUES ('Ritterbush', 'Eden', 'nc', 14, 'RITTERBUSH', 197, 'RITTERBUSH');
INSERT INTO public.vt_loon_locations VALUES ('Halls', 'Newbury', 'ec', 85, 'HALLS', 214, 'HALLS');
INSERT INTO public.vt_loon_locations VALUES ('Lower (Hinesburg)', 'Hinesburg', 'cha-n', 57, 'LOWER', 205, 'LOWER');
INSERT INTO public.vt_loon_locations VALUES ('Knapp Br2', 'Cavendish', 'wc', 35, 'KNAPP BROOK #2', 226, 'KNAPP BROOK #2');
INSERT INTO public.vt_loon_locations VALUES ('Knapp Br1', 'Cavendish', 'wc', 25, 'KNAPP BROOK #1', 226, 'KNAPP BROOK #1');
INSERT INTO public.vt_loon_locations VALUES ('Spectacle', 'Brighton', 'nek', 103, 'SPECTACLE', 29, 'SPECTACLE');
INSERT INTO public.vt_loon_locations VALUES ('Carmi', 'Franklin', 'cha-n', 1401, 'CARMI', 2, 'CARMI');
INSERT INTO public.vt_loon_locations VALUES ('Blake', 'Sheffield', 'nek', 8, 'BLAKE', 52, 'BLAKE');
INSERT INTO public.vt_loon_locations VALUES ('Long (Sheffield)', 'Sheffield', 'nc', 38, 'LONG (SHEFLD)', 52, 'LONG (SHEFLD)');
INSERT INTO public.vt_loon_locations VALUES ('Round (Sheffield)', 'Sheffield', 'nc', 13, 'ROUND (SHEFLD)', 52, 'ROUND (SHEFLD)');
INSERT INTO public.vt_loon_locations VALUES ('Miller', 'Strafford', 'ec', 64, 'MILLER (STRFRD)', 129, 'MILLER (STRFRD)');
INSERT INTO public.vt_loon_locations VALUES ('Spring', 'Shrewsbury', 'wc', 66, 'SPRING (SHRWBY)', 147, 'SPRING (SHRWBY)');
INSERT INTO public.vt_loon_locations VALUES ('Johnson Pond', 'Shrewsbury', 'wc', 12, 'COOKS (SHRWBY)', 147, 'COOKS (SHRWBY)');
INSERT INTO public.vt_loon_locations VALUES ('Norton', 'Norton', 'nek', 583, 'NORTON', 7, 'NORTON');
INSERT INTO public.vt_loon_locations VALUES ('Nulhegan', 'Brighton', 'nek', 37, 'NULHEGAN', 29, 'NULHEGAN');
INSERT INTO public.vt_loon_locations VALUES ('Notch', 'Ferdinand', 'nek', 22, 'NOTCH', 35, 'NOTCH');
INSERT INTO public.vt_loon_locations VALUES ('Parker', 'Glover', 'nc', 250, 'PARKER', 47, 'PARKER');
INSERT INTO public.vt_loon_locations VALUES ('Zack Woods', 'Hyde Park', 'nc', 23, 'ZACK WOODS', 64, 'ZACK WOODS');
INSERT INTO public.vt_loon_locations VALUES ('Stannard', 'Stannard', 'nc', 25, 'STANNARD', 67, 'STANNARD');
INSERT INTO public.vt_loon_locations VALUES ('Mansfield', 'Stowe', 'nc', 38, 'MANSFIELD', 69, 'MANSFIELD');
INSERT INTO public.vt_loon_locations VALUES ('Peacham', 'Peacham', 'nc', 340, 'PEACHAM', 85, 'PEACHAM');
INSERT INTO public.vt_loon_locations VALUES ('North Montpelier', 'East Montpelier', 'nc', 72, 'NORTH MONTPELIER', 91, 'NORTH MONTPELIER');
INSERT INTO public.vt_loon_locations VALUES ('Noyes', 'Groton', 'nc', 39, 'NOYES', 95, 'NOYES');
INSERT INTO public.vt_loon_locations VALUES ('Dunmore', 'Salisbury', 'wc', 985, 'DUNMORE', 126, 'DUNMORE');
INSERT INTO public.vt_loon_locations VALUES ('Crescent', 'Sharon', 'ec', 20, 'CRESCENT', 135, 'CRESCENT');
INSERT INTO public.vt_loon_locations VALUES ('Mitchell', 'Sharon', 'ec', 28, 'MITCHELL', 135, 'MITCHELL');
INSERT INTO public.vt_loon_locations VALUES ('Old Marsh', 'Fair Haven', 'wc', 131, 'OLD MARSH', 144, 'OLD MARSH');
INSERT INTO public.vt_loon_locations VALUES ('Woodward', 'Plymouth', 'wc', 106, 'WOODWARD', 146, 'WOODWARD');
INSERT INTO public.vt_loon_locations VALUES ('North Springfield', 'Springfield', 'ec', 290, 'NORTH SPRINGFIELD', 157, 'NORTH SPRINGFIELD');
INSERT INTO public.vt_loon_locations VALUES ('Stratton', 'Stratton', 'gm-s', 46, 'STRATTON', 173, 'STRATTON');
INSERT INTO public.vt_loon_locations VALUES ('Grout', 'Stratton', 'gm-s', 84, 'GROUT', 173, 'GROUT');
INSERT INTO public.vt_loon_locations VALUES ('Somerset', 'Somerset', 'gm-s', 1568, 'SOMERSET', 178, 'SOMERSET');
INSERT INTO public.vt_loon_locations VALUES ('Paran', 'Bennington', 'gm-s', 40, 'PARAN', 183, 'PARAN');
INSERT INTO public.vt_loon_locations VALUES ('Searsburg', 'Searsburg', 'gm-s', 25, 'SEARSBURG', 185, 'SEARSBURG');
INSERT INTO public.vt_loon_locations VALUES ('West Mountain', 'Maidstone', 'nek', 60, 'WEST MOUNTAIN', 198, 'WEST MOUNTAIN');
INSERT INTO public.vt_loon_locations VALUES ('West Hill', 'Cabot', 'nc', 46, 'WEST HILL', 202, 'WEST HILL');
INSERT INTO public.vt_loon_locations VALUES ('Shelburne', 'Shelburne', 'cha-n', 452, 'SHELBURNE', 203, 'SHELBURNE');
INSERT INTO public.vt_loon_locations VALUES ('Ticklenaked', 'Ryegate', 'nc', 54, 'TICKLENAKED', 213, 'TICKLENAKED');
INSERT INTO public.vt_loon_locations VALUES ('Lower Symes', 'Ryegate', 'nc', 77, 'LOWER SYMES', 213, 'LOWER SYMES');
INSERT INTO public.vt_loon_locations VALUES ('Echo (Hub)', 'Hubbardton', 'wc', 54, 'ECHO (HUBDTN)', 245, 'ECHO (HUBDTN)');
INSERT INTO public.vt_loon_locations VALUES ('Keiser', 'Danville', 'nc', 33, 'KEISER', 200, 'KEISER');
INSERT INTO public.vt_loon_locations VALUES ('Iroquois', 'Hinesburg', 'cha-n', 243, 'IROQUOIS', 205, 'IROQUOIS');
INSERT INTO public.vt_loon_locations VALUES ('Hortonia', 'Hubbardton', 'wc', 479, 'HORTONIA', 245, 'HORTONIA');
INSERT INTO public.vt_loon_locations VALUES ('Wallace', 'Canaan', 'nek', 532, 'WALLACE', 1, 'WALLACE');
INSERT INTO public.vt_loon_locations VALUES ('Turtle', 'Holland', 'nek', 27, 'TURTLE', 9, 'TURTLE');
INSERT INTO public.vt_loon_locations VALUES ('Seymour', 'Morgan', 'nek', 1769, 'SEYMOUR', 18, 'SEYMOUR');
INSERT INTO public.vt_loon_locations VALUES ('Rescue', 'Ludlow', 'wc', 180, 'RESCUE', 255, 'RESCUE');
INSERT INTO public.vt_loon_locations VALUES ('Silver (Georgia/Fairfax)', 'Fairfax', 'cha-n', 27, 'SOUTH ST. ALBANS', 42, 'SOUTH ST. ALBANS');
INSERT INTO public.vt_loon_locations VALUES ('Clarks (Tildys)', 'Glover', 'nc', 33, 'TILDYS', 47, 'TILDYS');
INSERT INTO public.vt_loon_locations VALUES ('Arrowhead', 'Milton', 'cha-n', 760, 'ARROWHEAD MOUNTAIN', 48, 'ARROWHEAD MOUNTAIN');
INSERT INTO public.vt_loon_locations VALUES ('Wapanacki', 'Hardwick', 'nc', 21, 'TUTTLE (HARDWK)', 66, 'TUTTLE (HARDWK)');
INSERT INTO public.vt_loon_locations VALUES ('Shadow (Concord)', 'Concord', 'nek', 128, 'SHADOW (CONCRD)', 76, 'SHADOW (CONCRD)');
INSERT INTO public.vt_loon_locations VALUES ('Kettle', 'Peacham', 'nc', 109, 'KETTLE', 85, 'KETTLE');
INSERT INTO public.vt_loon_locations VALUES ('Mud (Peacham)', 'Peacham', 'nc', 34, 'MUD (PEACHM)', 85, 'MUD (PEACHM)');
INSERT INTO public.vt_loon_locations VALUES ('Martin''s', 'Peacham', 'nc', 82, 'MARTINS', 85, 'MARTINS');
INSERT INTO public.vt_loon_locations VALUES ('Marshfield Pond (Turtlehead Pond)', 'Marshfield', 'nc', 69, 'TURTLEHEAD', 90, 'TURTLEHEAD');
INSERT INTO public.vt_loon_locations VALUES ('Mollys Falls', 'Marshfield', 'nc', 397, 'MOLLYS FALLS', 90, 'MOLLYS FALLS');
INSERT INTO public.vt_loon_locations VALUES ('Monkton (Cedar)', 'Monkton', 'cha-n', 123, 'CEDAR', 97, 'CEDAR');
INSERT INTO public.vt_loon_locations VALUES ('Bald Hill', 'Westmore', 'nek', 108, 'BALD HILL', 34, 'BALD HILL');
INSERT INTO public.vt_loon_locations VALUES ('Jobs', 'Westmore', 'nek', 39, 'JOBS', 34, 'JOBS');
INSERT INTO public.vt_loon_locations VALUES ('Willoughby', 'Westmore', 'nek', 1653, 'WILLOUGHBY', 34, 'WILLOUGHBY');
INSERT INTO public.vt_loon_locations VALUES ('Bean (Sutton)', 'Sutton', 'nek', 30, 'BEAN (SUTTON)', 46, 'BEAN (SUTTON)');
INSERT INTO public.vt_loon_locations VALUES ('Marl', 'Sutton', 'nek', 10, 'MARL', 46, 'MARL');
INSERT INTO public.vt_loon_locations VALUES ('Wolcott', 'Wolcott', 'nc', 74, 'WOLCOTT', 59, 'WOLCOTT');
INSERT INTO public.vt_loon_locations VALUES ('Flagg', 'Wheelock', 'nc', 111, 'FLAGG', 61, 'FLAGG');
INSERT INTO public.vt_loon_locations VALUES ('Coles', 'Walden', 'nc', 125, 'COLES', 72, 'COLES');
INSERT INTO public.vt_loon_locations VALUES ('Lyford', 'Walden', 'nc', 33, 'LYFORD', 72, 'LYFORD');
INSERT INTO public.vt_loon_locations VALUES ('Woodbury', 'Woodbury', 'nc', 142, 'WOODBURY', 77, 'WOODBURY');
INSERT INTO public.vt_loon_locations VALUES ('East Long', 'Woodbury', 'nc', 188, 'EAST LONG', 77, 'EAST LONG');
INSERT INTO public.vt_loon_locations VALUES ('Cranberry Meadow', 'Woodbury', 'nc', 28, 'CRANBERRY MEADOW', 77, 'CRANBERRY MEADOW');
INSERT INTO public.vt_loon_locations VALUES ('Buck', 'Woodbury', 'nc', 39, 'BUCK', 77, 'BUCK');
INSERT INTO public.vt_loon_locations VALUES ('Greenwood', 'Woodbury', 'nc', 96, 'GREENWOOD', 77, 'GREENWOOD');
INSERT INTO public.vt_loon_locations VALUES ('Nichols', 'Woodbury', 'nc', 171, 'NICHOLS', 77, 'NICHOLS');
INSERT INTO public.vt_loon_locations VALUES ('Moore', 'Waterford', 'nek', 1235, 'MOORE', 80, 'MOORE');
INSERT INTO public.vt_loon_locations VALUES ('Stiles', 'Waterford', 'nek', 135, 'STILES', 80, 'STILES');
INSERT INTO public.vt_loon_locations VALUES ('Norford', 'Thetford', 'ec', 21, 'NORFORD', 131, 'NORFORD');
INSERT INTO public.vt_loon_locations VALUES ('Abenaki', 'Thetford', 'ec', 44, 'ABENAKI', 131, 'ABENAKI');
INSERT INTO public.vt_loon_locations VALUES ('Runnemede', 'Windsor', 'ec', 62, 'RUNNEMEDE', 149, 'RUNNEMEDE');
INSERT INTO public.vt_loon_locations VALUES ('Little Rock', 'Wallingford', 'wc', 18, 'LITTLE ROCK', 150, 'LITTLE ROCK');
INSERT INTO public.vt_loon_locations VALUES ('Wallingford', 'Wallingford', 'wc', 87, 'WALLINGFORD', 150, 'WALLINGFORD');
INSERT INTO public.vt_loon_locations VALUES ('Wantastiquet', 'Weston', 'gm-s', 44, 'WANTASTIQUET', 155, 'WANTASTIQUET');
INSERT INTO public.vt_loon_locations VALUES ('Moses', 'Weston', 'gm-s', 12, 'MOSES', 155, 'MOSES');
INSERT INTO public.vt_loon_locations VALUES ('Branch', 'Sunderland', 'gm-s', 34, 'BRANCH', 172, 'BRANCH');
INSERT INTO public.vt_loon_locations VALUES ('Bourn', 'Sunderland', 'gm-s', 48, 'BOURN', 172, 'BOURN');
INSERT INTO public.vt_loon_locations VALUES ('Raponda', 'Wilmington', 'gm-s', 121, 'RAPONDA', 186, 'RAPONDA');
INSERT INTO public.vt_loon_locations VALUES ('Sadawga', 'Whitingham', 'gm-s', 194, 'SADAWGA', 192, 'SADAWGA');
INSERT INTO public.vt_loon_locations VALUES ('Cutter', 'Williamstown', 'ec', 16, 'CUTTER', 217, 'CUTTER');
INSERT INTO public.vt_loon_locations VALUES ('Rood', 'Williamstown', 'ec', 23, 'ROOD', 217, 'ROOD');
INSERT INTO public.vt_loon_locations VALUES ('Little (Wells)', 'Wells', 'wc', 177, 'LITTLE (WELLS)', 222, 'LITTLE (WELLS)');
INSERT INTO public.vt_loon_locations VALUES ('St. Catherine', 'Wells', 'wc', 883, 'ST. CATHERINE', 222, 'ST. CATHERINE');
INSERT INTO public.vt_loon_locations VALUES ('Stoughton', 'Weathersfield', 'ec', 56, 'STOUGHTON', 228, 'STOUGHTON');
INSERT INTO public.vt_loon_locations VALUES ('Nelson', 'Woodbury', 'nc', 133, 'FOREST (CALAIS)', 77, 'FOREST (CALAIS)');
INSERT INTO public.vt_loon_locations VALUES ('Wrightsville', 'East Montpelier', 'nc', 190, 'WRIGHTSVILLE', 78, 'WRIGHTSVILLE');
INSERT INTO public.vt_loon_locations VALUES ('Long (Westmore)', 'Westmore', 'nek', 90, 'LONG (WESTMR)', 34, 'LONG (WESTMR)');
INSERT INTO public.vt_loon_locations VALUES ('Bruce', 'Sutton', 'nc', 27, 'BRUCE', 46, 'BRUCE');
INSERT INTO public.vt_loon_locations VALUES ('Chandler', 'Wheelock', 'nc', 68, 'CHANDLER (WHLOCK)', 61, 'CHANDLER (WHLOCK)');
INSERT INTO public.vt_loon_locations VALUES ('Dog (Valley)', 'Woodbury', 'nc', 88, 'VALLEY', 77, 'VALLEY');
INSERT INTO public.vt_loon_locations VALUES ('Comerford', 'Waterford', 'nek', 777, 'COMERFORD', 80, 'COMERFORD');
INSERT INTO public.vt_loon_locations VALUES ('Waterbury - South end', 'Waterbury', 'nc', 839, 'WATERBURY', 89, 'WATERBURY');
INSERT INTO public.vt_loon_locations VALUES ('Mill', 'Windsor', 'ec', 77, 'MILL (WINDSR)', 149, 'MILL (WINDSR)');
INSERT INTO public.vt_loon_locations VALUES ('Beebe (Sund)', 'Sunderland', 'gm-s', 13, 'BEEBE (SUNDLD)', 172, 'BEEBE (SUNDLD)');


--
-- TOC entry 3947 (class 0 OID 90766)
-- Dependencies: 206
-- Data for Name: vt_town; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vt_town VALUES (0, 'Unknown', 0, NULL);
INSERT INTO public.vt_town VALUES (1, 'Canaan', 9, NULL);
INSERT INTO public.vt_town VALUES (2, 'Franklin', 11, NULL);
INSERT INTO public.vt_town VALUES (3, 'Berkshire', 11, NULL);
INSERT INTO public.vt_town VALUES (4, 'Highgate', 11, NULL);
INSERT INTO public.vt_town VALUES (5, 'Richford', 11, NULL);
INSERT INTO public.vt_town VALUES (6, 'Alburgh', 13, NULL);
INSERT INTO public.vt_town VALUES (7, 'Norton', 9, NULL);
INSERT INTO public.vt_town VALUES (8, 'Averill', 9, NULL);
INSERT INTO public.vt_town VALUES (9, 'Holland', 19, NULL);
INSERT INTO public.vt_town VALUES (10, 'Jay', 19, NULL);
INSERT INTO public.vt_town VALUES (11, 'Troy', 19, NULL);
INSERT INTO public.vt_town VALUES (12, 'Lemington', 9, NULL);
INSERT INTO public.vt_town VALUES (13, 'Isle La Motte', 13, NULL);
INSERT INTO public.vt_town VALUES (15, 'Warren Gore', 9, NULL);
INSERT INTO public.vt_town VALUES (16, 'Warners Grant', 9, NULL);
INSERT INTO public.vt_town VALUES (17, 'Sheldon', 11, NULL);
INSERT INTO public.vt_town VALUES (18, 'Morgan', 19, NULL);
INSERT INTO public.vt_town VALUES (19, 'Lewis', 9, NULL);
INSERT INTO public.vt_town VALUES (20, 'Swanton', 11, NULL);
INSERT INTO public.vt_town VALUES (21, 'North Hero', 13, NULL);
INSERT INTO public.vt_town VALUES (22, 'Enosburgh', 11, NULL);
INSERT INTO public.vt_town VALUES (23, 'Westfield', 19, NULL);
INSERT INTO public.vt_town VALUES (24, 'Charleston', 19, NULL);
INSERT INTO public.vt_town VALUES (26, 'Brownington', 19, NULL);
INSERT INTO public.vt_town VALUES (27, 'Fairfield', 11, NULL);
INSERT INTO public.vt_town VALUES (28, 'Bloomfield', 9, NULL);
INSERT INTO public.vt_town VALUES (29, 'Brighton', 9, NULL);
INSERT INTO public.vt_town VALUES (30, 'Irasburg', 19, NULL);
INSERT INTO public.vt_town VALUES (31, 'Lowell', 19, NULL);
INSERT INTO public.vt_town VALUES (32, 'Bakersfield', 11, NULL);
INSERT INTO public.vt_town VALUES (34, 'Westmore', 19, NULL);
INSERT INTO public.vt_town VALUES (35, 'Ferdinand', 9, NULL);
INSERT INTO public.vt_town VALUES (36, 'Brunswick', 9, NULL);
INSERT INTO public.vt_town VALUES (37, 'Belvidere', 15, NULL);
INSERT INTO public.vt_town VALUES (38, 'Georgia', 11, NULL);
INSERT INTO public.vt_town VALUES (39, 'Albany', 19, NULL);
INSERT INTO public.vt_town VALUES (40, 'Grand Isle', 13, NULL);
INSERT INTO public.vt_town VALUES (41, 'Waterville', 15, NULL);
INSERT INTO public.vt_town VALUES (42, 'Fairfax', 11, NULL);
INSERT INTO public.vt_town VALUES (43, 'Newark', 5, NULL);
INSERT INTO public.vt_town VALUES (44, 'Fletcher', 11, NULL);
INSERT INTO public.vt_town VALUES (45, 'Barton', 19, NULL);
INSERT INTO public.vt_town VALUES (46, 'Sutton', 5, NULL);
INSERT INTO public.vt_town VALUES (47, 'Glover', 19, NULL);
INSERT INTO public.vt_town VALUES (48, 'Milton', 7, NULL);
INSERT INTO public.vt_town VALUES (49, 'East Haven', 9, NULL);
INSERT INTO public.vt_town VALUES (50, 'Craftsbury', 19, NULL);
INSERT INTO public.vt_town VALUES (51, 'Cambridge', 15, NULL);
INSERT INTO public.vt_town VALUES (52, 'Sheffield', 5, NULL);
INSERT INTO public.vt_town VALUES (53, 'South Hero', 13, NULL);
INSERT INTO public.vt_town VALUES (54, 'Granby', 9, NULL);
INSERT INTO public.vt_town VALUES (55, 'Greensboro', 19, NULL);
INSERT INTO public.vt_town VALUES (56, 'Burke', 5, NULL);
INSERT INTO public.vt_town VALUES (57, 'Westford', 7, NULL);
INSERT INTO public.vt_town VALUES (58, 'Johnson', 15, NULL);
INSERT INTO public.vt_town VALUES (59, 'Wolcott', 15, NULL);
INSERT INTO public.vt_town VALUES (60, 'Underhill', 7, NULL);
INSERT INTO public.vt_town VALUES (61, 'Wheelock', 5, NULL);
INSERT INTO public.vt_town VALUES (62, 'Guildhall', 9, NULL);
INSERT INTO public.vt_town VALUES (63, 'Victory', 9, NULL);
INSERT INTO public.vt_town VALUES (64, 'Hyde Park', 15, NULL);
INSERT INTO public.vt_town VALUES (65, 'Morristown', 15, NULL);
INSERT INTO public.vt_town VALUES (66, 'Hardwick', 5, NULL);
INSERT INTO public.vt_town VALUES (67, 'Stannard', 5, NULL);
INSERT INTO public.vt_town VALUES (68, 'Kirby', 5, NULL);
INSERT INTO public.vt_town VALUES (69, 'Stowe', 15, NULL);
INSERT INTO public.vt_town VALUES (70, 'Elmore', 15, NULL);
INSERT INTO public.vt_town VALUES (71, 'Lyndon', 5, NULL);
INSERT INTO public.vt_town VALUES (72, 'Walden', 5, NULL);
INSERT INTO public.vt_town VALUES (73, 'Lunenburg', 9, NULL);
INSERT INTO public.vt_town VALUES (74, 'Jericho', 7, NULL);
INSERT INTO public.vt_town VALUES (76, 'Concord', 9, NULL);
INSERT INTO public.vt_town VALUES (77, 'Woodbury', 23, NULL);
INSERT INTO public.vt_town VALUES (78, 'Worcester', 23, NULL);
INSERT INTO public.vt_town VALUES (79, 'Bolton', 7, NULL);
INSERT INTO public.vt_town VALUES (80, 'Waterford', 5, NULL);
INSERT INTO public.vt_town VALUES (81, 'Calais', 23, NULL);
INSERT INTO public.vt_town VALUES (83, 'Barnet', 5, NULL);
INSERT INTO public.vt_town VALUES (84, 'Middlesex', 23, NULL);
INSERT INTO public.vt_town VALUES (85, 'Peacham', 5, NULL);
INSERT INTO public.vt_town VALUES (86, 'Duxbury', 23, NULL);
INSERT INTO public.vt_town VALUES (87, 'Charlotte', 7, NULL);
INSERT INTO public.vt_town VALUES (88, 'Huntington', 7, NULL);
INSERT INTO public.vt_town VALUES (89, 'Waterbury', 23, NULL);
INSERT INTO public.vt_town VALUES (90, 'Marshfield', 23, NULL);
INSERT INTO public.vt_town VALUES (91, 'East Montpelier', 23, NULL);
INSERT INTO public.vt_town VALUES (92, 'Moretown', 23, NULL);
INSERT INTO public.vt_town VALUES (93, 'Montpelier', 23, NULL);
INSERT INTO public.vt_town VALUES (94, 'Starksboro', 1, NULL);
INSERT INTO public.vt_town VALUES (95, 'Groton', 5, NULL);
INSERT INTO public.vt_town VALUES (96, 'Plainfield', 23, NULL);
INSERT INTO public.vt_town VALUES (97, 'Monkton', 1, NULL);
INSERT INTO public.vt_town VALUES (98, 'Fayston', 23, NULL);
INSERT INTO public.vt_town VALUES (99, 'Berlin', 23, NULL);
INSERT INTO public.vt_town VALUES (100, 'Ferrisburgh', 1, NULL);
INSERT INTO public.vt_town VALUES (101, 'Barre Town', 23, NULL);
INSERT INTO public.vt_town VALUES (102, 'Buels Gore', 7, NULL);
INSERT INTO public.vt_town VALUES (103, 'Orange', 17, NULL);
INSERT INTO public.vt_town VALUES (104, 'Barre City', 23, NULL);
INSERT INTO public.vt_town VALUES (105, 'Bristol', 1, NULL);
INSERT INTO public.vt_town VALUES (106, 'Topsham', 17, NULL);
INSERT INTO public.vt_town VALUES (107, 'Vergennes', 1, NULL);
INSERT INTO public.vt_town VALUES (108, 'New Haven', 1, NULL);
INSERT INTO public.vt_town VALUES (109, 'Panton', 1, NULL);
INSERT INTO public.vt_town VALUES (110, 'Waltham', 1, NULL);
INSERT INTO public.vt_town VALUES (111, 'Lincoln', 1, NULL);
INSERT INTO public.vt_town VALUES (112, 'Washington', 17, NULL);
INSERT INTO public.vt_town VALUES (113, 'Addison', 1, NULL);
INSERT INTO public.vt_town VALUES (114, 'Corinth', 17, NULL);
INSERT INTO public.vt_town VALUES (115, 'Weybridge', 1, NULL);
INSERT INTO public.vt_town VALUES (116, 'Chelsea', 17, NULL);
INSERT INTO public.vt_town VALUES (117, 'Middlebury', 1, NULL);
INSERT INTO public.vt_town VALUES (118, 'Ripton', 1, NULL);
INSERT INTO public.vt_town VALUES (119, 'Bridport', 1, NULL);
INSERT INTO public.vt_town VALUES (120, 'Cornwall', 1, NULL);
INSERT INTO public.vt_town VALUES (121, 'Vershire', 17, NULL);
INSERT INTO public.vt_town VALUES (122, 'West Fairlee', 17, NULL);
INSERT INTO public.vt_town VALUES (123, 'Fairlee', 17, NULL);
INSERT INTO public.vt_town VALUES (124, 'Hancock', 1, NULL);
INSERT INTO public.vt_town VALUES (125, 'Tunbridge', 17, NULL);
INSERT INTO public.vt_town VALUES (126, 'Salisbury', 1, NULL);
INSERT INTO public.vt_town VALUES (127, 'Rochester', 27, NULL);
INSERT INTO public.vt_town VALUES (128, 'Shoreham', 1, NULL);
INSERT INTO public.vt_town VALUES (129, 'Strafford', 17, NULL);
INSERT INTO public.vt_town VALUES (130, 'Bethel', 27, NULL);
INSERT INTO public.vt_town VALUES (131, 'Thetford', 17, NULL);
INSERT INTO public.vt_town VALUES (132, 'Royalton', 27, NULL);
INSERT INTO public.vt_town VALUES (133, 'Orwell', 1, NULL);
INSERT INTO public.vt_town VALUES (134, 'Pittsfield', 21, NULL);
INSERT INTO public.vt_town VALUES (135, 'Sharon', 27, NULL);
INSERT INTO public.vt_town VALUES (136, 'Stockbridge', 27, NULL);
INSERT INTO public.vt_town VALUES (137, 'Norwich', 27, NULL);
INSERT INTO public.vt_town VALUES (138, 'Barnard', 27, NULL);
INSERT INTO public.vt_town VALUES (139, 'Benson', 21, NULL);
INSERT INTO public.vt_town VALUES (140, 'Hartford', 27, NULL);
INSERT INTO public.vt_town VALUES (141, 'Killington', 21, NULL);
INSERT INTO public.vt_town VALUES (142, 'Bridgewater', 27, NULL);
INSERT INTO public.vt_town VALUES (143, 'West Haven', 21, NULL);
INSERT INTO public.vt_town VALUES (144, 'Fair Haven', 21, NULL);
INSERT INTO public.vt_town VALUES (145, 'Hartland', 27, NULL);
INSERT INTO public.vt_town VALUES (146, 'Plymouth', 27, NULL);
INSERT INTO public.vt_town VALUES (147, 'Shrewsbury', 21, NULL);
INSERT INTO public.vt_town VALUES (148, 'Reading', 27, NULL);
INSERT INTO public.vt_town VALUES (149, 'Windsor', 27, NULL);
INSERT INTO public.vt_town VALUES (150, 'Wallingford', 21, NULL);
INSERT INTO public.vt_town VALUES (152, 'Pawlet', 21, NULL);
INSERT INTO public.vt_town VALUES (153, 'Danby', 21, NULL);
INSERT INTO public.vt_town VALUES (154, 'Mount Tabor', 21, NULL);
INSERT INTO public.vt_town VALUES (155, 'Weston', 27, NULL);
INSERT INTO public.vt_town VALUES (156, 'Andover', 27, NULL);
INSERT INTO public.vt_town VALUES (157, 'Springfield', 27, NULL);
INSERT INTO public.vt_town VALUES (158, 'Rupert', 3, NULL);
INSERT INTO public.vt_town VALUES (159, 'Dorset', 3, NULL);
INSERT INTO public.vt_town VALUES (160, 'Peru', 3, NULL);
INSERT INTO public.vt_town VALUES (161, 'Landgrove', 3, NULL);
INSERT INTO public.vt_town VALUES (162, 'Londonderry', 25, NULL);
INSERT INTO public.vt_town VALUES (163, 'Grafton', 25, NULL);
INSERT INTO public.vt_town VALUES (164, 'Windham', 25, NULL);
INSERT INTO public.vt_town VALUES (165, 'Sandgate', 3, NULL);
INSERT INTO public.vt_town VALUES (166, 'Winhall', 3, NULL);
INSERT INTO public.vt_town VALUES (167, 'Manchester', 3, NULL);
INSERT INTO public.vt_town VALUES (168, 'Jamaica', 25, NULL);
INSERT INTO public.vt_town VALUES (169, 'Townshend', 25, NULL);
INSERT INTO public.vt_town VALUES (170, 'Westminster', 25, NULL);
INSERT INTO public.vt_town VALUES (171, 'Arlington', 3, NULL);
INSERT INTO public.vt_town VALUES (172, 'Sunderland', 3, NULL);
INSERT INTO public.vt_town VALUES (173, 'Stratton', 25, NULL);
INSERT INTO public.vt_town VALUES (174, 'Brookline', 25, NULL);
INSERT INTO public.vt_town VALUES (175, 'Wardsboro', 25, NULL);
INSERT INTO public.vt_town VALUES (176, 'Shaftsbury', 3, NULL);
INSERT INTO public.vt_town VALUES (177, 'Glastenbury', 3, NULL);
INSERT INTO public.vt_town VALUES (178, 'Somerset', 25, NULL);
INSERT INTO public.vt_town VALUES (179, 'Putney', 25, NULL);
INSERT INTO public.vt_town VALUES (180, 'Newfane', 25, NULL);
INSERT INTO public.vt_town VALUES (181, 'Dover', 25, NULL);
INSERT INTO public.vt_town VALUES (182, 'Dummerston', 25, NULL);
INSERT INTO public.vt_town VALUES (183, 'Bennington', 3, NULL);
INSERT INTO public.vt_town VALUES (184, 'Woodford', 3, NULL);
INSERT INTO public.vt_town VALUES (185, 'Searsburg', 3, NULL);
INSERT INTO public.vt_town VALUES (186, 'Wilmington', 25, NULL);
INSERT INTO public.vt_town VALUES (187, 'Marlboro', 25, NULL);
INSERT INTO public.vt_town VALUES (188, 'Brattleboro', 25, NULL);
INSERT INTO public.vt_town VALUES (189, 'Readsboro', 3, NULL);
INSERT INTO public.vt_town VALUES (190, 'Pownal', 3, NULL);
INSERT INTO public.vt_town VALUES (191, 'Stamford', 3, NULL);
INSERT INTO public.vt_town VALUES (192, 'Whitingham', 25, NULL);
INSERT INTO public.vt_town VALUES (193, 'Halifax', 25, NULL);
INSERT INTO public.vt_town VALUES (194, 'Guilford', 25, NULL);
INSERT INTO public.vt_town VALUES (195, 'Vernon', 25, NULL);
INSERT INTO public.vt_town VALUES (196, 'Montgomery', 11, NULL);
INSERT INTO public.vt_town VALUES (197, 'Eden', 15, NULL);
INSERT INTO public.vt_town VALUES (198, 'Maidstone', 9, NULL);
INSERT INTO public.vt_town VALUES (199, 'Colchester', 7, NULL);
INSERT INTO public.vt_town VALUES (200, 'Danville', 5, NULL);
INSERT INTO public.vt_town VALUES (201, 'Winooski', 7, NULL);
INSERT INTO public.vt_town VALUES (202, 'Cabot', 23, NULL);
INSERT INTO public.vt_town VALUES (203, 'Shelburne', 7, NULL);
INSERT INTO public.vt_town VALUES (204, 'Richmond', 7, NULL);
INSERT INTO public.vt_town VALUES (205, 'Hinesburg', 7, NULL);
INSERT INTO public.vt_town VALUES (206, 'Pomfret', 27, NULL);
INSERT INTO public.vt_town VALUES (207, 'Woodstock', 27, NULL);
INSERT INTO public.vt_town VALUES (208, 'Rutland City', 21, NULL);
INSERT INTO public.vt_town VALUES (209, 'Burlington', 7, NULL);
INSERT INTO public.vt_town VALUES (210, 'Braintree', 17, NULL);
INSERT INTO public.vt_town VALUES (211, 'Randolph', 17, NULL);
INSERT INTO public.vt_town VALUES (212, 'Essex', 7, NULL);
INSERT INTO public.vt_town VALUES (213, 'Ryegate', 5, NULL);
INSERT INTO public.vt_town VALUES (214, 'Newbury', 17, NULL);
INSERT INTO public.vt_town VALUES (215, 'South Burlington', 7, NULL);
INSERT INTO public.vt_town VALUES (216, 'Williston', 7, NULL);
INSERT INTO public.vt_town VALUES (217, 'Williamstown', 17, NULL);
INSERT INTO public.vt_town VALUES (218, 'Brookfield', 17, NULL);
INSERT INTO public.vt_town VALUES (219, 'Bradford', 17, NULL);
INSERT INTO public.vt_town VALUES (220, 'Poultney', 21, NULL);
INSERT INTO public.vt_town VALUES (221, 'Tinmouth', 21, NULL);
INSERT INTO public.vt_town VALUES (222, 'Wells', 21, NULL);
INSERT INTO public.vt_town VALUES (223, 'Middletown Springs', 21, NULL);
INSERT INTO public.vt_town VALUES (224, 'West Windsor', 27, NULL);
INSERT INTO public.vt_town VALUES (225, 'Chester', 27, NULL);
INSERT INTO public.vt_town VALUES (226, 'Cavendish', 27, NULL);
INSERT INTO public.vt_town VALUES (227, 'Baltimore', 27, NULL);
INSERT INTO public.vt_town VALUES (228, 'Weathersfield', 27, NULL);
INSERT INTO public.vt_town VALUES (229, 'Newport Town', 19, NULL);
INSERT INTO public.vt_town VALUES (230, 'Derby', 19, NULL);
INSERT INTO public.vt_town VALUES (231, 'Coventry', 19, NULL);
INSERT INTO public.vt_town VALUES (232, 'Newport City', 19, NULL);
INSERT INTO public.vt_town VALUES (233, 'Northfield', 23, NULL);
INSERT INTO public.vt_town VALUES (234, 'Waitsfield', 23, NULL);
INSERT INTO public.vt_town VALUES (235, 'Rockingham', 25, NULL);
INSERT INTO public.vt_town VALUES (236, 'Athens', 25, NULL);
INSERT INTO public.vt_town VALUES (237, 'Granville', 1, NULL);
INSERT INTO public.vt_town VALUES (238, 'Roxbury', 23, NULL);
INSERT INTO public.vt_town VALUES (239, 'Warren', 23, NULL);
INSERT INTO public.vt_town VALUES (240, 'Goshen', 1, NULL);
INSERT INTO public.vt_town VALUES (241, 'Whiting', 1, NULL);
INSERT INTO public.vt_town VALUES (242, 'Leicester', 1, NULL);
INSERT INTO public.vt_town VALUES (243, 'Chittenden', 21, NULL);
INSERT INTO public.vt_town VALUES (244, 'Sudbury', 21, NULL);
INSERT INTO public.vt_town VALUES (245, 'Hubbardton', 21, NULL);
INSERT INTO public.vt_town VALUES (246, 'Castleton', 21, NULL);
INSERT INTO public.vt_town VALUES (247, 'Ira', 21, NULL);
INSERT INTO public.vt_town VALUES (248, 'Brandon', 21, NULL);
INSERT INTO public.vt_town VALUES (249, 'Pittsford', 21, NULL);
INSERT INTO public.vt_town VALUES (250, 'West Rutland', 21, NULL);
INSERT INTO public.vt_town VALUES (251, 'Proctor', 21, NULL);
INSERT INTO public.vt_town VALUES (253, 'Mendon', 21, NULL);
INSERT INTO public.vt_town VALUES (254, 'Clarendon', 21, NULL);
INSERT INTO public.vt_town VALUES (255, 'Ludlow', 27, NULL);
INSERT INTO public.vt_town VALUES (25, 'Saint Albans Town', 11, 'St. Albans Town');
INSERT INTO public.vt_town VALUES (33, 'Saint Albans City', 11, 'St. Albans City');
INSERT INTO public.vt_town VALUES (75, 'Saint Johnsbury', 5, 'St. Johnsbury');
INSERT INTO public.vt_town VALUES (82, 'Saint George', 7, 'St. George');
INSERT INTO public.vt_town VALUES (252, 'Rutland Town', 21, 'Rutland');
INSERT INTO public.vt_town VALUES (151, 'Mount Holly', 21, 'Mt. Holly');
INSERT INTO public.vt_town VALUES (14, 'Averys Gore', 9, 'Avery''s Gore');


--
-- TOC entry 3945 (class 0 OID 90727)
-- Dependencies: 204
-- Data for Name: vt_water_body; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vt_water_body VALUES ('BAKER (BRKFLD)', 'Baker Pond', 'Brookfield', 'East Central', 35, 1067, 1290, 10, 3, 'ARTIFICIAL', 'Baker Pond Brookfield', 'Reservoir', 44.07, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BAKERSFIELD', 'Unnamed pond referred to by DEC as Bakersfield', 'Bakersfield', 'Champlain ', NULL, NULL, 780, NULL, NULL, NULL, 'Bakersfield Pond Bakersfield', 'Pond', 44.82, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BAKERSFIELD-N', 'Unnamed pond referred to by DEC as Bakersfield - N', 'Bakersfield', 'Champlain ', 10, 197, 720, NULL, NULL, NULL, 'Bakersfield - N Pond Bakersfield', 'Pond', 44.83, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BALD HILL', 'Bald Hill Pond', 'Westmore', 'NE Kingdom', 108, 2588, 1794, 42, 16, 'NATURAL', 'Bald Hill Pond Westmore', 'Pond', 44.7394947, -71.9778742, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BALDWIN', 'Baldwin Pond', 'Starksboro', 'Champlain ', 9, 201, 699, NULL, NULL, NULL, 'Baldwin Pond Starksboro', 'Pond', 44.2272783, -73.051787, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BALL MOUNTAIN', 'Ball Mountain Reservoir', 'Jamaica', 'Green Mtn South', 85, 110080, 870, NULL, NULL, 'ARTIFICIAL', 'Ball Mountain Reservoir Jamaica', 'Reservoir', 43.13, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BANCROFT', 'Bancroft Pond', 'Plainfield', 'North Central', 14, 167, 1470, 12, NULL, 'NATURAL', 'Bancroft Pond Plainfield', 'Pond', 44.2472827, -72.382046, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BARBER', 'Barber Lake (Lake Potter)', 'Pownal', 'Green Mtn South', 19, 170, 1103, 20, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Barber Pond Pownal', 'Lake (Artificial Control)', 42.8, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BARBOS', 'Barbos Lake', 'Sandgate', 'Green Mtn South', 7, 48, 1844, NULL, NULL, NULL, 'Barbos Lake Sandgate', 'Lake', 43.15, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BARKMILL', 'Unnamed pond referred to by DEC as Barkmill', 'Weathersfield', 'East Central', NULL, NULL, 800, NULL, NULL, NULL, 'Barkmill Pond Weathersfield', 'Pond', 43.35, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAN', 'Unnamed Pond referred to by DEC as Bean', 'Eden', 'North Central', NULL, NULL, 1250, NULL, NULL, NULL, 'Bean Pond Eden', 'Pond', 44.68, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAN (LYNDON)', 'Bean Pond', 'Lyndon', 'NE Kingdom', 24, 223, 1187, 15, NULL, 'NATURAL', 'Bean Pond Lyndon', 'Pond', 44.5486657, -72.0714867, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAN (SUTTON)', 'Bean Pond', 'Sutton', 'NE Kingdom', 30, 1208, 1178, NULL, NULL, 'NATURAL', 'Bean Pond Sutton', 'Pond', 44.6983842, -72.0862101, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAR', 'Bear Pond', 'Cambridge', 'Champlain ', 1, 2, 3530, NULL, NULL, NULL, 'Bear Pond Cambridge', 'Pond', 44.5550515, -72.8045682, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAR MOUNTAIN', 'Unnamed Pond referred to by DEC as Bear Mountain', 'Walden', 'North Central', NULL, NULL, 2155, NULL, NULL, NULL, 'Bear Mountain Pond Walden', 'Pond', 44.48, -72.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (HARTLD)', 'Beaver Pond', 'Hartland', 'East Central', 2, 157, 1170, NULL, NULL, NULL, 'Beaver Pond Hartland', 'Pond', 43.5736814, -72.463148, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (HOLLND)', 'Beaver Pond', 'Holland', 'NE Kingdom', 40, 721, 1535, 80, 30, 'NATURAL', 'Beaver Pond Holland', 'Pond', 45.0047684, -71.9398184, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (HYDEPK)', 'Unnamed Pond referred to by DEC as Beaver', 'Hyde Park', 'North Central', 16, 683, 1090, NULL, NULL, NULL, 'Beaver Pond Hyde Park', 'Pond', 44.6, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (MENDON)', 'Beaver Pond', 'Mendon', 'West Central', 6, 349, 1850, NULL, NULL, NULL, 'Beaver Pond Mendon', 'Pond', 43.6686787, -72.8539931, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (PROCTR)', 'Beaver Pond', 'Proctor', 'West Central', 9, 287, 552, NULL, NULL, NULL, 'Beaver Pond Proctor', 'Pond', 43.67, -73.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (ROXBRY)', 'Beaver Pond', 'Roxbury', 'East Central', 10, 40, 1710, NULL, NULL, NULL, 'Beaver Pond Roxbury', 'Pond', 44.0614517, -72.7203872, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER (WEAFLD)', 'Unnamed Pond referred to by DEC as Beaver', 'Weathersfield', 'East Central', 49, 480, 960, NULL, NULL, NULL, 'Beaver Pond Weathersfield', 'Pond', 43.4, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER MEADOW', 'Unnamed Pond referred to by DEC as Beaver Meadow', 'Baltimore', 'East Central', 5, 178, 930, NULL, NULL, NULL, 'Beaver Meadow Pond Baltimore', 'Pond', 44.87, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER MEADOW BRK-L', 'Unnamed Pond referred to by DEC as Beaver Meadow Brook - Lower', 'Enosburgh', 'Champlain ', 18, 2148, 700, NULL, NULL, NULL, 'Beaver Meadow Brook - Lower Pond Enosburgh', 'Pond', 44.9, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER MEADOW BRK-U', 'Unnamed Pond referred to by DEC as Beaver Meadow Brook - Lower', 'Enosburgh', 'Champlain ', 14, 222, 800, NULL, NULL, NULL, 'Beaver Meadow Brook - Lower Pond Enosburgh', 'Pond', 43.35, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEAVER MEADOWS', 'Beaver Meadows', 'Chittenden', 'West Central', 3, 380, 1925, NULL, NULL, NULL, 'Beaver Meadows Pond Chittenden', 'Pond', 43.77, -72.9, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BECK', 'Beck Pond', 'Newark', 'NE Kingdom', 6, 294, 1570, NULL, NULL, NULL, 'Beck Pond Newark', 'Pond', 44.7294949, -71.9167619, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEEBE (HUBDTN)', 'Beebe Pond', 'Hubbardton', 'West Central', 111, 1843, 618, 43, 26, 'NATURAL with ARTIFICIAL CONTROL', 'Beebe Pond Hubbardton', 'Lake (Artificial Control)', 43.7342306, -73.1831677, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEEBE (SUNDLD)', 'Beebe Pond', 'Sunderland', 'Green Mtn South', 8, 161, 2350, NULL, NULL, NULL, 'Beebe Pond Sunderland', 'Pond', 43.0523, -73.0320481, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEECHER', 'Beecher Pond', 'Brighton', 'NE Kingdom', 15, 597, 1227, NULL, NULL, NULL, 'Beecher Pond Brighton', 'Pond', 44.8117157, -71.849539, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BEETLE', 'Unnamed Pond referred to by DEC as Beetle', 'Troy', 'NE Kingdom', NULL, NULL, 915, NULL, NULL, NULL, 'Beetle Pond Troy', 'Pond', 44.92, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BELDING', 'Belding Pond', 'Johnson', 'North Central', 4, 86, 1190, NULL, NULL, NULL, 'Belding Pond Johnson', 'Pond', 44.6169953, -72.7098435, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BELLEVUE', 'Unnamed Pond referred to by DEC as Bellevue', 'Fairfield', 'Champlain ', NULL, NULL, 905, NULL, NULL, NULL, 'Bellevue Pond Fairfield', 'Pond', 44.77, -73.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BELVIDERE-NE', 'Unnamed Pond referred to by DEC as Belvidere - NE', 'Belvidere', 'Champlain ', 9, 426, 1150, NULL, NULL, NULL, 'Belvidere - NE Pond Belvidere', 'Pond', 44.7675485, -72.5965061, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BERKSHIRE', 'Unnamed Pond referred to by DEC as Berkshire', 'Berkshire', 'Champlain ', 8, 1312, 520, NULL, NULL, NULL, 'Berkshire Pond Berkshire', 'Pond', 44.97, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BERLIN', 'Berlin Pond', 'Berlin', 'North Central', 293, 6738, 976, 59, 27, 'NATURAL with ARTIFICIAL CONTROL', 'Berlin Pond Berlin', 'Lake (Artificial Control)', 44.18, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BIG', 'Big Pond (Woodford Lake)', 'Woodford', 'Green Mtn South', 31, 715, 2265, 28, 13, 'NATURAL with ARTIFICIAL CONTROL', 'Big Pond Woodford', 'Lake (Artificial Control)', 42.88, -73.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BIG MUD', 'Big Mud Pond', 'Mount Tabor', 'West Central', 15, 267, 2590, NULL, NULL, 'NATURAL', 'Big Mud Pond Mount Tabor', 'Pond', 43.3142404, -72.9314907, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BIG MUDDY', 'Big Muddy Pond', 'Eden', 'North Central', 17, 123, 1410, NULL, NULL, 'NATURAL', 'Big Muddy Pond Eden', 'Pond', 44.7558819, -72.5995616, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BILLINGS', 'Billings Pond', 'Searsburg', 'Green Mtn South', 4, 2070, 2310, NULL, NULL, NULL, 'Billings Pond Searsburg', 'Pond', 42.896469, -73.0084356, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BILLINGS MARSH', 'Billings Marsh Pond', 'West Haven', 'West Central', 56, 284, 100, NULL, NULL, 'NATURAL', 'Billings Marsh Pond West Haven', 'Pond', 43.6, -73.38, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLACK (HUBDTN)', 'Black Pond', 'Hubbardton', 'West Central', 20, 127, 626, 45, 16, 'NATURAL', 'Black Pond Hubbardton', 'Pond', 43.7031198, -73.2237234, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLACK (PLYMTH)', 'Black Pond', 'Plymouth', 'West Central', 20, 292, 1330, 7, NULL, 'ARTIFICIAL', 'Black Pond Plymouth', 'Reservoir', 43.55, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLAIR', 'Unnamed Pond referred to by DEC as Blair', 'Hancock', 'West Central', NULL, NULL, 990, NULL, NULL, NULL, 'Blair Pond Hancock', 'Pond', 43.93, -72.85, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLAKE', 'Unnamed Pond referred to by DEC as Blake', 'Windham', 'Green Mtn South', NULL, NULL, 1780, NULL, NULL, NULL, 'Blake Pond Windham', 'Pond', 43.15, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLAKE (SHEFLD)', 'Blake Pond', 'Sheffield', 'North Central', 7, 160, 1550, NULL, NULL, NULL, 'Blake Pond Sheffield', 'Pond', 44.63533, -72.1184329, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLAKE (SUTTON)', 'Blake Pond', 'Sutton', 'NE Kingdom', 8, 102, 1650, NULL, NULL, NULL, 'Blake Pond Sutton', 'Pond', 44.7128284, -72.0723209, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLISS', 'Bliss Pond', 'Calais', 'North Central', 46, 591, 1211, 15, 7, 'NATURAL', 'Bliss Pond Calais', 'Pond', 44.3525574, -72.5006635, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLODGETT', 'Unnamed Pond referred to by DEC as Blodgett', 'Bradford', 'East Central', 15, 2964, 650, NULL, NULL, NULL, 'Blodgett Pond Bradford', 'Pond', 44.03, -72.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLOODSUCKER', 'Bloodsucker Pond', 'Springfield', 'East Central', 4, 77, 910, NULL, NULL, NULL, 'Bloodsucker Pond Springfield', 'Pond', 43.3370183, -72.4289783, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLUE (CALAIS)', 'Blue Pond', 'Calais', 'North Central', 6, 70, 1210, NULL, NULL, NULL, 'Blue Pond Calais', 'Pond', 44.4117228, -72.4687192, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLUE (HALFAX)', 'Unnamed Pond referred to by DEC as Blue', 'Halifax', 'Green Mtn South', NULL, NULL, 1270, NULL, NULL, NULL, 'Blue Pond Halifax', 'Pond', 42.8, -72.77, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BLUEBERRY', 'Blueberry Lake (Warren Lake)', 'Warren', 'North Central', 48, 740, 1550, 16, NULL, 'ARTIFICIAL', 'Blueberry Lake Warren', 'Reservoir', 44.08, -72.83, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BM1145', 'Unnamed Pond referred to by DEC as BM1145', 'Plymouth', 'West Central', 8, 87, 1090, NULL, NULL, NULL, 'BM1145 Pond Plymouth', 'Pond', 43.5, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BM746', 'Unnamed Pond referred to by DEC as BM746', 'Brookfield', 'East Central', 9, 4370, 730, NULL, NULL, NULL, 'BM746 Pond Brookfield', 'Pond', 44.05, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BOG (FAIRLE)', 'Bog Pond', 'Fairlee', 'East Central', 1, 16, 1070, NULL, NULL, NULL, 'Bog Pond Fairlee', 'Pond', 43.9536785, -72.1464793, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BOLSTER', 'Bolster Reservoir', 'Barre Town', 'North Central', 5, 242, 950, NULL, NULL, NULL, 'Bolster Reservoir Barre Town', 'Pond', 44.15, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BOMOSEEN', 'Lake Bomoseen', 'Castleton', 'West Central', 2360, 23630, 411, 65, 27, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Bomoseen Castleton', 'Lake (Artificial Control)', 43.6442324, -73.2131665, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BOULLEY', 'Unnamed Pond referred to by DEC as Boulley', 'Johnson', 'North Central', NULL, NULL, 915, NULL, NULL, NULL, 'Boulley Pond Johnson', 'Pond', 44.62, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BOURN', 'Bourn Pond', 'Sunderland', 'Green Mtn South', 55, 410, 2552, 27, NULL, 'NATURAL', 'Bourn Pond Sunderland', 'Pond', 43.1061882, -73.0020474, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BRANCH', 'Branch Pond', 'Sunderland', 'Green Mtn South', 34, 315, 2632, 35, 9, 'NATURAL', 'Branch Pond Sunderland', 'Pond', 43.0809107, -73.0189922, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BREESE', 'Breese Pond', 'Hubbardton', 'West Central', 22, 354, 552, NULL, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Breese Pond Hubbardton', 'Lake (Artificial Control)', 43.7139529, -73.2156679, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BREEZE', 'Unnamed Pond referred to by DEC as Breeze', 'Hartland', 'East Central', NULL, NULL, 1200, NULL, NULL, NULL, 'Breeze Pond Hartland', 'Pond', 43.58, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BRISTOL-NW', 'Unnamed Pond referred to by DEC as Bristol - NW', 'Bristol', 'Champlain ', 9, 104, 565, NULL, NULL, NULL, 'Bristol - NW Pond Bristol', 'Pond', 44.17, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROCKLEBANK', 'Unnamed Pond referred to by DEC as Brocklebank', 'Tunbridge', 'East Central', 7, 197, 1830, NULL, NULL, NULL, 'Brocklebank Pond Tunbridge', 'Pond', 43.93, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROOKSIDE', 'Brookside Pond', 'Orwell', 'West Central', 14, 2416, 298, NULL, NULL, 'ARTIFICIAL', 'Brookside Pond Orwell', 'Reservoir', 43.78, -73.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROWN (WSTMOR)', 'Brown Pond', 'Westmore', 'NE Kingdom', 15, 254, 1850, NULL, NULL, NULL, 'Brown Pond Westmore', 'Pond', 44.7308838, -71.9820409, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROWN (WHTHAM)', 'Unnamed Pond referred to by DEC as Brown', 'Whitingham', 'Green Mtn South', NULL, NULL, 1980, NULL, NULL, NULL, 'Brown Pond Whitingham', 'Pond', 42.77, -72.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROWNINGTON', 'Brownington Pond', 'Brownington', 'NE Kingdom', 139, 3365, 991, 33, 18, 'NATURAL', 'Brownington Pond Brownington', 'Pond', 44.8786588, -72.1476007, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BROWNS', 'Browns Pond', 'Bakersfield', 'Champlain ', 10, 4661, 550, NULL, NULL, NULL, 'Browns Pond Bakersfield', 'Pond', 44.82, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BRUCE', 'Bruce Pond', 'Sheffield', 'North Central', 27, 369, 1546, 13, NULL, 'NATURAL', 'Bruce Pond Sheffield', 'Pond', 44.6403295, -72.187046, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BRUNSWICK SPRINGS', 'Brunswick Springs', 'Brunswick', 'NE Kingdom', 16, 140, 930, NULL, NULL, NULL, 'Brunswick Springs Pond Brunswick', 'Pond', 44.73, -71.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUCK', 'Buck Lake', 'Woodbury', 'North Central', 39, 225, 1345, 33, 14, 'NATURAL', 'Buck Lake Woodbury', 'Lake', 44.462555, -72.3995513, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUFFALO', 'Unnamed Pond referred to by DEC as Buffalo', 'West Fairlee', 'East Central', NULL, NULL, 910, NULL, NULL, NULL, 'Buffalo Pond West Fairlee', 'Pond', 43.97, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUGBEE', 'Unnamed Pond referred to by DEC as Bugbee', 'Woodford', 'Green Mtn South', 8, 1428, 2171, NULL, NULL, NULL, 'Bugbee Pond Woodford', 'Pond', 42.88, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BULLHEAD (BENSON)', 'Bullhead Pond', 'Benson', 'West Central', 7, 53, 535, NULL, NULL, NULL, 'Bullhead Pond Benson', 'Pond', 43.7347848, -73.331504, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BULLHEAD (MANCHR)', 'Bullhead Pond', 'Manchester', 'Green Mtn South', 5, 29, 730, NULL, NULL, NULL, 'Bullhead Pond Manchester', 'Pond', 43.2089645, -73.0176036, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BULLIS', 'Unnamed Pond referred to by DEC as Bullis', 'Franklin', 'Champlain ', 11, 3678, 290, NULL, NULL, NULL, 'Bullis Pond Franklin', 'Pond', 44.97, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BULLY', 'Unnamed Pond referred to by DEC as Bully', 'Wallingford', 'West Central', NULL, NULL, 2120, NULL, NULL, NULL, 'Bully Pond Wallingford', 'Pond', 43.42, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURBEE', 'Burbee Pond', 'Windham', 'Green Mtn South', 50, 2479, 1610, 5, NULL, 'ARTIFICIAL', 'Burbee Pond Windham', 'Reservoir', 43.15, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURLESON', 'Burleson Pond', 'Berkshire', 'Champlain ', 2, 23, 550, NULL, NULL, NULL, 'Burleson Pond Berkshire', 'Pond', 44.9739343, -72.796803, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURNELL', 'Burnell Pond', 'Brandon', 'West Central', 7, 144, 502, NULL, NULL, NULL, 'Burnell Pond Brandon', 'Pond', 43.8339524, -73.0759458, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURNHAM MTN', 'Unnamed Pond referred to by DEC as Burnham Mtn', 'Topsham', 'North Central', 8, 463, 1170, NULL, NULL, NULL, 'Burnham Mtn Pond Topsham', 'Pond', 44.18, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURR (PITTFD)', 'Burr Pond', 'Pittsford', 'West Central', 20, 142, 1170, 18, NULL, NULL, 'Burr Pond Pittsford', 'Pond', 43.6936779, -72.965941, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BURR (SUDBRY)', 'Burr Pond', 'Sudbury', 'West Central', 85, 1737, 514, 18, 14, 'NATURAL with ARTIFICIAL CONTROL', 'Burr Pond Sudbury', 'Lake (Artificial Control)', 43.77, -73.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUTLER', 'Butler Pond', 'Pittsford', 'West Central', 3, 99, 650, NULL, NULL, NULL, 'Butler Pond Pittsford', 'Pond', 43.6942326, -73.0803876, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUTTERNUT', 'Unnamed Pond referred to by DEC as Butternut', 'Bakersfield', 'Champlain ', NULL, NULL, 780, NULL, NULL, NULL, 'Butternut Pond Bakerfield', 'Pond', 44.8, -72.77, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BUTTON', 'Unnamed Pond referred to by DEC as Button', 'Wallingford', 'West Central', NULL, NULL, 1775, NULL, NULL, NULL, 'Button Pond Wallingford', 'Pond', 43.47, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('C.C.C.', 'C.C.C. Pond', 'Sharon', 'East Central', 9, 174, 1361, NULL, NULL, NULL, 'C.C.C. Pond Sharon', 'Pond', 43.82, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CAMBRIDGEPORT', 'Unnamed Pond referred to by DEC as Cambridgeport', 'Rockingham', 'Green Mtn South', 6, 2086, 600, NULL, NULL, NULL, 'Cambridgeport Pond Rockingham', 'Pond', 43.15, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CAP HILL', 'Unnamed Pond referred to by DEC as Cap Hill', 'Jericho', 'Champlain ', 9, 200, 1010, NULL, NULL, NULL, 'Cap Hill Pond Jericho', 'Pond', 44.53, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CARLTON', 'Carlton Reservoir', 'Woodstock', 'East Central', 4, 75, 1070, NULL, NULL, NULL, 'Carlton Reservoir Woodstock', 'Reservoir', 43.6, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CARMI', 'Lake Carmi', 'Franklin', 'Champlain ', 1402, 7710, 435, 33, 13, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Carmi Franklin', 'Lake (Artificial Control)', 44.9714333, -72.877911, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CASPIAN', 'Caspian Lake', 'Greensboro', 'North Central', 789, 4510, 1400, 142, 57, 'NATURAL with ARTIFICIAL CONTROL', 'Caspian Lake Greensboro', 'Lake (Artificial Control)', 44.58, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CASTLE', 'Unnamed Pond referred to by DEC as Castle', 'Somerset', 'Green Mtn South', NULL, NULL, 2018, NULL, NULL, NULL, 'Castle Pond Somerset', 'Pond', 42.95, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CEDAR', 'Cedar Lake (Monkton Pond)', 'Monkton', 'Champlain ', 123, 752, 492, 13, 6, 'NATURAL', 'Cedar Lake Monkton', 'Lake', 44.2500546, -73.1328998, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CENTER', 'Center Pond', 'Newark', 'NE Kingdom', 79, 3793, 1310, 72, 24, NULL, 'Center Pond Newark', 'Pond', 44.7144953, -71.9198175, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMPAGNE', 'Lake Champagne', 'Randolph', 'East Central', 3, 243, 1310, NULL, NULL, NULL, 'Lake Champagne Randolph', 'Lake', 43.95, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-BURLINGTON BAY', 'Burlington Bay - Lake Champlain', 'Burlington', 'Champlain ', 2532, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Burlington Bay Burlington', 'Lake', 44.48, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-ISLE LA MOTTE', 'Isle La Motte - Lake Champlain', 'Alburgh', 'Champlain ', 26202, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Isle La Motte Alburgh', 'Lake', 45, -73.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-MAIN LAKE', 'Main Section - Lake Champlain', 'South Hero', 'Champlain ', 42010, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Main Section South Hero', 'Lake', 44.7, -73.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-MALLETTS BAY', 'Malletts Bay - Lake Champlain', 'Colchester', 'Champlain ', 13388, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Malletts Bay Colchester', 'Lake', 44.58, -73.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-MISSISQUOI BAY', 'Missisquoi Bay - Lake Champlain', 'Alburgh', 'Champlain ', 7998, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Missisquoi Bay Alburgh', 'Lake', 45, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-NORTHEAST ARM', 'Northeast Arm - Lake Champlain', 'Swanton', 'Champlain ', 58184, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Northeast Arm Swanton', 'Lake', 44.97, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-OTTER CREEK', 'Otter Creek Section - Lake Champlain', 'Ferrisburgh', 'Champlain ', 4423, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Otter Creek Section Ferrisburgh', 'Lake', 44.27, -73.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-PORT HENRY', 'Port Henry Section - Lake Champlain', 'Ferrisburgh', 'Champlain ', 9302, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Port Henry Section Ferrisburgh', 'Lake', 44.2, -73.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-SHELBURNE BAY', 'Shelburne Bay - Lake Champlain', 'Shelburne', 'Champlain ', 2249, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Shelburne Bay Shelburne', 'Lake', 44.43, -73.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-SOUTH LAKE', 'Southern Section - Lake Champlain', 'Bridport', 'Champlain ', 5388, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - Southern Section Bridport', 'Lake', 44.03, -73.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAMP-ST. ALBANS BAY', 'St. Albans Bay - Lake Champlain', 'St. Albans Town', 'Champlain ', 2499, NULL, 95, NULL, NULL, NULL, 'Champlain Lake - St. Albans Bay St. Albans Town', 'Lake', 44.77, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHANDLER (WTRFRD)', 'Unnamed Pond referred to by DEC as Chandler', 'Waterford', 'NE Kingdom', 6, 1313, 845, NULL, NULL, NULL, 'Chandler Pond Wheelock', 'Lake (Artificial Control)', 44.38, -71.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHANDLER (WHLOCK)', 'Chandler Pond', 'Wheelock', 'North Central', 68, 1050, 1256, 6, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Chandler Pond Waterford', 'Pond', 44.53, -72.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHAPELS', 'Chapels Pond', 'East Montpelier', 'North Central', 2, 295, 1170, NULL, NULL, NULL, 'Chapels Pond East Montpelier', 'Pond', 44.3158915, -72.5192746, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHARLES BROWN', 'Unnamed Pond referred to by DEC as Charles Brown', 'Norwich', 'East Central', NULL, NULL, 700, NULL, NULL, NULL, 'Charles Brown Pond Norwich', 'Pond', 43.73, -72.33, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHARLESTON', 'Charleston Pond (Lubber Lake)', 'Charleston', 'NE Kingdom', 40, 67936, 1059, 30, NULL, 'ARTIFICIAL', 'Charleston Pond Charleston', 'Reservoir', 44.8928256, -72.0531538, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHESTER', 'Chester Reservoir', 'Chester', 'East Central', 5, 399, 1070, NULL, NULL, NULL, 'Chester Reservoir Chester', 'Reservoir', 43.28, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHESTNUT', 'Unnamed Pond referred to by DEC as Chestnut', 'Springfield', 'East Central', NULL, NULL, 460, NULL, NULL, NULL, 'Chestnut Pond Springfield', 'Pond', 43.28, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHILDS', 'Childs Pond', 'Thetford', 'East Central', 10, 33, 470, NULL, NULL, NULL, 'Childs Pond Thetford', 'Pond', 43.8189586, -72.1900896, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHIPMAN', 'Chipman Lake (Tinmouth Pond)', 'Tinmouth', 'West Central', 79, 535, 1194, 11, 7, 'NATURAL', 'Chipman Lake Tinmouth', 'Lake', 43.408405, -73.0301051, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHITTENDEN', 'Chittenden Reservoir', 'Chittenden', 'West Central', 702, 10180, 1495, 46, 26, 'ARTIFICIAL', 'Chittenden Reservoir Chittenden', 'Reservoir', 43.73, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CHOATE', 'Choate Pond', 'Orwell', 'West Central', 11, 76, 850, NULL, NULL, NULL, 'Choate Pond Orwell', 'Pond', 43.7792288, -73.2687258, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CLARA', 'Clara Lake', 'Whitingham', 'Green Mtn South', 18, 412, 1690, NULL, NULL, NULL, 'Clara Lake Whitingham', 'Lake', 42.7959153, -72.8800979, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CLEAR', 'Clear Pond', 'Hyde Park', 'North Central', 8, 40, 1190, NULL, NULL, NULL, 'Clear Pond Hyde Park', 'Pond', 44.6164403, -72.5023333, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CLEVELAND', 'Unnamed Pond referred to by DEC as Cleveland', 'Coventry', 'NE Kingdom', NULL, NULL, 1170, NULL, NULL, NULL, 'Cleveland Pond Coventry', 'Pond', 44.88, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CLOSSON', 'Closson Pond', 'Rockingham', 'Green Mtn South', 1, 16, 1170, NULL, NULL, NULL, 'Closson Pond Rockingham', 'Pond', 43.23, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CLYDE', 'Clyde Pond', 'Derby', 'NE Kingdom', 186, 89292, 878, 20, 11, 'ARTIFICIAL', 'Clyde Pond Derby', 'Reservoir', 44.9353246, -72.1712124, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COBB', 'Cobb Pond', 'Derby', 'NE Kingdom', 27, 138, 1121, NULL, NULL, NULL, 'Cobb Pond Derby', 'Pond', 44.9139361, -72.1345448, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COBURN', 'Coburn Pond', 'Ryegate', 'North Central', 5, 64, 790, NULL, NULL, NULL, 'Coburn Pond Ryegate', 'Pond', 44.2517283, -72.086205, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COGGMAN', 'Coggman Pond', 'West Haven', 'West Central', 20, 368, 110, 12, NULL, 'NATURAL', 'Coggman Pond West Haven', 'Pond', 43.6206213, -73.3748356, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COITS', 'Coits Pond', 'Cabot', 'North Central', 40, 325, 1334, 7, NULL, 'NATURAL', 'Coits Pond Cabot', 'Pond', 44.4472777, -72.3295486, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLBY', 'Colby Pond', 'Plymouth', 'West Central', 20, 314, 1572, 16, NULL, 'ARTIFICIAL', 'Colby Pond Plymouth', 'Reservoir', 43.47, -72.67, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLCHESTER', 'Colchester Pond', 'Colchester', 'Champlain ', 186, 1259, 404, 42, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Colchester Pond Colchester', 'Lake (Artificial Control)', 44.5550488, -73.1195741, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLE', 'Cole Pond', 'Jamaica', 'Green Mtn South', 41, 282, 1193, 13, 5, 'NATURAL', 'Cole Pond Jamaica', 'Pond', 43.1470213, -72.8056529, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLES', 'Coles Pond', 'Walden', 'North Central', 125, 744, 2194, 21, 8, 'NATURAL with ARTIFICIAL CONTROL', 'Coles Pond Walden', 'Lake (Artificial Control)', 44.52, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLES-E', 'Unnamed Pond referred to by DEC as Coles - E', 'Stannard', 'North Central', NULL, NULL, 2375, NULL, NULL, NULL, 'Coles - E Pond Stannard', 'Pond', 44.52, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLLINS', 'Collins Pond', 'Hyde Park', 'North Central', 16, 443, 1225, 20, NULL, 'NATURAL', 'Collins Pond Hyde Park', 'Pond', 44.6214402, -72.5042778, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COLTON', 'Colton Pond', 'Killington', 'West Central', 27, 501, 1325, 10, NULL, 'ARTIFICIAL', 'Colton Pond Killington', 'Reservoir', 43.7, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COMERFORD', 'Comerford Reservoir', 'Barnet', 'NE Kingdom', 777, 307121, 646, NULL, NULL, 'ARTIFICIAL', 'Comerford Reservoir Barnet', 'Reservoir', 44.33, -72.02, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CONANT', 'Unnamed Pond referred to by DEC as Conant', 'Thetford', 'East Central', NULL, NULL, 1070, NULL, NULL, NULL, 'Conant Pond Thetford', 'Pond', 43.85, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CONCORD', 'Unnamed Pond referred to by DEC as Concord', 'Concord', 'NE Kingdom', NULL, NULL, 990, NULL, NULL, NULL, 'Concord Pond Concord', 'Pond', 44.45, -71.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COOK', 'Cook Pond', 'Ludlow', 'Green Mtn South', 3, 56, 1123, NULL, NULL, NULL, 'Cook Pond Ludlow', 'Pond', 43.4300716, -72.7070412, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COOKS (SHRWBY)', 'Cooks Pond', 'Shrewsbury', 'West Central', 12, 184, 1753, NULL, NULL, NULL, 'Cooks Pond Shrewsbury', 'Pond', 43.5117366, -72.8539905, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COOKS (WEAFLD)', 'Cooks Pond', 'Weathersfield', 'East Central', 10, 218, 1075, NULL, NULL, NULL, 'Cooks Pond Weathersfield', 'Pond', 43.3767399, -72.4500901, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COPENHAGEN', 'Unnamed Pond referred to by DEC as Copenhagen', 'Waterford', 'NE Kingdom', NULL, NULL, 710, NULL, NULL, NULL, 'Copenhagen Pond Waterford', 'Pond', 44.35, -71.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COREZ', 'Corez Pond', 'Lowell', 'North Central', 9, 555, 1190, NULL, NULL, NULL, 'Corez Pond Lowell', 'Pond', 44.7600486, -72.5234459, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COW HILL', 'Unnamed Pond referred to by DEC as Cow Hill', 'Peacham', 'North Central', 8, 185, 1720, NULL, NULL, NULL, 'Cow Hill Pond Peacham', 'Pond', 44.38, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COW MOUNTAIN', 'Cow Mountain Pond', 'Granby', 'NE Kingdom', 10, 128, 2065, NULL, NULL, 'NATURAL', 'Cow Mountain Pond Granby', 'Pond', 44.5614442, -71.7017559, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('COX', 'Cox Reservoir', 'Woodstock', 'East Central', 2, 329, 970, NULL, NULL, NULL, 'Cox Reservoir Woodstock', 'Reservoir', 43.62, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRANBERRY BOG', 'Cranberry Bog', 'Weybridge', 'Champlain ', 2, 128, 990, NULL, NULL, NULL, 'Cranberry Bog Pond Weybridge', 'Pond', 44.07, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRANBERRY MEADOW', 'Cranberry Meadow Pond', 'Woodbury', 'North Central', 28, 1905, 1092, 23, NULL, 'NATURAL', 'Cranberry Meadow Pond Woodbury', 'Pond', 44.4208892, -72.4573301, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRANBERRY POOL;', 'Cranberry Pool', 'Highgate', 'Champlain ', NULL, NULL, NULL, NULL, NULL, NULL, 'Cranberry Pool Pond Highgate', 'Pond', 44.95, -73.14, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRESCENT', 'Crescent Lake', 'Sharon', 'East Central', 20, 955, 1162, NULL, NULL, NULL, 'Crescent Lake Sharon', 'Lake', 43.8, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CROW HILL', 'Unnamed Pond referred to by DEC as Crow Hill', 'St. Johnsbury', 'NE Kingdom', 5, 328, 930, NULL, NULL, NULL, 'Crow Hill Pond St. Johnsbury', 'Pond', 44.42, -72.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRYSTAL (BARTON)', 'Crystal Lake', 'Barton', 'NE Kingdom', 763, 14453, 945, 115, 71, 'NATURAL with ARTIFICIAL CONTROL', 'Crystal Lake Barton', 'Lake (Artificial Control)', 44.7467161, -72.1762128, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRYSTAL (HARTLD)', 'Crystal Pond', 'Hartland', 'East Central', 2, 81, 1350, NULL, NULL, NULL, 'Crystal Pond Hartland', 'Pond', 43.5936811, -72.4764817, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CRYSTAL (WILMTN)', 'Crystal Pond', 'Wilmington', 'Green Mtn South', 3, NULL, 2930, NULL, NULL, NULL, 'Crystal Pond Wilmington', 'Pond', 42.92, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CURTIS', 'Curtis Pond', 'Calais', 'North Central', 72, 917, 1219, 31, 11, 'NATURAL with ARTIFICIAL CONTROL', 'Curtis Pond Calais', 'Lake (Artificial Control)', 44.38, -72.5, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CUSHING HILL', 'Unnamed Pond referred to by DEC as Cushing Hill', 'Underhill', 'Champlain ', 9, 371, 910, NULL, NULL, NULL, 'Cushing Hill Pond Underhill', 'Pond', 44.48, -72.9, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CUTLER', 'Cutler Pond', 'Highgate', 'Champlain ', 25, 276, 250, 3, NULL, 'NATURAL', 'Cutler Pond Highgate', 'Pond', 44.9867087, -73.0370725, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CUTTER', 'Cutter Pond', 'Williamstown', 'East Central', 16, 858, 912, NULL, NULL, NULL, 'Cutter Pond Williamstown', 'Pond', 44.0906188, -72.5489933, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('CUTTINGSVILLE', 'Unnamed Pond referred to by DEC as Cuttingsville', 'Shrewsbury', 'West Central', NULL, NULL, 1530, NULL, NULL, NULL, 'Cuttingsville Pond Shrewsbury', 'Pond', 43.48, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DANBY', 'Danby Pond', 'Danby', 'West Central', 56, 388, 1403, 6, NULL, 'NATURAL', 'Danby Pond Danby', 'Pond', 43.3650727, -73.0506606, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DANIELS', 'Daniels Pond', 'Glover', 'North Central', 66, 1079, 1631, 13, 8, 'NATURAL', 'Daniels Pond Glover', 'Pond', 44.6767173, -72.2626038, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DANIELS-W', 'Unnamed Pond referred to by DEC as Daniels - W', 'Glover', 'North Central', 20, 441, 1210, NULL, NULL, 'NATURAL', 'Daniels - W Pond Glover', 'Pond', 44.68, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DANVILLE', 'Danville Reservoir', 'Danville', 'North Central', 2, 839, 1585, NULL, NULL, NULL, 'Danville Reservoir Danville', 'Reservoir', 44.42, -72.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DANYOW', 'Danyow Pond', 'Ferrisburgh', 'Champlain ', 192, 380, 100, NULL, NULL, 'ARTIFICIAL', 'Danyow Pond Ferrisburgh', 'Reservoir', 44.18, -73.3, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DARK', 'Unnamed Pond referred to by DEC as Dark', 'Eden', 'North Central', NULL, NULL, 1330, NULL, NULL, NULL, 'Dark Pond Eden', 'Pond', 44.75, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEER PARK', 'Deer Park Pond', 'Halifax', 'Green Mtn South', 22, 607, 1510, 9, NULL, 'ARTIFICIAL', 'Deer Park Pond Halifax', 'Reservoir', 42.78, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEER PARK-WEST', 'Unnamed Pond referred to by DEC as Deer Part - West', 'Halifax', 'Green Mtn South', 6, 247, 1550, NULL, NULL, NULL, 'Deer Part - West Pond Halifax', 'Pond', 42.78, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEERFIELD-LOWER', 'Unnamed Pond referred to by DEC as Deerfield - Lower', 'Stratton', 'Green Mtn South', NULL, NULL, 2215, NULL, NULL, NULL, 'Deerfield - Lower Pond Stratton', 'Pond', 43.03, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEERFIELD-N', 'Unnamed Pond referred to by DEC as Deerfield - N', 'Stratton', 'Green Mtn South', NULL, NULL, 2235, NULL, NULL, NULL, 'Deerfield - N Pond Stratton', 'Pond', 43.03, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEERFIELD-UPPER', 'Unnamed Pond referred to by DEC as Deerfield - Upper', 'Stratton', 'Green Mtn South', NULL, NULL, 2275, NULL, NULL, NULL, 'Deerfield - Upper Pond Stratton', 'Pond', 43.03, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DENNIS', 'Dennis Pond', 'Brunswick', 'NE Kingdom', 49, 5337, 1030, 3, 2, 'NATURAL', 'Dennis Pond Brunswick', 'Pond', 44.7303279, -71.6578674, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DERBY', 'Lake Derby', 'Derby', 'NE Kingdom', 207, 1156, 981, 19, 8, 'NATURAL', 'Lake Derby Derby', 'Lake', 44.9542134, -72.1162109, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEVILS', 'Unnamed Pond referred to by DEC as Devils', 'Alburgh', 'Champlain ', NULL, NULL, 1290, NULL, NULL, NULL, 'Devils Pond Alburgh', 'Pond', 44.9392075, -73.2612412, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DEWEYS MILL', 'Deweys MILL Pond', 'Hartford', 'East Central', 56, 969, 545, NULL, NULL, 'ARTIFICIAL', 'Deweys Mill Pond Hartford', 'Reservoir', 43.65, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DOBSON', 'Dobson Pond', 'Woodbury', 'North Central', 9, 122, 1230, NULL, NULL, NULL, 'Dobson Pond Woodbury', 'Pond', 44.4403332, -72.4492746, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DOLLIF', 'Unnamed Pond referred to by DEC as Dollif', 'Brighton', 'NE Kingdom', 5, 640, 1250, NULL, NULL, NULL, 'Dollif Pond Brighton', 'Pond', 44.83, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DOUGHTY', 'Doughty Pond', 'Orwell', 'West Central', 17, 424, 631, 20, NULL, 'NATURAL', 'Doughty Pond Orwell', 'Pond', 43.7586734, -73.2828923, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DOW', 'Dow Pond', 'Middlebury', 'West Central', 11, 1672, 428, NULL, NULL, NULL, 'Dow Pond Middlebury', 'Pond', 44.02, -73.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DOWNER', 'Unnamed Pond referred to by DEC as Downer', 'Sharon', 'East Central', NULL, NULL, 1390, NULL, NULL, NULL, 'Downer Pond Sharon', 'Pond', 43.8, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DRY', 'Dry Pond', 'Northfield', 'East Central', 2, 1296, 1212, NULL, NULL, NULL, 'Dry Pond Northfield', 'Pond', 44.1486727, -72.6023299, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DRY RIDGE', 'Unnamed Pond referred to by DEC as Dry Ridge', 'Johnson', 'North Central', 6, 850, 1270, NULL, NULL, NULL, 'Dry Ridge Pond Johnson', 'Pond', 44.62, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUBLIN', 'Unnamed Pond referred to by DEC as Dublin', 'Stratton', 'Green Mtn South', NULL, NULL, 2410, NULL, NULL, NULL, 'Dublin Pond Stratton', 'Pond', 43.07, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (BURKE)', 'Duck Pond', 'Burke', 'NE Kingdom', 4, 32, 970, NULL, NULL, NULL, 'Duck Pond Burke', 'Pond', 44.5997761, -71.945095, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (CRAFBY)', 'Duck Pond', 'Craftsbury', 'North Central', 9, 83, 1130, NULL, NULL, NULL, 'Duck Pond Craftsbury', 'Pond', 44.6733838, -72.3651069, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (HOLLND)', 'Duck Pond', 'Holland', 'NE Kingdom', 6, 117, 1530, NULL, NULL, NULL, 'Duck Pond Holland', 'Pond', 45.0047684, -71.9298183, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (SHEFLD)', 'Duck Pond', 'Sheffield', 'North Central', 7, 173, 1870, NULL, NULL, NULL, 'Duck Pond Sheffield', 'Pond', 44.6731069, -72.1356558, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (SHELBN)', 'Duck Pond', 'Shelburne', 'Champlain ', 4, 96, 170, NULL, NULL, NULL, 'Duck Pond Shelburne', 'Pond', 44.3778285, -73.2598487, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (SUTTON)', 'Duck Pond', 'Sutton', 'NE Kingdom', 8, 141, 1690, NULL, NULL, NULL, 'Duck Pond Sutton', 'Pond', 44.7086619, -72.0675986, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK (WATRFD)', 'Duck Pond', 'Waterford', 'NE Kingdom', 16, 215, 946, NULL, NULL, 'NATURAL', 'Duck Pond Waterford', 'Pond', 44.3933922, -71.9359261, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUCK-E', 'Unnamed Pond referred to by DEC as Duck - E', 'Burke', 'NE Kingdom', NULL, NULL, 890, NULL, NULL, NULL, 'Duck - E Pond Burke', 'Pond', 44.6, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUFRESNE', 'Dufresne Pond', 'Manchester', 'Green Mtn South', 8, 11234, 719, 10, NULL, 'ARTIFICIAL', 'Dufresne Pond Manchester', 'Reservoir', 43.18, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUNKLEE', 'Dunklee Pond', 'Rutland City', 'West Central', 3, 3335, 590, NULL, NULL, NULL, 'Dunklee Pond Rutland City', 'Pond', 43.6225679, -72.9731622, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUNMORE', 'Lake Dunmore', 'Salisbury', 'West Central', 985, 13068, 569, 105, 28, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Dunmore Salisbury', 'Lake (Artificial Control)', 43.9020068, -73.0753915, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('DUTTON', 'Dutton Pond', 'Maidstone', 'NE Kingdom', 12, 115, 1247, NULL, NULL, NULL, 'Dutton Pond Maidstone', 'Pond', 44.6403306, -71.6070316, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EAGLE', 'Eagle Pond', 'Alburgh', 'Champlain ', 2, 14, 95, NULL, NULL, NULL, 'Eagle Pond Alburgh', 'Pond', 44.9353186, -73.2615189, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EAST', 'Unnamed Pond referred to by DEC as East', 'Somerset', 'Green Mtn South', NULL, NULL, 2155, NULL, NULL, NULL, 'East Pond Somerset', 'Pond', 42.95, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EAST CALAIS MILL', 'Unnamed Pond referred to by DEC as East Calais Mill', 'Calais', 'North Central', 6, 11168, 850, NULL, NULL, NULL, 'East Calais Mill Pond Calais', 'Pond', 44.37, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EAST LONG', 'East Long Pond', 'Woodbury', 'North Central', 188, 2223, 1208, 105, 47, 'NATURAL with ARTIFICIAL CONTROL', 'East Long Pond Woodbury', 'Lake (Artificial Control)', 44.45, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EAST TWIN', 'East Twin Pond', 'Athens', 'Green Mtn South', 3, 15, 1150, NULL, NULL, NULL, 'East Twin Pond Athens', 'Pond', 43.13, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EASTMAN', 'Eastman', 'Newbury', 'East Central', 4, 43, 1250, NULL, NULL, NULL, 'Eastman Pond Newbury', 'Pond', 44.1311748, -72.1737048, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ECHO (CHARTN)', 'Echo Lake', 'Charleston', 'NE Kingdom', 550, 15186, 1249, 129, 58, 'NATURAL with ARTIFICIAL CONTROL', 'Echo Lake Charleston', 'Lake (Artificial Control)', 44.8603262, -71.994819, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ECHO (HUBDTN)', 'Echo Lake (Keeler Pond)', 'Hubbardton', 'West Central', 54, 544, 621, 42, 23, 'NATURAL', 'Echo Lake Hubbardton', 'Lake', 43.7458969, -73.1828902, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ECHO (PLYMTH)', 'Echo Lake', 'Plymouth', 'West Central', 104, 16816, 1061, 91, 30, 'NATURAL', 'Echo Lake Plymouth', 'Lake', 43.4734041, -72.6998192, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EDDY', 'Eddy Pond', 'Rutland City', 'West Central', 10, 1650, 590, NULL, NULL, NULL, 'Eddy Pond Rutland City', 'Pond', 43.5906241, -72.961217, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EDEN', 'Lake Eden', 'Eden', 'North Central', 194, 2347, 1239, 40, 15, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Eden Eden', 'Lake (Artificial Control)', 44.7225493, -72.5017778, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELBOW', 'Unnamed Pond referred to by DEC as Elbow', 'Mendon', 'West Central', 8, 162, 1870, NULL, NULL, NULL, 'Elbow Pond Mendon', 'Pond', 43.7, -72.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELFIN', 'Elfin Lake', 'Wallingford', 'West Central', 16, 228, 580, NULL, 12, NULL, 'Elfin Lake Wallingford', 'Lake', 43.4684038, -72.9884381, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELLIGO', 'Lake Elligo (Eligo Pond)', 'Greensboro', 'North Central', 174, 3238, 881, 100, 29, 'NATURAL', 'Lake Elligo Greensboro', 'Lake', 44.600052, -72.3551065, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELLIS', 'Unnamed Pond referred to by DEC as Ellis', 'Dover', 'Green Mtn South', NULL, NULL, 2175, NULL, NULL, NULL, 'Ellis Pond Dover', 'Pond', 42.98, -72.85, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELMORE', 'Lake Elmore', 'Elmore', 'North Central', 219, 5574, 1139, 17, 11, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Elmore Elmore', 'Lake (Artificial Control)', 44.5347752, -72.5253897, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELWIN MEADOW', 'Elwin Meadow', 'Newfane', 'Green Mtn South', NULL, NULL, 1370, NULL, NULL, NULL, 'Elwin Meadow Pond Newfane', 'Pond', 42.97, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ELY', 'Unnamed Pond referred to by DEC as Ely', 'Thetford', 'East Central', 5, 168, 870, NULL, NULL, NULL, 'Ely Pond Thetford', 'Pond', 43.88, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EMERALD', 'Emerald Lake', 'Dorset', 'Green Mtn South', 28, 3630, 711, 40, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Emerald Lake Dorset', 'Lake (Artificial Control)', 43.2753523, -73.0064924, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ENOSBURG', 'Unnamed Pond referred to by DEC as Enosbur', 'Enosburgh', 'Champlain ', NULL, NULL, 425, NULL, NULL, NULL, 'Enosburg Pond Enosburg', 'Pond', 44.9, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EQUINOX', 'Equinox Pond', 'Manchester', 'Green Mtn South', 15, 537, 1110, NULL, NULL, NULL, 'Equinox Pond Manchester', 'Pond', 43.1559098, -73.0898273, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EVANSVILLE', 'Unnamed Pond referred to by DEC as Evansville', 'Barton', 'NE Kingdom', NULL, NULL, 1190, NULL, NULL, NULL, 'Evansville Pond Barton', 'Pond', 44.8, -72.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('EWELL', 'Ewell Pond', 'Peacham', 'North Central', 51, 1981, 1284, 60, 20, 'NATURAL with ARTIFICIAL CONTROL', 'Ewell Pond Peacham', 'Lake (Artificial Control)', 44.37, -72.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIR HAVEN-W', 'Unnamed Pond referred to by DEC as Fair Haven - W', 'Fair Haven', 'West Central', 18, 175, 510, NULL, NULL, NULL, 'Fair Haven - W Pond Fair Haven', 'Pond', 43.62, -73.25, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD', 'Fairfield Pond', 'Fairfield', 'Champlain ', 446, 3758, 550, 42, 23, 'NATURAL with ARTIFICIAL CONTROL', 'Fairfield Pond Fairfield', 'Lake (Artificial Control)', 44.85, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD SWAMP', 'Fairfield Swamp Pond', 'Swanton', 'Champlain ', 152, 7424, 640, NULL, NULL, 'ARTIFICIAL', 'Fairfield Swamp Pond Swanton', 'Reservoir', 44.8, -73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD-NE', 'Unnamed Pond referred to by DEC as Fairfield - NE', 'Fairfield', 'Champlain ', 12, 320, 820, NULL, NULL, NULL, 'Fairfield - NE Pond Fairfield', 'Pond', 44.83, -72.85, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD-SE', 'Unnamed Pond referred to by DEC as Fairfield - SE', 'Fairfield', 'Champlain ', 18, 226, 855, NULL, NULL, NULL, 'Fairfield - SE Pond Fairfield', 'Pond', 44.77, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD-SW1', 'Unnamed Pond referred to by DEC as Fairfield - SW1', 'Fairfield', 'Champlain ', 7, 82, 800, NULL, NULL, NULL, 'Fairfield - SW1 Pond Fairfield', 'Pond', 44.77, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRFIELD-SW2', 'Unnamed Pond referred to by DEC as Fairfield - SW2', 'Fairfield', 'Champlain ', 7, 294, 820, NULL, NULL, NULL, 'Fairfield - SW2 Pond Fairfield', 'Pond', 44.77, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAIRLEE', 'Lake Fairlee', 'Thetford', 'East Central', 457, 12976, 678, 50, 23, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Fairlee Thetford', 'Lake (Artificial Control)', 43.88, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAN', 'Unnamed Pond referred to by DEC as Fan', 'Wells', 'West Central', 12, 280, 1410, NULL, NULL, NULL, 'Fan Pond Wells', 'Pond', 43.43, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FAY', 'Unnamed Pond referred to by DEC as Fay', 'Strafford', 'East Central', 10, 223, 1350, NULL, NULL, NULL, 'Fay Pond Strafford', 'Pond', 43.85, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FELCHNER', 'Unnamed Pond referred to by DEC as Felchner', 'Northfield', 'East Central', 12, 139, 1290, NULL, NULL, NULL, 'Felchner Pond Northfield', 'Pond', 44.13, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FERDINAND-E', 'Unnamed Pond referred to by DEC as Ferdinand - E', 'Ferdinand', 'NE Kingdom', NULL, NULL, 1150, NULL, NULL, NULL, 'Ferdinand - E Pond Ferdinand', 'Pond', 44.77, -71.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FERDINAND-NE', 'Unnamed Pond referred to by DEC as Ferdinand - NE', 'Ferdinand', 'NE Kingdom', NULL, NULL, 1150, NULL, NULL, NULL, 'Ferdinand - NE Pond Ferdinand', 'Pond', 44.75, -71.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FERN', 'Fern Lake', 'Leicester', 'West Central', 69, 505, 572, 43, 13, 'NATURAL', 'Fern Lake Leicester', 'Lake', 43.8656187, -73.0698352, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FIFIELD', 'Fifield Pond', 'Wallingford', 'West Central', 6, 717, 2110, NULL, NULL, NULL, 'Fifield Pond Wallingford', 'Pond', 43.4059052, -72.8876016, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FLAGG', 'Flagg Pond', 'Wheelock', 'North Central', 111, 2282, 1592, 6, 3, 'NATURAL', 'Flagg Pond Wheelock', 'Pond', 44.5653311, -72.2073241, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FLOOD', 'Unnamed Pond referred to by DEC as Flood', 'Peru', 'Green Mtn South', 1, NULL, 1525, NULL, NULL, NULL, 'Flood Pond Peru', 'Pond', 43.23, -72.88, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FOREST (AVERLL)', 'Forest Lake', 'Averill', 'NE Kingdom', 62, 1379, 1665, 13, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Forest Lake Averill', 'Lake (Artificial Control)', 44.9847686, -71.6814803, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FOREST (CALAIS)', 'Forest Lake (Nelson Pond)', 'Calais', 'North Central', 133, 2827, 1070, 97, 49, 'NATURAL', 'Forest Lake Calais', 'Lake', 44.4083895, -72.4412182, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FORESTER', 'Forester Pond', 'Jamaica', 'Green Mtn South', 16, 207, 1750, 5, NULL, 'NATURAL', 'Forester Pond Jamaica', 'Pond', 43.0817446, -72.8675989, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FORTIER', 'Fortier Pond', 'Orwell', 'West Central', 4, 30, 530, NULL, NULL, NULL, 'Fortier Pond Orwell', 'Pond', 43.7786734, -73.2431696, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FOSTERS', 'Fosters Pond', 'Peacham', 'North Central', 61, 647, 1526, 13, 8, 'NATURAL', 'Fosters Pond Peacham', 'Pond', 44.3297812, -72.20982, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FRENCH', 'Unnamed Pond referred to by DEC as French', 'Springfield', 'East Central', NULL, NULL, 610, NULL, NULL, NULL, 'French Pond Springfield', 'Pond', 43.3, -72.52, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('FRYING PAN', 'Unnamed Pond referred to by DEC as Frying Pan', 'Eden', 'North Central', NULL, NULL, 995, NULL, NULL, NULL, 'Frying Pan Pond Eden', 'Pond', 44.73, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GALE MEADOWS', 'Gale Meadows Pond', 'Londonderry', 'Green Mtn South', 195, 6573, 1358, 20, 8, 'ARTIFICIAL', 'Gale Meadows Pond Londonderry', 'Reservoir', 43.17, -72.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GALUSHA', 'Unnamed Pond referred to by DEC as Galusha', 'Topsham', 'North Central', 5, 152, 1650, NULL, NULL, NULL, 'Galusha Pond Topsham', 'Pond', 44.15, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GARFIELD', 'Unnamed Pond referred to by DEC as Garfield', 'Hyde Park', 'North Central', 9, 47, 1110, NULL, NULL, NULL, 'Garfield Pond Hyde Park', 'Pond', 44.6, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GATES', 'Gates Pond', 'Whitingham', 'Green Mtn South', 30, 1486, 1617, 7, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Gates Pond Whitingham', 'Lake (Artificial Control)', 42.818693, -72.8073181, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GATES-NE', 'Unnamed Pond referred to by DEC as Gates - NE', 'Marlboro', 'Green Mtn South', NULL, NULL, 1785, NULL, NULL, NULL, 'Gates - NE Pond Marlboro', 'Pond', 42.83, -72.8, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GEORGIA PLAINS', 'Unnamed Pond referred to by DEC as Georgia Plains', 'Georgia', 'Champlain ', 19, 3725, 210, NULL, NULL, NULL, 'Georgia Plains Pond Georgia', 'Pond', 44.72, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GILLETT', 'Gillett Pond', 'Richmond', 'Champlain ', 30, 1390, 710, 8, 5, 'NATURAL with ARTIFICIAL CONTROL', 'Gillett Pond Richmond', 'Lake (Artificial Control)', 44.3531098, -72.9642886, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GILMORE', 'Gilmore Pond', 'Bristol', 'Champlain ', 6, 318, 2010, NULL, NULL, NULL, 'Gilmore Pond Bristol', 'Pond', 44.088115, -73.0365059, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GLEN', 'Glen Lake', 'Castleton', 'West Central', 206, 2050, 478, 68, 32, 'NATURAL with ARTIFICIAL CONTROL', 'Glen Lake Castleton', 'Lake (Artificial Control)', 43.67, -73.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GLOVER', 'Unnamed Pond referred to by DEC as Glover', 'Glover', 'North Central', NULL, NULL, 1450, NULL, NULL, NULL, 'Glover Pond Glover', 'Pond', 44.7, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOODALL', 'Goodall Pond', 'Woodbury', 'North Central', 7, 141, 1250, NULL, NULL, NULL, 'Goodall Pond Woodbury', 'Pond', 44.4270002, -72.4381629, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOODSELL', 'Unnamed Pond referred to by DEC as Goodsell', 'Sheldon', 'Champlain ', 10, 86, 930, NULL, NULL, NULL, 'Goodsell Pond Sheldon', 'Pond', 44.87, -72.85, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOOSE', 'Goose Pond', 'Bolton', 'Champlain ', 2, 49, 2790, NULL, NULL, NULL, 'Goose Pond Bolton', 'Pond', 44.4108874, -72.8334541, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOSLANT ', 'Goslant Pond', 'Peacham', 'North Central', 5, 77, 1370, NULL, NULL, NULL, 'Goslant Pond Peacham', 'Pond', 44.3028371, -72.3042666, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOSLANTS MILL', 'Unnamed Pond referred to by DEC as Goslants Mill', 'Walden', 'North Central', 15, 7526, 1670, NULL, NULL, NULL, 'Goslants Mill Pond Walden', 'Pond', 44.47, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GOULDS', 'Unnamed Pond referred to by DEC as Goulds', 'Springfield', 'East Central', 6, 1651, 415, NULL, NULL, NULL, 'Goulds Pond Springfield', 'Pond', 43.28, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRAFT', 'Unnamed Pond referred to by DEC as Graft', 'Brighton', 'NE Kingdom', 12, 24736, 1150, NULL, NULL, NULL, 'Graft Pond Brighton', 'Pond', 44.82, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRAHAMVILLE', 'Unnamed Pond referred to by DEC as Grahamville', 'Ludlow', 'Green Mtn South', 8, 43, 1030, NULL, NULL, NULL, 'Grahamville Pond Ludlow', 'Pond', 43.42, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRASS', 'Grass Pond', 'Plymouth', 'West Central', 3, 169, 1570, NULL, NULL, NULL, 'Grass Pond Plymouth', 'Pond', 43.547014, -72.7370436, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRAYS', 'Grays Pond', 'Lyndon', 'NE Kingdom', 1, 72, 670, NULL, NULL, NULL, 'Grays Pond Lyndon', 'Pond', 44.4961676, -71.9900953, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GREAT AVERILL', 'Great Averill Pond', 'Norton', 'NE Kingdom', 828, 7638, 1684, 108, 42, 'NATURAL with ARTIFICIAL CONTROL', 'Great Averill Pond Norton', 'Lake (Artificial Control)', 44.98, -71.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GREAT HOSMER', 'Great Hosmer Pond', 'Craftsbury', 'North Central', 140, 860, 1117, 57, 20, 'NATURAL with ARTIFICIAL CONTROL', 'Great Hosmer Pond Craftsbury', 'Lake (Artificial Control)', 44.6947722, -72.3606624, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GREEN RIVER', 'Green River Reservoir', 'Hyde Park', 'North Central', 554, 9075, 1220, 93, NULL, 'ARTIFICIAL', 'Green River Reservoir Hyde Park', 'Reservoir', 44.629268, -72.515443, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GREENWOOD', 'Lake Greenwood', 'Woodbury', 'North Central', 96, 1138, 1188, 41, 15, 'NATURAL', 'Lake Greenwood Woodbury', 'Lake', 44.4586661, -72.4253853, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRIFFITH', 'Griffith Lake', 'Peru', 'Green Mtn South', 13, 104, 2618, NULL, NULL, 'NATURAL', 'Griffith Lake Peru', 'Lake', 43.3028517, -72.9592692, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GRIGGS', 'Griggs Pond', 'Albany', 'North Central', 6, 160, 850, NULL, NULL, NULL, 'Griggs Pond Albany', 'Pond', 44.77, -72.33, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GROTON', 'Lake Groton', 'Groton', 'North Central', 422, 12006, 1078, 35, 13, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Groton Groton', 'Lake (Artificial Control)', 44.2667271, -72.2662089, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GROUT', 'Grout Pond', 'Stratton', 'Green Mtn South', 84, 411, 2225, 33, NULL, 'NATURAL', 'Grout Pond Stratton', 'Pond', 43.0445226, -72.9456567, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GROUT-N', 'Unnamed Pond referred to by DEC as Grout - N', 'Stratton', 'Green Mtn South', NULL, NULL, 2275, NULL, NULL, NULL, 'Grout - N Pond Stratton', 'Pond', 43.05, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GUILFORD-E', 'Unnamed Pond referred to by DEC as Guilford - E', 'Guilford', 'Green Mtn South', 5, 41, 600, NULL, NULL, NULL, 'Guilford - E Pond Guilford', 'Pond', 42.77, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GUILLMETTES', 'Guillmettes Pond', 'Richford', 'Champlain ', 12, 510, 750, NULL, NULL, NULL, 'Guillmettes Pond Richford', 'Pond', 44.9600459, -72.6712408, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('GUT', 'Gut Pond', 'Eden', 'North Central', 13, 154, 1280, NULL, NULL, NULL, 'Gut Pond Eden', 'Pond', 44.6931055, -72.5212233, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALF MOON', 'Halfmoon Pond', 'Hubbardton', 'West Central', 23, 322, 582, 8, 2, 'NATURAL', 'Halfmoon Pond Hubbardton', 'Lake', 43.6928423, -73.2184453, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALFMOON', 'Halfmoon Pond', 'Fletcher', 'Champlain ', 21, 194, 919, 25, NULL, 'NATURAL', 'Halfmoon Pond Fletcher', 'Pond', 44.6972716, -72.9298583, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALFMOON COVE', 'Halfmoon Cove', 'Colchester', 'Champlain ', 14, 133, 95, NULL, NULL, NULL, 'Halfmoon Cove Pond Colchester', 'Pond', 44.53, -73.25, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALFWAY', 'Halfway Pond', 'Norton', 'NE Kingdom', 22, 220, 1690, 4, NULL, 'NATURAL', 'Halfway Pond Norton', 'Pond', 44.9800466, -71.8984291, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALLADAY', 'Unnamed Pond referred to by DEC as Halladay', 'Marlboro', 'Green Mtn South', NULL, NULL, 1417, NULL, NULL, NULL, 'Halladay Pond Marlboro', 'Pond', 42.9, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALLOCK', 'Unnamed Pond referred to by DEC as Hallock', 'Starksboro', 'Champlain ', 15, 207, 1494, NULL, NULL, NULL, 'Hallock Pond Starksboro', 'Pond', 44.18, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HALLS', 'Halls Lake', 'Newbury', 'East Central', 85, 561, 779, 30, 17, 'NATURAL with ARTIFICIAL CONTROL', 'Halls Lake Newbury', 'Lake (Artificial Control)', 44.085898, -72.1231473, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HANCOCK (BRIGTN)', 'Hancock Pond', 'Brighton', 'NE Kingdom', 7, 154, 1510, NULL, NULL, NULL, 'Hancock Pond Brighton', 'Pond', 44.7569943, -71.8992618, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HANCOCK (STAMFD)', 'Lake Hancock (Sucker Pond)', 'Stamford', 'Green Mtn South', 51, 259, 2267, 12, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Hancock Stamford', 'Lake (Artificial Control)', 42.82508, -73.1287164, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HANCOCK MT', 'Unnamed Pond referred to by DEC as Hancock Mt', 'Rochester', 'East Central', 14, 319, 1406, NULL, NULL, NULL, 'Hancock Mt Pond Rochester', 'Pond', 43.93, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HAPGOOD', 'Hapgood Pond', 'Peru', 'Green Mtn South', 7, 1568, 1530, NULL, NULL, NULL, 'Hapgood Pond Peru', 'Pond', 43.2539638, -72.8906558, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARDWICK', 'Hardwick Lake', 'Hardwick', 'North Central', 145, 6876, 797, NULL, NULL, 'ARTIFICIAL', 'Hardwick Lake Hardwick', 'Reservoir', 44.52, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARDWOOD', 'Hardwood Pond', 'Elmore', 'North Central', 49, 185, 1569, 15, NULL, 'NATURAL', 'Hardwood Pond Elmore', 'Pond', 44.4678324, -72.4995546, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARRIMAN (NEWBRY)', 'Harriman Pond', 'Newbury', 'East Central', 20, 1438, 838, 35, NULL, 'NATURAL', 'Harriman Pond Newbury', 'Pond', 44.10312, -72.0800911, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARRIMAN (WHITHM)', 'Harriman Reservoir', 'Whitingham', 'Green Mtn South', 2040, 116840, 1490, 160, 34, 'ARTIFICIAL', 'Harriman Reservoir Whitingham', 'Reservoir', 42.83, -72.88, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARTWELL', 'Hartwell Pond', 'Albany', 'North Central', 16, 623, 1609, 57, 21, 'NATURAL', 'Hartwell Pond Albany', 'Pond', 44.7044943, -72.293716, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HARVEYS', 'Harveys Lake', 'Barnet', 'North Central', 351, 5364, 893, 145, 66, 'NATURAL with ARTIFICIAL CONTROL', 'Harveys Lake Barnet', 'Lake (Artificial Control)', 44.3, -72.13, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HAWKINS', 'Hawkins Pond', 'Calais', 'North Central', 9, 190, 1410, NULL, NULL, NULL, 'Hawkins Pond Calais', 'Pond', 44.4033895, -72.5012201, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HAYSTACK', 'Haystack Pond', 'Wilmington', 'Green Mtn South', 27, 132, 2984, NULL, NULL, 'NATURAL', 'Haystack Pond Wilmington', 'Pond', 42.9170246, -72.9170441, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HEART', 'Heart Pond', 'Albany', 'North Central', 6, 90, 1170, NULL, NULL, NULL, 'Heart Pond Albany', 'Pond', 44.6997721, -72.3642736, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HEARTWELLVILLE', 'Unnamed Pond referred to by DEC as Heartwellville', 'Readsboro', 'Green Mtn South', NULL, NULL, 1760, NULL, NULL, NULL, 'Heartwellville Pond Readsboro', 'Pond', 42.83, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HEDGEHOG GULF', 'Unnamed Pond referred to by DEC as Hedgehog Gulf', 'Athens', 'Green Mtn South', NULL, NULL, 935, NULL, NULL, NULL, 'Hedgehog Gulf Pond Athens', 'Pond', 43.08, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HICKORY', 'Unnamed Pond referred to by DEC as Hickory', 'Westminster', 'Green Mtn South', 16, 84, 932, NULL, NULL, NULL, 'Hickory Pond Westminster', 'Pond', 43.03, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HIDDEN', 'Hidden Lake', 'Marlboro', 'Green Mtn South', 17, 723, 1470, 6, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Hidden Lake Marlboro', 'Lake (Artificial Control)', 42.88, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HIGH (HUBDTN)', 'High Pond', 'Hubbardton', 'West Central', 3, 20, 770, NULL, NULL, NULL, 'High Pond Hubbardton', 'Pond', 43.7003422, -73.2117786, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HIGH (SUDBRY)', 'High Pond', 'Sudbury', 'West Central', 20, 173, 1033, 56, 26, 'NATURAL', 'High Pond Sudbury', 'Pond', 43.7528416, -73.1531676, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HINKUM', 'Hinkum Pond', 'Sudbury', 'West Central', 60, 353, 719, 69, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Hinkum Pond Sudbury', 'Lake (Artificial Control)', 43.7647857, -73.1678903, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOLBROOK', 'Unnamed Pond referred to by DEC as Holbrook', 'West Windsor', 'East Central', NULL, NULL, 1080, NULL, NULL, NULL, 'Holbrook Pond West Windsor', 'Pond', 43.52, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOLDENS', 'Holdens Pond', 'Brookfield', 'East Central', 10, 324, 1194, NULL, NULL, NULL, 'Holdens Pond Brookfield', 'Pond', 44.03, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOLLAND', 'Holland Pond', 'Holland', 'NE Kingdom', 325, 4431, 1430, 39, 17, 'NATURAL with ARTIFICIAL CONTROL', 'Holland Pond Holland', 'Lake (Artificial Control)', 44.9867132, -71.9281516, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOMER STONE', 'Unnamed Pond referred to by DEC as Homer Stone', 'Wallingford', 'West Central', NULL, NULL, 2135, NULL, NULL, NULL, 'Homer Stone Pond Wallingford', 'Pond', 43.42, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOPKINS', 'Unnamed Pond referred to by DEC as Hopkins', 'Charleston', 'NE Kingdom', NULL, NULL, 1150, NULL, NULL, NULL, 'Hopkins Pond Charleston', 'Pond', 44.82, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOPKINSON', 'Unnamed Pond referred to by DEC as Hopkinson', 'Derby', 'NE Kingdom', NULL, NULL, 855, NULL, NULL, NULL, 'Hopkinson Pond Derby', 'Pond', 44.92, -72.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOPPER', 'Hopper Pond', 'Sandgate', 'Green Mtn South', 1, 733, 1970, NULL, NULL, NULL, 'Hopper Pond Sandgate', 'Pond', 43.1506322, -73.1512175, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HORN OF THE MOON', 'Horn of the Moon Pond', 'East Montpelier', 'North Central', 10, 139, 1230, NULL, NULL, NULL, 'Horn of the Moon Pond East Montpelier', 'Pond', 44.32, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HORSE', 'Horse Pond', 'Greensboro', 'North Central', 32, 531, 1343, 4, NULL, 'NATURAL', 'Horse Pond Greensboro', 'Pond', 44.6175521, -72.2106577, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HORTON', 'unnamed pond referred to by DEC as Horton', 'Benson', 'West Central', 15, NULL, 500, NULL, NULL, NULL, 'Horton Pond Benson', 'Pond', 43.71491, -73.34589, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HORTONIA', 'Lake Hortonia', 'Hubbardton', 'West Central', 479, 4457, 484, 60, 19, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Hortonia Hubbardton', 'Lake (Artificial Control)', 43.7500632, -73.2078906, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOUGH', 'Hough Pond (Huff Pond)', 'Sudbury', 'West Central', 16, 344, 777, 30, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Hough Pond Sudbury', 'Lake (Artificial Control)', 43.78, -73.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOVEY', 'Unnamed Pond referred to by DEC as Hovey', 'Hardwick', 'North Central', 6, 198, 1290, NULL, NULL, NULL, 'Hovey Pond Hardwick', 'Pond', 44.53, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HOWE', 'Howe Pond', 'Readsboro', 'Green Mtn South', 52, 1647, 1926, 33, 10, 'NATURAL', 'Howe Pond Readsboro', 'Pond', 42.7842485, -72.9859342, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HUTCHINSON', 'Unnamed Pond referred to by DEC as Hutchinson', 'Braintree', 'East Central', NULL, NULL, 910, NULL, NULL, NULL, 'Hutchinson Pond Braintree', 'Pond', 43.98, -72.67, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('INDIAN BROOK', 'Unnamed Pond referred to by DEC as Indian Brook', 'Colchester', 'Champlain ', 16, 6078, 170, NULL, NULL, NULL, 'Indian Brook Pond Colchester', 'Reservoir', 44.53, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('INDIAN BROOK (ESSEX)', 'Indian Brook Reservoir', 'Essex', 'Champlain ', 50, 761, 520, 22, 13, 'ARTIFICIAL', 'Indian Brook Reservoir Essex', 'Reservoir', 44.53, -73.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('INMAN', 'Inman Pond', 'Fair Haven', 'West Central', 85, 240, 592, 80, 34, 'NATURAL with ARTIFICIAL CONTROL', 'Inman Pond Fair Haven', 'Lake (Artificial Control)', 43.65, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('IRASBURG', 'Unnamed Pond referred to by DEC as Irasburg', 'Irasburg', 'NE Kingdom', NULL, NULL, 955, NULL, NULL, NULL, 'Irasburg Pond Irasburg', 'Pond', 44.83, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('IROQUOIS', 'Lake Iroquois', 'Hinesburg', 'Champlain ', 243, 2418, 684, 37, 19, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Iroquois Hinesburg', 'Lake (Artificial Control)', 44.37, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ISLAND', 'Island Pond', 'Brighton', 'NE Kingdom', 626, 6295, 1172, 63, 31, 'NATURAL', 'Island Pond Brighton', 'Pond', 44.8050491, -71.8706504, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JACKSONVILLE', 'Jacksonville Pond', 'Whitingham', 'Green Mtn South', 20, 3349, 1450, 8, NULL, 'ARTIFICIAL', 'Jacksonville Pond Whitingham', 'Reservoir', 42.8, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JAY', 'Unnamed Pond referred to by DEC as Jay', 'Jay', 'NE Kingdom', NULL, NULL, 1720, NULL, NULL, NULL, 'Jay Pond Jay', 'Pond', 44.98, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (BENSON)', 'Mud Pond', 'Benson', 'West Central', 8, 129, 492, NULL, NULL, NULL, 'Mud Pond Benson', 'Pond', 43.7445068, -73.3295597, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JEROME', 'Unnamed Pond referred to by DEC as Jerome', 'Addison', 'Champlain ', 18, 320, 108, NULL, NULL, 'ARTIFICIAL', 'Jerome Pond Addison', 'Reservoir', 44.08, -73.33, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JEWELL BK #1', 'Unnamed Pond referred to by DEC as Jewell Bk #1', 'Ludlow', 'West Central', 14, 1143, 1650, NULL, NULL, NULL, 'Jewell Bk #1 Pond Ludlow', 'Reservoir', 43.37, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JEWELL BK #2', 'Unnamed Pond referred to by DEC as Jewell Bk #2', 'Ludlow', 'West Central', 17, 1323, 1550, NULL, NULL, NULL, 'Jewell Bk #2 Pond Ludlow', 'Reservoir', 43.37, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JEWELL BK #3', 'Unnamed Pond referred to by DEC as Jewell Bk #3', 'Ludlow', 'West Central', 18, 803, 1250, NULL, NULL, NULL, 'Jewell Bk #3 Pond Ludlow', 'Reservoir', 43.38, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOBS', 'Jobs Pond', 'Westmore', 'NE Kingdom', 39, 268, 1950, 18, 7, 'NATURAL with ARTIFICIAL CONTROL', 'Jobs Pond Westmore', 'Lake (Artificial Control)', 44.7628276, -71.9537072, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOES (DANVLL)', 'Joes Pond', 'Danville', 'North Central', 396, 18445, 1551, 78, 21, 'NATURAL with ARTIFICIAL CONTROL', 'Joes Pond Danville', 'Lake (Artificial Control)', 44.4083904, -72.1945436, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOES (MRSTWN)', 'Joes Pond', 'Morristown', 'North Central', 9, 787, 732, NULL, NULL, NULL, 'Joes Pond Morristown', 'Pond', 44.5058865, -72.6201157, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOHNSON (KIRBY)', 'Johnson Pond', 'Kirby', 'NE Kingdom', 7, 691, 1105, NULL, NULL, NULL, 'Johnson Pond Kirby', 'Pond', 44.4906125, -71.867037, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOHNSON (ORWELL)', 'Johnson Pond', 'Orwell', 'West Central', 20, 140, 443, 18, NULL, 'NATURAL', 'Johnson Pond Orwell', 'Pond', 43.7667294, -73.2237247, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOHNSON (SHRWBY)', 'Johnson Pond', 'Shrewsbury', 'West Central', 12, 210, 1745, NULL, NULL, NULL, 'Johnson Pond Shrewsbury', 'Pond', 43.5181254, -72.8453793, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOHNSONS MILL', 'Unnamed Pond referred to by DEC as Johnsons Mill', 'Bakersfield', 'Champlain ', 5, 5098, 620, NULL, NULL, NULL, 'Johnsons Mill Pond Bakersfield', 'Pond', 44.83, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JONES', 'Jones Pond', 'Chelsea', 'East Central', 2, 54, 1330, NULL, NULL, NULL, 'Jones Pond Chelsea', 'Pond', 44.0428423, -72.4953795, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JONES MILL', 'Jones Mill Pond', 'Brandon', 'West Central', 6, 3367, 430, NULL, NULL, NULL, 'Jones Mill Pond Brandon', 'Pond', 43.7831201, -73.0617778, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('JOSLIN TURN', 'Unnamed Pond referred to by DEC as Joslin Turn', 'Concord', 'NE Kingdom', 10, 165, 824, NULL, NULL, NULL, 'Joslin Turn Pond Concord', 'Pond', 44.37, -71.83, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KEELER', 'Keeler Pond', 'Wolcott', 'North Central', 5, 544, 1390, NULL, NULL, NULL, 'Keeler Pond Wolcott', 'Pond', 44.5747747, -72.3992744, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KEISER', 'Keiser Pond', 'Danville', 'North Central', 33, 1611, 1290, 20, 6, 'NATURAL with ARTIFICIAL CONTROL', 'Keiser Pond Danville', 'Lake (Artificial Control)', 44.3864467, -72.1706537, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KENNY', 'Kenny Pond', 'Newfane', 'Green Mtn South', 26, 239, 1250, 11, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Kenny Pond Newfane', 'Lake (Artificial Control)', 42.98, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KENT', 'Kent Pond', 'Killington', 'West Central', 99, 2376, 1525, 15, 6, 'ARTIFICIAL', 'Kent Pond Killington', 'Reservoir', 43.68, -72.8, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KENT HOLLOW', 'Unnamed Pond referred to by DEC as Kent Hollow', 'Sandgate', 'Green Mtn South', 10, 579, 1470, NULL, NULL, NULL, 'Kent Hollow Pond Sandgate', 'Pond', 43.2, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KETTLE', 'Kettle Pond', 'Groton', 'North Central', 109, 834, 1443, 16, 6, 'NATURAL', 'Kettle Pond Groton', 'Pond', 44.2947817, -72.3181558, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KEYSER', 'Unnamed Pond referred to by DEC as Keyser', 'Chelsea', 'East Central', 7, 532, 1170, NULL, NULL, NULL, 'Keyser Pond Chelsea', 'Pond', 43.95, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KIDDER (IRABRG)', 'Kidder Pond', 'Irasburg', 'NE Kingdom', 16, 216, 1170, NULL, NULL, NULL, 'Kidder Pond Irasburg', 'Pond', 44.87, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KIDDER (STRTON)', 'Unnamed Pond referred to by DEC as Kidder', 'Stratton', 'Green Mtn South', NULL, NULL, 1750, NULL, NULL, NULL, 'Kidder Pond Stratton', 'Pond', 43.05, -72.88, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KINGS', 'Kings Pond', 'Rochester', 'East Central', 4, 17, 1010, NULL, NULL, NULL, 'Kings Pond Rochester', 'Pond', 43.8606204, -72.8726085, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KINGS HILL', 'Kings Hill Pond', 'Bakersfield', 'Champlain ', 6, 145, 1090, NULL, NULL, NULL, 'Kings Hill Pond Bakersfield', 'Pond', 44.7369933, -72.784017, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KINGSTON', 'Unnamed Pond referred to by DEC as Kingston', 'Jamaica', 'Green Mtn South', NULL, NULL, 1390, NULL, NULL, NULL, 'Kingston Pond Jamaica', 'Pond', 43.08, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KIPLING', 'Unnamed Pond referred to by DEC as Kipling', 'Brattleboro', 'Green Mtn South', NULL, NULL, 660, NULL, NULL, NULL, 'Kipling Pond Brattleboro', 'Pond', 42.9, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KIRBY', 'Kirby Pond', 'Kirby', 'NE Kingdom', 10, 326, 1610, NULL, NULL, NULL, 'Kirby Pond Kirby', 'Pond', 44.509223, -71.9156493, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KIRBY-W', 'Unnamed Pond referred to by DEC as Kerby - W', 'Kirby', 'NE Kingdom', NULL, NULL, 1650, NULL, NULL, NULL, 'Kerby - W Pond Kirby', 'Pond', 44.5, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KNAPP BROOK #1', 'Knapp Brook #1', 'Cavendish', 'East Central', 25, 2074, 1270, 12, 6, 'ARTIFICIAL', 'Knapp Brook #1 Pond Cavendish', 'Reservoir', 43.447016, -72.5662041, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KNAPP BROOK #2', 'Knapp Brook #2', 'Cavendish', 'East Central', 35, 1869, 1290, 20, 9, 'ARTIFICIAL', 'Knapp Brook #2 Pond Cavendish', 'Reservoir', 43.45, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KNOB', 'Unnamed Pond referred to by DEC as Knob', 'Eden', 'North Central', NULL, NULL, 1170, NULL, NULL, NULL, 'Knob Pond Eden', 'Pond', 44.73, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('KNOB HILL', 'Knob Hill Pond', 'Marshfield', 'North Central', 16, 137, 1210, NULL, NULL, NULL, 'Knob Hill Pond Marshfield', 'Pond', 44.3603354, -72.3737148, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAIRD', 'Laird Pond', 'Marshfield', 'North Central', 12, 2637, 1126, NULL, NULL, NULL, 'Laird Pond Marshfield', 'Pond', 44.3, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAKE-OF-THE-CLOUDS', 'Lake-Of-The-Clouds', 'Cambridge', 'Champlain ', 1, 1, 3930, NULL, NULL, 'NATURAL', 'Lake-Of-The-CloudsÂ Cambridge', 'Lake', 44.5483849, -72.8106793, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAKOTA', 'Lakota Lake', 'Barnard', 'West Central', 20, 385, 1899, 11, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Lakota Lake Barnard', 'Lake (Artificial Control)', 43.68, -72.65, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAMOILLE', 'Lake Lamoille', 'Morristown', 'North Central', 148, 170146, 540, 15, 5, 'ARTIFICIAL', 'Lake Lamoille Morristown', 'Reservoir', 44.57, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAMSON', 'Lamson Pond', 'Brookfield', 'East Central', 24, 230, 1590, NULL, NULL, 'NATURAL', 'Lamson Pond Brookfield', 'Pond', 44.0633967, -72.612606, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LANDFILL', 'Unnamed Pond referred to by DEC as Landfill', 'Eden', 'North Central', 7, 34, 1250, NULL, NULL, NULL, 'Landfill Pond Eden', 'Pond', 44.7, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LANDGROVE', 'Unnamed Pond referred to by DEC as Landgrove', 'Landgrove', 'Green Mtn South', 14, NULL, 1745, NULL, NULL, NULL, 'Landgrove Pond Landgrove', 'Pond', 43.28, -72.83, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LANPHER MEADOW', 'Lanpher Meadow', 'Eden', 'North Central', 6, 423, 1310, NULL, NULL, NULL, 'Lanpher Meadow Pond Eden', 'Pond', 44.72, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LAUREL', 'Laurel Lake', 'Whitingham', 'Green Mtn South', 16, 76, 1630, 17, NULL, 'NATURAL', 'Laurel Lake Whitingham', 'Lake', 42.8195263, -72.8181517, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEECH', 'Leech Pond', 'Woodbury', 'North Central', 4, 134, 1050, NULL, NULL, NULL, 'Leech Pond Woodbury', 'Pond', 44.421167, -72.4306625, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEFFERTS', 'Lefferts Pond', 'Chittenden', 'West Central', 55, 3814, 1501, 8, NULL, 'ARTIFICIAL', 'Lefferts Pond Chittenden', 'Reservoir', 43.7156223, -72.901773, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEIGHTON HILL', 'Unnamed Pond referred to by DEC as Leighton Hill', 'Newbury', 'East Central', 6, 213, 890, NULL, NULL, NULL, 'Leighton Hill Pond Newbury', 'Pond', 44.13, -72.12, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEVI', 'Levi Pond', 'Groton', 'North Central', 22, 152, 1632, 23, 8, 'NATURAL', 'Levi Pond Groton', 'Pond', 44.2672827, -72.2262078, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEWIN', 'Lewin Pond', 'Norwich', 'East Central', 4, 24, 490, NULL, NULL, NULL, 'Lewin Pond Norwich', 'Pond', 43.7720148, -72.2164784, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LEWIS', 'Lewis Pond', 'Lewis', 'NE Kingdom', 68, 1254, 1830, 8, 4, 'NATURAL', 'Lewis Pond Lewis', 'Pond', 44.8833812, -71.7806495, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LIGHT TROUT CLUB', 'Light Trout Club Lake', 'Moretown', 'North Central', 7, 2173, 690, NULL, NULL, NULL, 'Light Trout Club Lake Moretown', 'Pond', 44.28, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (ATHENS)', 'Lily Pond', 'Athens', 'Green Mtn South', 12, 159, 1430, NULL, NULL, NULL, 'Lily Pond Athens', 'Pond', 43.08, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (CASLTN)', 'Lily Pond', 'Castleton', 'West Central', 9, 70, 568, NULL, NULL, NULL, 'Lily Pond Castleton', 'Pond', 43.6764538, -73.2140004, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (LONDRY)', 'Lily Pond', 'Londonderry', 'Green Mtn South', 21, 297, 1490, 8, NULL, 'NATURAL', 'Lily Pond Londonderry', 'Pond', 43.2345197, -72.7506517, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (LYNDON)', 'Lily Pond', 'Lyndon', 'NE Kingdom', 8, 26, 810, NULL, NULL, NULL, 'Lily Pond Lyndon', 'Pond', 44.5231114, -71.9914843, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (NORWCH)', 'Lily Pond', 'Norwich', 'East Central', 6, 57, 470, NULL, NULL, NULL, 'Lily Pond Norwich', 'Pond', 43.7425706, -72.2556457, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (POULTY)', 'Lily Pond', 'Poultney', 'West Central', 22, 1288, 484, 7, 4, 'NATURAL', 'Lily Pond Poultney', 'Pond', 43.4950694, -73.2073303, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (THETFD)', 'Unnamed Pond referred to by DEC as Lily', 'Thetford', 'East Central', 19, 283, 852, NULL, NULL, NULL, 'Lily Pond Thetford', 'Pond', 43.82, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY (VERNON)', 'Lily Pond', 'Vernon', 'Green Mtn South', 41, 463, 371, 13, NULL, 'NATURAL', 'Lily Pond Vernon', 'Pond', 42.7370275, -72.5089777, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LILY PAD', 'Lily Pad Pond', 'Colchester', 'Champlain ', 2, 76, 310, NULL, NULL, NULL, 'Lily Pad Pond Colchester', 'Pond', 44.5078268, -73.1617945, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LIMEHURST', 'Limehurst Pond', 'Williamstown', 'East Central', 13, 597, 901, NULL, NULL, 'NATURAL', 'Limehurst Pond Williamstown', 'Pond', 44.1017296, -72.5495492, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LINE (BARNRD)', 'Line Pond', 'Barnard', 'West Central', 10, 110, 1350, NULL, NULL, NULL, 'Line Pond Barnard', 'Pond', 43.7175684, -72.5675971, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LINE (HOLLND)', 'Line Pond', 'Holland', 'NE Kingdom', 5, 115, 1610, NULL, NULL, NULL, 'Line Pond Holland', 'Pond', 45.0072684, -71.9148182, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (CALAIS)', 'Little Pond', 'Calais', 'North Central', 7, 230, 1190, NULL, NULL, NULL, 'Little Pond Calais', 'Pond', 44.3861679, -72.438162, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (ELMORE)', 'Little Pond', 'Elmore', 'North Central', 14, 102, 1410, NULL, NULL, NULL, 'Little Pond Elmore', 'Pond', 44.4592215, -72.4970544, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (FRANLN)', 'Little Pond', 'Franklin', 'Champlain ', 95, 591, 673, 8, NULL, 'NATURAL', 'Little Pond Franklin', 'Pond', 44.9569897, -72.8284682, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (WELLS)', 'Little Pond', 'Wells', 'West Central', 162, 8989, 484, 5, 4, 'NATURAL with ARTIFICIAL CONTROL', 'Little Pond Wells', 'Lake (Artificial Control)', 43.4322933, -73.2028855, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (WINHLL)', 'Little Pond', 'Winhall', 'Green Mtn South', 18, 133, 2390, NULL, NULL, 'NATURAL', 'Little Pond Winhall', 'Pond', 43.1231326, -72.9434346, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE (WOODFD)', 'Little Pond', 'Woodford', 'Green Mtn South', 16, 323, 2602, 8, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Little Pond Woodford', 'Lake (Artificial Control)', 42.9250793, -73.0645484, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE AVERILL', 'Little Averill Pond', 'Averill', 'NE Kingdom', 467, 2854, 1740, 115, 52, 'NATURAL with ARTIFICIAL CONTROL', 'Little Averill Pond Averill', 'Lake (Artificial Control)', 44.9556024, -71.7162039, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE ELIGO', 'Little Eligo Pond', 'Hardwick', 'North Central', 15, 653, 870, NULL, NULL, NULL, 'Little Eligo Pond Hardwick', 'Pond', 44.5783858, -72.36344, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE ELMORE', 'Little Elmore Pond', 'Elmore', 'North Central', 24, 316, 1223, 15, NULL, 'NATURAL', 'Little Elmore Pond Elmore', 'Pond', 44.4978315, -72.5317787, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE HOSMER', 'Little Hosmer Pond', 'Craftsbury', 'North Central', 180, 1792, 1066, 9, 4, 'NATURAL with ARTIFICIAL CONTROL', 'Little Hosmer Pond Craftsbury', 'Lake (Artificial Control)', 44.68, -72.38, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE MUD (GRANBY)', 'Little Mud Pond', 'Granby', 'NE Kingdom', 2, 3, 2130, NULL, NULL, NULL, 'Little Mud Pond Granby', 'Pond', 44.5614442, -71.6956446, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE MUD (MTTABR)', 'Little Mud Pond', 'Mount Tabor', 'West Central', 7, 330, 2579, NULL, NULL, NULL, 'Little Mud Pond Mount Tabor', 'Pond', 43.3159069, -72.9376021, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE MUD (WINHLL)', 'Little Mud Pond', 'Winhall', 'Green Mtn South', 21, 83, 2270, NULL, NULL, NULL, 'Little Mud Pond Winhall', 'Pond', 43.1347989, -72.9831581, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE MUD (WOODBY)', 'Little Mud Pond', 'Woodbury', 'North Central', 10, 160, 1390, NULL, NULL, NULL, 'Little Mud Pond Woodbury', 'Pond', 44.38, -72.38, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE ROCK', 'Little Rock Pond', 'Wallingford', 'West Central', 18, 196, 1854, NULL, NULL, 'NATURAL', 'Little Rock Pond Wallingford', 'Pond', 43.4006275, -72.9562145, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE WHEELER', 'Little Wheeler Pond', 'Brunswick', 'NE Kingdom', 9, 4224, 990, 6, NULL, NULL, 'Little Wheeler Pond Brunswick', 'Pond', 44.7161616, -71.6331443, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (EDEN)', 'Long Pond (Belvidere Pond)', 'Eden', 'North Central', 97, 723, 1137, 6, 3, 'NATURAL', 'Long Pond Eden', 'Pond', 44.77, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (GRNSBO)', 'Long Pond', 'Greensboro', 'North Central', 100, 1910, 1590, 33, 15, 'NATURAL', 'Long Pond Greensboro', 'Pond', 44.6256073, -72.263437, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (MILTON)', 'Long Pond', 'Milton', 'Champlain ', 47, 431, 315, 36, NULL, 'NATURAL', 'Long Pond Milton', 'Pond', 44.6733793, -73.191521, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (NEWBRY)', 'Long Pond', 'Newbury', 'East Central', 15, 242, 1390, NULL, NULL, NULL, 'Long Pond Newbury', 'Pond', 44.1047865, -72.166482, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (SHEFLD)', 'Long Pond', 'Sheffield', 'North Central', 38, 204, 1682, 30, NULL, 'NATURAL', 'Long Pond Sheffield', 'Pond', 44.6767178, -72.1437116, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG (WESTMR)', 'Long Pond', 'Westmore', 'NE Kingdom', 90, 732, 1835, 74, 29, 'NATURAL', 'Long Pond Westmore', 'Pond', 44.7506056, -72.0178751, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG HOLE', 'Long Hole', 'Mount Tabor', 'West Central', 1, 2054, 2540, NULL, NULL, 'NATURAL', 'Long Hole Pond Mount Tabor', 'Pond', 43.3, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LONG MEADOW', 'Unnamed Pond referred to by DEC as Long Meadow', 'Calais', 'North Central', 7, 176, 1530, NULL, NULL, NULL, 'Long Meadow Pond Calais', 'Pond', 44.35, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOST (BELVDR)', 'Lost Pond', 'Belvidere', 'Champlain ', 3, 49, 2350, NULL, NULL, NULL, 'Lost Pond Belvidere', 'Pond', 44.7906038, -72.6476214, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOST (GEORGA)', 'Lost Lake', 'Georgia', 'Champlain ', 10, 121, 530, NULL, NULL, NULL, 'Lost Lake Georgia', 'Lake', 44.7683798, -73.0926385, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOST (GLASBY)', 'Lost Pond', 'Glastenbury', 'Green Mtn South', 1, 65, 2950, NULL, NULL, NULL, 'Lost Pond Glastenbury', 'Pond', 42.9445236, -73.052326, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOST (MTTABR)', 'Lost Pond', 'Mount Tabor', 'West Central', NULL, NULL, 2706, NULL, NULL, NULL, 'Lost Pond Mount Tabor', 'Pond', 43.3406287, -72.9417691, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOST (SUNDLD)', 'Lost Pond', 'Sunderland', 'Green Mtn South', 2, 299, 2630, NULL, NULL, NULL, 'Lost Pond Sunderland', 'Pond', 43.040078, -73.0270479, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOVES MARSH', 'Loves Marsh', 'Castleton', 'West Central', 62, 1159, 414, NULL, NULL, 'ARTIFICIAL', 'Loves Marsh Pond Castleton', 'Reservoir', 43.67, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWELL', 'Lowell Lake', 'Londonderry', 'Green Mtn South', 109, 1313, 1330, 22, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Lowell Lake Londonderry', 'Lake (Artificial Control)', 43.22, -72.77, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER', 'Lower Pond (Lake Sunset)', 'Hinesburg', 'Champlain ', 58, 3461, 661, 10, 5, 'ARTIFICIAL', 'Lower Pond Hinesburg', 'Reservoir', 44.35, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER HURRICANE', 'Lower Hurricane Reservoir', 'Hartford', 'East Central', 7, 105, 1047, NULL, NULL, NULL, 'Lower Hurricane Reservoir Hartford', 'Reservoir', 43.65, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER MOORE', 'Lower Moore Pond', 'Plymouth', 'West Central', 5, 238, 1510, NULL, NULL, NULL, 'Lower Moore Pond Plymouth', 'Pond', 43.52, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER ORANGE', 'Lower Orange Reservoir', 'Orange', 'North Central', 8, 7082, 1190, NULL, NULL, NULL, 'Lower Orange Reservoir Orange', 'Reservoir', 44.17, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER SYMES', 'Lower Symes Pond', 'Ryegate', 'North Central', 57, 2636, 810, 9, NULL, 'NATURAL', 'Lower Symes Pond Ryegate', 'Pond', 44.25, -72.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER WINOOSKI', 'Unnamed Pond referred to by DEC as Lower Winooski', 'Winooski', 'Champlain ', 4, 195, 290, NULL, NULL, NULL, 'Lower Winooski Pond Winooski', 'Pond', 44.5, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOWER WORCESTER', 'Worcester Pond - Lower', 'Worcester', 'North Central', 35, 943, 1067, 8, NULL, 'ARTIFICIAL', 'Worcester Pond - Lower Worcester', 'Reservoir', 44.4, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LYE', 'Unnamed Pond referred to by DEC as Lye', 'Winhall', 'Green Mtn South', NULL, NULL, 2295, NULL, NULL, NULL, 'Lye Pond Winhall', 'Pond', 43.13, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LYE BROOK-N', 'Unnamed Pond referred to by DEC as Lye Brook - N', 'Sunderland', 'Green Mtn South', 10, 96, 2610, NULL, NULL, NULL, 'Lye Brook - N Pond Sunderland', 'Pond', 43.1, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LYE BROOK-S', 'Unnamed Pond referred to by DEC as Lye Brook - S', 'Sunderland', 'Green Mtn South', 18, 253, 2610, NULL, NULL, NULL, 'Lye Brook - S Pond Sunderland', 'Pond', 43.08, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LYFORD', 'Lyford Pond', 'Walden', 'North Central', 33, 299, 1683, 22, 8, 'NATURAL', 'Lyford Pond Walden', 'Pond', 44.4456114, -72.2467681, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LYMAN HILL', 'Unnamed Pond referred to by DEC as Lyman Hill', 'Marlboro', 'Green Mtn South', 9, 411, 1545, NULL, NULL, NULL, 'Lyman Hill Pond Marlboro', 'Pond', 42.87, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MACKVILLE', 'Mackville Pond', 'Hardwick', 'North Central', 11, 2099, 930, NULL, NULL, NULL, 'Mackville Pond Hardwick', 'Reservoir', 44.48, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MADELEINE', 'Lake Madeleine', 'Sandgate', 'Green Mtn South', 20, 100, 2175, NULL, 11, 'ARTIFICIAL', 'Lake Madeleine Sandgate', 'Reservoir', 43.17, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MAIDSTONE', 'Maidstone Lake', 'Maidstone', 'NE Kingdom', 745, 3103, 1303, 121, 46, 'NATURAL with ARTIFICIAL CONTROL', 'Maidstone Lake Maidstone', 'Lake (Artificial Control)', 44.6486637, -71.6470329, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MALLETT', 'Unnamed Pond referred to by DEC as Mallett', 'Milton', 'Champlain ', NULL, NULL, 295, NULL, NULL, NULL, 'Mallett Pond Milton', 'Pond', 44.58, -73.12, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MANCHESTERS', 'Unnamed Pond referred to by DEC as Manchesters', 'Thetford', 'East Central', 6, 223, 802, NULL, NULL, NULL, 'Manchesters Pond Thetford', 'Pond', 43.8, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MANSFIELD', 'Lake Mansfield', 'Stowe', 'North Central', 38, 1557, 1140, 18, 11, 'ARTIFICIAL', 'Lake Mansfield Stowe', 'Reservoir', 44.47, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MARL', 'Marl Pond', 'Sutton', 'NE Kingdom', 10, 256, 1570, NULL, NULL, NULL, 'Marl Pond Sutton', 'Pond', 44.7003288, -72.0600983, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MARLBORO-431', 'Unnamed Pond referred to by DEC as Marlboro - 431', 'Marlboro', 'Green Mtn South', 10, 1693, 1415, NULL, NULL, NULL, 'Marlboro - 431 Pond Marlboro', 'Pond', 42.88, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MARTIN', 'Unnamed Pond referred to by DEC as Martin', 'Williamstown', 'East Central', 28, 886, 1390, NULL, NULL, NULL, 'Martin Pond Williamstown', 'Pond', 44.15, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MARTINS', 'Martins Pond', 'Peacham', 'North Central', 82, 803, 1548, 17, 11, 'NATURAL with ARTIFICIAL CONTROL', 'Martins Pond Peacham', 'Lake (Artificial Control)', 44.3, -72.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MATHEWSON', 'Unnamed Pond referred to by DEC as Mathewson', 'Sheffield', 'North Central', NULL, NULL, 1665, NULL, NULL, NULL, 'Mathewson Pond Sheffield', 'Pond', 44.62, -72.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MAY', 'May Pond', 'Barton', 'NE Kingdom', 116, 1087, 1647, 31, 9, 'NATURAL with ARTIFICIAL CONTROL', 'May Pond Barton', 'Lake (Artificial Control)', 44.7417164, -72.1228779, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MCALLISTER', 'McAllister Pond', 'Lowell', 'North Central', 25, 533, 1290, 7, NULL, 'NATURAL', 'McAllister Pond Lowell', 'Pond', 44.83, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MCCONNELL', 'McConnell Pond', 'Brighton', 'NE Kingdom', 87, 3621, 1274, 18, NULL, 'NATURAL', 'McConnell Pond Brighton', 'Pond', 44.8189378, -71.8039827, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MCGOWAN-E', 'Unnamed Pond referred to by DEC as McGowan - E', 'Highgate', 'Champlain ', 18, 713, 580, NULL, NULL, NULL, 'McGowan - E Pond Highgate', 'Pond', 44.93, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MCGOWAN-W', 'Unnamed Pond referred to by DEC as McGowan - W', 'Highgate', 'Champlain ', 10, 252, 580, NULL, NULL, NULL, 'McGowan - W Pond Highgate', 'Pond', 44.93, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MCINTOSH', 'McIntosh Pond', 'Royalton', 'East Central', 23, 606, 990, 15, NULL, 'ARTIFICIAL', 'McIntosh Pond Royalton', 'Reservoir', 43.82, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MECAWEE', 'Mecawee Pond', 'Reading', 'East Central', 11, 852, 1430, NULL, NULL, NULL, 'Mecawee Pond Reading', 'Pond', 43.55, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MEMPHREMAGOG', 'Lake Memphremagog', 'Newport Town', 'NE Kingdom', 5966, 416320, 682, 351, 21, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Memphremagog Newport Town', 'Lake (Artificial Control)', 44.9853239, -72.2151023, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('METCALF', 'Metcalf Pond', 'Fletcher', 'Champlain ', 81, 801, 729, 25, 7, 'NATURAL', 'Metcalf Pond Fletcher', 'Pond', 44.7283824, -72.8840236, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MIDDLE WOODBURY', 'Unnamed Pond referred to by DEC as Middle Woodbury', 'Woodbury', 'North Central', 9, 992, 1150, NULL, NULL, NULL, 'Middle Woodbury Pond Woodbury', 'Pond', 44.43, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILE', 'Mile Pond', 'Ferdinand', 'NE Kingdom', 26, 156, 1240, 12, NULL, 'NATURAL', 'Mile Pond Ferdinand', 'Pond', 44.7778273, -71.799538, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILES', 'Miles Pond', 'Concord', 'NE Kingdom', 215, 4158, 1026, 55, 20, 'NATURAL with ARTIFICIAL CONTROL', 'Miles Pond Concord', 'Lake (Artificial Control)', 44.45, -71.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILL (BENSON)', 'Mill Pond (Parsons Mill Pond)', 'Benson', 'West Central', 39, 14063, 225, 8, NULL, 'ARTIFICIAL', 'Mill Pond Benson', 'Reservoir', 43.7053415, -73.2823356, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILL (WINDSR)', 'Mill Pond (Kennedys Pond)', 'Windsor', 'East Central', 77, 28071, 383, 26, NULL, 'ARTIFICIAL', 'Mill Pond Windsor', 'Reservoir', 43.4711828, -72.3967575, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILL (WOODFD)', 'Mill Pond', 'Woodford', 'Green Mtn South', 7, 988, 2050, NULL, NULL, NULL, 'Mill Pond Woodford', 'Pond', 42.9192463, -73.0273252, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILLER (ARLTON)', 'Unnamed Pond referred to by DEC as Miller', 'Arlington', 'Green Mtn South', 11, 3636, 762, NULL, NULL, NULL, 'Miller Pond Strafford', 'Lake (Artificial Control)', 43.892568, -72.3053715, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILLER (STRFRD)', 'Miller Pond', 'Strafford', 'East Central', 64, 664, 1323, 32, 8, 'NATURAL with ARTIFICIAL CONTROL', 'Miller Pond Arlington', 'Pond', 43.9, -72.3, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MILTON', 'Milton Pond', 'Milton', 'Champlain ', 24, 267, 834, 13, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Milton Pond Milton', 'Lake (Artificial Control)', 44.6347709, -73.0631899, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MINARDS', 'Minards Pond', 'Rockingham', 'Green Mtn South', 46, 202, 613, 46, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Minards Pond Rockingham', 'Lake (Artificial Control)', 43.15, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MINK', 'Unnamed Pond referred to by DEC as Mink', 'Enosburgh', 'Champlain ', NULL, NULL, 1125, NULL, NULL, NULL, 'Mink Pond Enosburgh', 'Pond', 44.9, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MINSEY', 'Unnamed Pond referred to by DEC as Minsey', 'Albany', 'North Central', 8, 115, 1690, NULL, NULL, NULL, 'Minsey Pond Albany', 'Pond', 44.72, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MIRROR', 'Mirror Lake (No. 10 Pond)', 'Calais', 'North Central', 85, 3349, 1047, 106, 43, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Mirror Calais', 'Lake (Artificial Control)', 44.4, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MITCHELL', 'Lake Mitchell', 'Sharon', 'East Central', 28, 4652, 900, 16, NULL, 'ARTIFICIAL', 'Lake Mitchell Sharon', 'Reservoir', 43.75, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOLLYS', 'Mollys Pond', 'Cabot', 'North Central', 38, 1320, 1631, 28, NULL, 'NATURAL', 'Mollys Pond Cabot', 'Pond', 44.3939461, -72.2359332, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOLLYS FALLS', 'Mollys Falls Reservoir', 'Cabot', 'North Central', 397, 14600, 1230, 35, 18, 'ARTIFICIAL', 'Mollys Falls Reservoir Cabot', 'Reservoir', 44.35, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOORE', 'Moore Reservoir', 'Waterford', 'NE Kingdom', 1235, 293580, 800, NULL, NULL, 'ARTIFICIAL', 'Moore Reservoir Waterford', 'Reservoir', 44.33, -71.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOOSE', 'Unnamed Pond referred to by DEC as Moose', 'Morgan', 'NE Kingdom', 10, 941, 1290, NULL, NULL, NULL, 'Moose Pond Morgan', 'Pond', 44.87, -71.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOREY', 'Lake Morey', 'Fairlee', 'East Central', 547, 5101, 416, 43, 24, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Morey Fairlee', 'Lake (Artificial Control)', 43.9247901, -72.1498123, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MORRISVILLE', 'Unnamed Pond referred to by DEC as Morrisville', 'Morristown', 'North Central', 8, 4465, 620, NULL, NULL, NULL, 'Morrisville Pond Morristown', 'Pond', 44.55, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOSCOW', 'Moscow Pond', 'Hubbardton', 'West Central', 3, 111, 710, NULL, NULL, NULL, 'Moscow Pond Hubbardton', 'Pond', 43.6839534, -73.2365009, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOSES', 'Moses Pond', 'Weston', 'West Central', 12, 105, 2230, NULL, NULL, NULL, 'Moses Pond Weston', 'Pond', 43.33424, -72.8428774, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOSLEY', 'Unnamed Pond referred to by DEC as Mosley', 'Hartford', 'East Central', NULL, NULL, 1030, NULL, NULL, NULL, 'Mosley Pond Hartford', 'Pond', 43.7, -72.33, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MOUNT TABOR', 'Unnamed Pond referred to by DEC as Mount Tabor', 'Mount Tabor', 'West Central', NULL, NULL, 2375, NULL, NULL, NULL, 'Mount Tabor Pond Mount Tabor', 'Pond', 43.38, -72.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MT. SNOW', 'Unnamed Pond referred to by DEC as Mt. Snow', 'Dover', 'Green Mtn South', NULL, NULL, 1685, NULL, NULL, NULL, 'Mt. Snow Pond Dover', 'Pond', 42.97, -72.88, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (BRAINT)', 'Mud Pond', 'Braintree', 'East Central', 10, 681, 1370, NULL, NULL, NULL, 'Mud Pond Braintree', 'Pond', 43.9897866, -72.698718, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (BRIGTN)-W', 'Mud Pond', 'Brighton', 'NE Kingdom', 6, 19, 1250, NULL, NULL, NULL, 'Mud Pond Brighton', 'Pond', 44.82116, -71.821483, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (BRUNWK)', 'Mud Pond', 'Brunswick', 'NE Kingdom', 5, 320, 1050, NULL, NULL, NULL, 'Mud Pond Brunswick', 'Pond', 44.7378277, -71.6709234, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (CHARTN)', 'Mud Pond', 'Charleston', 'NE Kingdom', 4, 356, 1370, NULL, NULL, NULL, 'Mud Pond Charleston', 'Pond', 44.8881035, -72.0189862, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (CRAFBY)', 'Mud Pond', 'Craftsbury', 'North Central', 35, 422, 868, 7, NULL, 'NATURAL', 'Mud Pond Craftsbury', 'Pond', 44.6383845, -72.3942744, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (EHAVEN)', 'Mud Pond', 'East Haven', 'NE Kingdom', 5, 45, 1830, NULL, NULL, NULL, 'Mud Pond East Haven', 'Pond', 44.5997763, -71.8156479, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (GRANBY)', 'Mud Pond', 'Granby', 'NE Kingdom', 55, 2128, 1537, NULL, NULL, 'NATURAL', 'Mud Pond Granby', 'Pond', 44.5797769, -71.7381461, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (GRNSBO)-E', 'Mud Pond', 'Greensboro', 'North Central', 9, 1357, 1470, NULL, NULL, NULL, 'Mud Pond Greensboro', 'Pond', 44.5781081, -72.3531619, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (GRNSBO)-SW', 'Mud Pond', 'Greensboro', 'North Central', 5, 70, 1210, NULL, NULL, NULL, 'Mud Pond Greensboro', 'Pond', 44.58, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (HOLLND)', 'Mud Pond', 'Holland', 'NE Kingdom', 14, 359, 1510, NULL, NULL, NULL, 'Mud Pond Holland', 'Pond', 44.9367139, -72.0281531, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (HYDEPK)', 'Mud Pond', 'Hyde Park', 'North Central', 14, 177, 1170, NULL, NULL, NULL, 'Mud Pond Hyde Park', 'Pond', 44.605885, -72.5034444, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (IRASBG)', 'Mud Pond', 'Irasburg', 'NE Kingdom', 5, 243, 1210, NULL, NULL, NULL, 'Mud Pond Irasburg', 'Pond', 44.7822708, -72.2409367, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (LEICTR)', 'Mud Pond', 'Leicester', 'West Central', 23, 290, 569, 10, NULL, 'NATURAL', 'Mud Pond Leicester', 'Pond', 43.88, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (LOWELL)', 'Mud Pond', 'Lowell', 'North Central', 2, 26, 1650, NULL, NULL, NULL, 'Mud Pond Lowell', 'Pond', 44.73, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (MARSFD)', 'Mud Pond', 'Marshfield', 'North Central', NULL, NULL, NULL, NULL, NULL, NULL, 'Mud Pond Marshfield', 'Pond', 44.2775598, -72.3395451, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (MORGAN)-N', 'Mud Pond', 'Morgan', 'NE Kingdom', 35, 1205, 1489, 3, NULL, 'NATURAL', 'Mud Pond Morgan ', 'Pond', 44.9172696, -72.0448202, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (ORWELL)', 'Mud Pond', 'Orwell', 'West Central', 10, 106, 670, NULL, NULL, NULL, 'Mud Pond Orwell', 'Pond', 43.7658956, -73.2701144, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (PEACHM)', 'Mud Pond', 'Peacham', 'North Central', 34, 318, 1548, 4, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Mud Pond Peacham', 'Lake (Artificial Control)', 44.3072818, -72.2125974, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (PERU)', 'Mud Pond', 'Peru', 'Green Mtn South', 10, 371, 1410, NULL, NULL, NULL, 'Mud Pond Peru', 'Pond', 43.2228532, -72.8706551, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (SHEFLD)', 'Mud Pond', 'Sheffield', 'North Central', 5, 58, 1710, NULL, NULL, NULL, 'Mud Pond Sheffield', 'Pond', 44.6783844, -72.1389892, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (THETFD)', 'Mud Pond (Forscythie Pond)', 'Thetford', 'East Central', 20, 437, 599, 7, NULL, 'ARTIFICIAL', 'Mud Pond Thetford', 'Reservoir', 43.85, -72.25, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (WESTMR)-W', 'Mud Pond', 'Westmore', 'NE Kingdom', 12, 192, 1817, NULL, NULL, NULL, 'Mud Pond Westmore', 'Pond', 44.7711608, -71.9464848, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (EDEN)', 'Mud Pond', 'Eden', 'North Central', 1, 38, 1190, NULL, NULL, NULL, 'Mud Pond Eden', 'Pond', 44.6981054, -72.5198344, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (WOODBY)-SE', 'Mud Pond', 'Woodbury', 'North Central', 18, 204, 1393, NULL, NULL, 'NATURAL', 'Mud Pond Woodbury', 'Pond', 44.4875544, -72.3945516, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD (WOODFD)', 'Mud Pond', 'Woodford', 'Green Mtn South', 6, 23, 2230, NULL, NULL, NULL, 'Mud Pond Woodford', 'Pond', 42.83, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUD CREEK', 'Mud Creek Pond', 'Alburgh', 'Champlain ', 333, 6400, 99, NULL, NULL, 'ARTIFICIAL', 'Mud Creek Pond Alburgh', 'Reservoir', 44.98, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUDD', 'Mudd Pond', 'Hubbardton', 'West Central', 20, 608, 1090, 7, NULL, NULL, 'Mudd Pond Hubbardton', 'Pond', 43.7372864, -73.1462228, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUDDY (NEWBRY)', 'Muddy Pond', 'Newbury', 'East Central', 3, 152, 1390, NULL, NULL, NULL, 'Muddy Pond Newbury', 'Pond', 44.1089531, -72.1667599, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUDDY (RUTLDC)', 'Muddy Pond', 'Rutland City', 'West Central', 10, 448, 830, NULL, NULL, NULL, 'Muddy Pond Rutland City', 'Pond', 43.6297899, -73.0042742, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('MUSSEY', 'Unnamed Pond referred to by DEC as Mussey', 'Rutland Town', 'West Central', NULL, NULL, 750, NULL, NULL, NULL, 'Mussey Pond Rutland Town', 'Pond', 43.6, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('N.E. DEVELOPERS', 'Northeast Developers Pond', 'Wells', 'West Central', 27, 417, 500, 16, NULL, 'ARTIFICIAL', 'Northeast Developers Pond Wells', 'Reservoir', 43.43, -73.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NEAL', 'Neal Pond', 'Lunenburg', 'NE Kingdom', 185, 5720, 1200, 35, 16, 'NATURAL with ARTIFICIAL CONTROL', 'Neal Pond Lunenburg', 'Lake (Artificial Control)', 44.4897795, -71.6920327, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NELSON (EMONTP)', 'Nelson Pond', 'East Montpelier', 'North Central', 10, 156, 1210, NULL, NULL, NULL, 'Nelson Pond East Montpelier', 'Pond', 44.3183914, -72.525386, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NEWARK', 'Newark Pond', 'Newark', 'NE Kingdom', 153, 554, 1832, 31, 14, 'NATURAL', 'Newark Pond Newark', 'Pond', 44.7175509, -71.9823186, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NEWPORT CENTER', 'Unnamed Pond referred to by DEC as Newport Center', 'Newport Town', 'NE Kingdom', NULL, NULL, 760, NULL, NULL, NULL, 'Newport Center Pond Newport Town', 'Pond', 44.95, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NICHOLS', 'Nichols Pond', 'Woodbury', 'North Central', 171, 2920, 1128, 109, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Nichols Pond Woodbury', 'Lake (Artificial Control)', 44.45, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NINEVAH', 'Lake Ninevah', 'Mount Holly', 'West Central', 171, 769, 1755, 12, 6, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Ninevah Mount Holly', 'Lake (Artificial Control)', 43.47, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORFORD', 'Norford Lake', 'Thetford', 'East Central', 21, 605, 985, 11, NULL, 'ARTIFICIAL', 'Norford Lake Thetford', 'Reservoir', 43.8, -72.3, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH (BRISTL)', 'North Pond', 'Bristol', 'Champlain ', 6, 33, 2110, NULL, NULL, NULL, 'North Pond Bristol', 'Pond', 44.1033922, -73.0465064, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH (BRKFLD)', 'North Pond', 'Brookfield', 'East Central', 24, 829, 1419, 17, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'North Pond Brookfield', 'Lake (Artificial Control)', 44.0481193, -72.6189947, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH (CHITDN)', 'North Pond', 'Chittenden', 'West Central', 3, 35, 2490, NULL, NULL, NULL, 'North Pond Chittenden', 'Pond', 43.7486774, -72.8859398, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH (WHITHM)', 'North Pond', 'Whitingham', 'Green Mtn South', 20, 229, 1810, NULL, NULL, 'ARTIFICIAL', 'North Pond Whitingham', 'Reservoir', 42.7550826, -72.8784309, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH BENNINGTON', 'North Bennington Reservoir', 'Shaftsbury', 'Green Mtn South', 1, 934, 1410, NULL, NULL, NULL, 'North Bennington Reservoir Shaftsbury', 'Reservoir', 42.97, -73.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH HARTLAND', 'North Hartland Reservoir', 'Hartland', 'East Central', 215, 140800, 425, NULL, NULL, 'ARTIFICIAL', 'North Hartland Reservoir Hartland', 'Reservoir', 43.62, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH KING', 'North King Pond', 'Woodbury', 'North Central', 3, 32, 1190, NULL, NULL, NULL, 'North King Pond Woodbury', 'Pond', 44.42, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH MONTPELIER', 'North Montpelier Pond', 'East Montpelier', 'North Central', 72, 32581, 703, 12, NULL, 'ARTIFICIAL', 'North Montpelier Pond East Montpelier', 'Reservoir', 44.32, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH SPRINGFIELD', 'North Springfield Reservoir', 'Springfield', 'East Central', 290, 101120, 475, NULL, NULL, 'ARTIFICIAL', 'North Springfield Reservoir Springfield', 'Reservoir', 43.35, -72.5, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH ST. ALBANS', 'St. Albans Reservoir, North', 'Fairfax', 'Champlain ', 35, 1036, 745, 28, 13, 'ARTIFICIAL', 'St. Albans Reservoir, North Fairfax', 'Reservoir', 44.77, -73.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTH UNDERHILL', 'Unnamed Pond referred to by DEC as North Underhill', 'Underhill', 'Champlain ', 12, 1123, 850, NULL, NULL, NULL, 'North Underhill Pond Underhill', 'Pond', 44.6, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NORTON', 'Norton Pond', 'Norton', 'NE Kingdom', 583, 11142, 1335, 30, 10, 'NATURAL with ARTIFICIAL CONTROL', 'Norton Pond Norton', 'Lake (Artificial Control)', 44.93, -71.87, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NOTCH', 'Notch Pond', 'Ferdinand', 'NE Kingdom', 22, 500, 1555, 26, NULL, 'NATURAL', 'Notch Pond Ferdinand', 'Pond', 44.7406056, -71.7173137, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NOYES', 'Noyes Pond (Seyon Pond)', 'Groton', 'North Central', 39, 2408, 1781, 11, 6, 'ARTIFICIAL', 'Noyes Pond Groton', 'Reservoir', 44.23, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NULHEGAN', 'Nulhegan Pond', 'Brighton', 'NE Kingdom', 37, 5421, 1158, 14, NULL, 'NATURAL', 'Nulhegan Pond Brighton', 'Pond', 44.791716, -71.8178717, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('NUMBER ELEVEN', 'Unnamed Pond referred to by DEC as Number Eleven', 'Westford', 'Champlain ', 12, 300, 710, NULL, NULL, NULL, 'Number Eleven Pond Westford', 'Pond', 44.62, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OAK HILL', 'Unnamed Pond referred to by DEC as Oak Hill', 'Williston', 'Champlain ', 8, 1534, 630, NULL, NULL, NULL, 'Oak Hill Pond Williston', 'Pond', 44.42, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OLD MARSH', 'Old Marsh Pond', 'Fair Haven', 'West Central', 131, 1802, 484, 6, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Old Marsh Pond Fair Haven', 'Lake (Artificial Control)', 43.63, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OLYMPUS POOL', 'Olympus Pool', 'Proctor', 'West Central', 3, 96, 530, NULL, NULL, NULL, 'Olympus Pool Pond Proctor', 'Pond', 43.65, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ORANGE', 'Unnamed Pond referred to by DEC as Orange', 'Orange', 'North Central', NULL, NULL, 1530, NULL, NULL, NULL, 'Orange Pond Orange', 'Pond', 44.22, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OSMORE', 'Osmore Pond', 'Peacham', 'North Central', 48, 778, 1470, 12, 6, 'NATURAL', 'Osmore Pond Peacham', 'Pond', 44.3083926, -72.2781547, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OTTER', 'Unnamed Pond referred to by DEC as Otter', 'Belvidere', 'Champlain ', NULL, NULL, 1350, NULL, NULL, NULL, 'Otter Pond Belvidere', 'Pond', 44.78, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OXBOW', 'Unnamed Pond referred to by DEC as Oxbow', 'Swanton', 'Champlain ', 27, 190, 115, NULL, NULL, NULL, 'Oxbow Pond Swanton', 'Pond', 44.92, -73.08, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('OXBOW-2', 'Unnamed Pond referred to by DEC as Oxbow - 2', 'Fairfax', 'Champlain ', NULL, NULL, 430, NULL, NULL, NULL, 'Oxbow - 2  Pond Fairfax', 'Pond', 44.65, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PAGE', 'Page Pond', 'Albany', 'North Central', 16, 106, 1204, NULL, NULL, NULL, 'Page Pond Albany', 'Pond', 44.7147718, -72.3670515, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PAINE', 'Unnamed Pond referred to by DEC as Paine', 'Northfield', 'East Central', NULL, NULL, 1570, NULL, NULL, NULL, 'Paine Pond Northfield', 'Pond', 44.13, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PARAN', 'Lake Paran', 'Bennington', 'Green Mtn South', 40, 9312, 647, 23, 11, 'ARTIFICIAL', 'Lake Paran Bennington', 'Reservoir', 42.9328561, -73.2337199, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PARKER', 'Lake Parker', 'Glover', 'North Central', 250, 5418, 1299, 45, 25, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Parker Glover', 'Lake (Artificial Control)', 44.7194941, -72.2328808, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PATCH', 'Patch Pond', 'Rutland City', 'West Central', 20, 33531, 605, NULL, NULL, 'ARTIFICIAL', 'Patch Pond Rutland City', 'Reservoir', 43.6309011, -72.9823293, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PAUL STREAM', 'Paul Stream Pond', 'Brunswick', 'NE Kingdom', 20, 151, 1025, 10, NULL, 'NATURAL', 'Paul Stream Pond Brunswick', 'Pond', 44.6908845, -71.6225882, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PEABODY', 'Unnamed Pond referred to by DEC as Peabody', 'Weston', 'West Central', NULL, NULL, 2240, NULL, NULL, NULL, 'Peabody Pond Weston', 'Pond', 43.317018, -72.8439883, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PEACE', 'Unnamed Pond referred to by DEC as Peace', 'Eden', 'North Central', NULL, NULL, 1840, NULL, NULL, NULL, 'Peace Pond Eden', 'Pond', 44.73, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PEACHAM', 'Peacham Pond', 'Peacham', 'North Central', 340, 3750, 1401, 61, 20, 'NATURAL with ARTIFICIAL CONTROL', 'Peacham Pond Peacham', 'Lake (Artificial Control)', 44.33, -72.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PECKS', 'Pecks Pond', 'Barre Town', 'North Central', 16, 443, 1010, NULL, NULL, NULL, 'Pecks Pond Barre Town', 'Pond', 44.1681171, -72.5364945, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PENSIONER', 'Pensioner Pond', 'Charleston', 'NE Kingdom', 173, 66882, 1141, 39, 15, 'NATURAL with ARTIFICIAL CONTROL', 'Pensioner Pond Charleston', 'Lake (Artificial Control)', 44.8736591, -72.0573206, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PERCH (BENSON)', 'Perch Pond', 'Benson', 'West Central', 24, 110, 527, 44, 16, 'NATURAL with ARTIFICIAL CONTROL', 'Perch Pond Benson', 'Lake (Artificial Control)', 43.7503403, -73.2798365, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PERCH (WOLCTT)', 'Perch Pond', 'Wolcott', 'North Central', 7, 902, 1190, NULL, NULL, NULL, 'Perch Pond Wolcott', 'Pond', 44.6108849, -72.4976109, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PERRY-JACKSON', 'Unnamed Pond referred to by DEC as Perry - Jackson', 'Cornwall', 'Champlain ', NULL, NULL, 360, NULL, NULL, NULL, 'Perry - Jackson Pond Cornwall', 'Pond', 44, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PERU', 'Unnamed Pond referred to by DEC as Peru', 'Peru', 'Green Mtn South', NULL, NULL, 1625, NULL, NULL, NULL, 'Peru Pond Peru', 'Pond', 43.23, -72.9, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PHILLIPS (BENSON)', 'unnamed pond referred to by DEC as Phillips', 'Benson', 'West Central', 2, NULL, 490, NULL, NULL, NULL, 'Phillips Pond Benson', 'Pond', 43.71648, -73.34788, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PHILLIPS (WSTFLD)', 'Phillips Pond', 'Westfield', 'NE Kingdom', 4, 77, 990, NULL, NULL, NULL, 'Phillips Pond Westfield', 'Pond', 44.92, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PICKEREL', 'Pickerel', 'Manchester', 'Green Mtn South', 9, 31, 730, NULL, NULL, NULL, 'Pickerel Pond Manchester', 'Pond', 43.2064646, -73.019548, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PICKETT', 'Pickett Pond', 'Woodbury', 'North Central', 5, 416, 1410, NULL, NULL, NULL, 'Pickett Pond Woodbury', 'Pond', 44.4395, -72.3801057, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PICKLES', 'Pickles Pond', 'Brookfield', 'East Central', 17, 268, 1470, NULL, NULL, NULL, 'Pickles Pond Brookfield', 'Pond', 43.9970092, -72.6087154, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PICO', 'Pico Pond', 'Killington', 'West Central', 12, 581, 2160, NULL, NULL, NULL, 'Pico Pond Killington', 'Pond', 43.6489569, -72.8123251, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PIEDMONT', 'Piedmont Pond', 'Rutland City', 'West Central', 1, 988, 610, NULL, NULL, NULL, 'Piedmont Pond Rutland City', 'Pond', 43.6089571, -72.9570505, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PIGEON', 'Pigeon Pond', 'Groton', 'North Central', 69, 801, 1954, 21, 11, 'NATURAL', 'Pigeon Pond Groton', 'Pond', 44.245894, -72.3284329, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PINE', 'Pine Pond', 'Castleton', 'West Central', 40, 774, 474, 7, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Pine Pond Castleton', 'Lake (Artificial Control)', 43.63, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PINNACLE', 'Unnamed Pond referred to by DEC as Pinnacle', 'Wells', 'West Central', 6, 163, 1370, NULL, NULL, NULL, 'Pinnacle Pond Wells', 'Pond', 43.45, -73.13, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PINNEO', 'Lake Pinneo', 'Hartford', 'East Central', 50, 150, 610, 11, NULL, 'ARTIFICIAL', 'Lake Pinneo Hartford', 'Reservoir', 43.65, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PITCHER', 'Unnamed Pond referred to by DEC as Pitcher', 'Sutton', 'NE Kingdom', NULL, NULL, 1200, NULL, NULL, NULL, 'Pitcher Pond Sutton', 'Pond', 44.7, -72.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PLEASANT VALLEY', 'Pleasant Valley Reservoir', 'Brattleboro', 'Green Mtn South', 25, 649, 630, 38, 18, 'ARTIFICIAL', 'Pleasant Valley Reservoir Brattleboro', 'Reservoir', 42.88, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PLEIAD', 'Pleiad Lake', 'Hancock', 'West Central', 6, 54, 2050, NULL, NULL, NULL, 'Pleiad Lake Hancock', 'Lake', 43.9339521, -72.9578898, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('POMFRET', 'Unnamed Pond referred to by DEC as Pomfret', 'Pomfret', 'East Central', NULL, NULL, 960, NULL, NULL, NULL, 'Pomfret Pond Pomfret', 'Pond', 43.73, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PORTER', 'Porter''s Pond', 'Ferrisburgh', 'Champlain ', 20, 188, 114, 10, NULL, 'NATURAL', 'Porter''s Pond Ferrisburgh', 'Pond', 44.2, -73.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('POTTERS', 'Potters Pond', 'Albany', 'North Central', 5, 129, 850, NULL, NULL, NULL, 'Potters Pond Albany', 'Pond', 44.78, -72.32, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PRENTISS', 'Prentiss Pond', 'Dorset', 'Green Mtn South', 2, 207, 930, NULL, NULL, NULL, 'Prentiss Pond Dorset', 'Pond', 43.2517421, -73.105383, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PRESTON', 'Preston Pond', 'Bolton', 'Champlain ', 9, 206, 1150, NULL, NULL, NULL, 'Preston Pond Bolton', 'Pond', 44.423942, -72.9090114, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PRISON', 'Unnamed Pond referred to by DEC as Prison', 'Windsor', 'East Central', 5, NULL, 1000, NULL, NULL, NULL, 'Prison Pond Windsor', 'Pond', 43.5, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('PROPER', 'Proper Pond', 'Highgate', 'Champlain ', 9, 157, 225, NULL, NULL, NULL, 'Proper Pond Highgate', 'Pond', 45.0033748, -73.053183, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('QUARRY (WTHFLD)', 'Quarry Pond', 'Weathersfield', 'East Central', 1, 15, 1030, NULL, NULL, NULL, 'Quarry Pond Castleton', 'Pond', 43.6, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('QUARRY (CSLTON)', 'Unnamed Pond referred to by DEC as Quarry', 'Castleton', 'West Central', 17, 86, 540, NULL, NULL, NULL, 'Quarry Pond Weathersfield', 'Pond', 43.372573, -72.5356469, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RANDOLPH-N', 'Unnamed Pond referred to by DEC as Randolph - N', 'Randolph', 'East Central', 10, 117, 1470, NULL, NULL, NULL, 'Randolph - N Pond Randolph', 'Pond', 43.98, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RAPONDA', 'Lake Raponda', 'Wilmington', 'Green Mtn South', 121, 616, 1832, 12, 8, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Raponda Wilmington', 'Lake (Artificial Control)', 42.8750812, -72.8175965, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RATTLESNAKE', 'Unnamed Pond referred to by DEC as Rattlesnake', 'Springfield', 'East Central', NULL, NULL, 955, NULL, NULL, NULL, 'Rattlesnake Pond Springfield', 'Pond', 43.33, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('READING', 'Reading Pond', 'Reading', 'East Central', 22, 662, 1756, 10, 6, 'NATURAL', 'Reading Pond Reading', 'Pond', 43.5020148, -72.6534293, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RED', 'Unnamed Pond referred to by DEC as Red', 'Winhall', 'Green Mtn South', NULL, NULL, 489, NULL, NULL, NULL, 'Red Pond Winhall', 'Pond', 43.17, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RED MILL', 'Red Mill Pond', 'Woodford', 'Green Mtn South', 7, 1258, 2230, NULL, NULL, NULL, 'Red Mill Pond Woodford', 'Pond', 42.8892467, -73.0276028, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RED ROCK', 'Red Rock', 'Addison', 'Champlain ', NULL, NULL, 1240, NULL, NULL, NULL, 'Red Rock Pond Addison', 'Pond', 44.07, -73.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RESCUE', 'Rescue Lake', 'Ludlow', 'Green Mtn South', 184, 22859, 1044, 95, 24, 'NATURAL with ARTIFICIAL CONTROL', 'Rescue Lake Ludlow', 'Lake (Artificial Control)', 43.45, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RESERVOIR', 'Reservoir Pond (Lake Pauline)', 'Ludlow', 'Green Mtn South', 32, 23468, 1040, 47, NULL, 'ARTIFICIAL', 'Reservoir Pond Ludlow', 'Reservoir', 43.43, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('REVOIR', 'Unnamed Pond referred to by DEC as Revoir', 'Coventry', 'NE Kingdom', NULL, NULL, 700, NULL, NULL, NULL, 'Revoir Pond Coventry', 'Pond', 44.85, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('REYNOLDS', 'Reynolds Reservoir', 'Proctor', 'West Central', 3, 86, 790, NULL, NULL, NULL, 'Reynolds Reservoir Proctor', 'Pond', 43.65, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RICHARDS', 'Unnamed Pond referred to by DEC as Richards', 'Marshfield', 'North Central', 14, 704, 1090, NULL, NULL, NULL, 'Richards Pond Marshfield', 'Pond', 44.37, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RICHMOND', 'Richmond Pond', 'Richmond', 'Champlain ', 24, 539, 730, NULL, NULL, 'NATURAL', 'Richmond Pond Richmond', 'Pond', 44.4178307, -72.9467898, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RICHVILLE', 'Richville Pond', 'Shoreham', 'West Central', 129, 17920, 253, 8, 3, 'ARTIFICIAL', 'Richville Pond Shoreham', 'Reservoir', 43.85, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RICKER', 'Ricker Pond', 'Groton', 'North Central', 95, 13622, 1051, 31, 12, 'NATURAL with ARTIFICIAL CONTROL', 'Ricker Pond Groton', 'Lake (Artificial Control)', 44.2470054, -72.244541, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RIDDEL', 'Riddel Pond', 'Orange', 'North Central', 15, 1294, 1590, NULL, NULL, NULL, 'Riddel Pond Orange', 'Pond', 44.1408963, -72.3495433, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RIPTON-NW', 'Unnamed Pond referred to by DEC as Ripton - NW', 'Ripton', 'West Central', 8, 352, 1590, NULL, NULL, NULL, 'Ripton - NW Pond Ripton', 'Pond', 44.03, -73.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RITTERBUSH', 'Ritterbush Pond', 'Eden', 'North Central', 14, 373, 1041, NULL, NULL, NULL, 'Ritterbush Pond Eden', 'Pond', 44.7469932, -72.5990058, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RITTERBUSH MEADOW', 'Unnamed Pond referred to by DEC as Ritterbush Meadow', 'Eden', 'North Central', 10, 921, 935, NULL, NULL, NULL, 'Ritterbush Meadow Pond Eden', 'Pond', 44.75, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROACH', 'Roach Pond', 'Hubbardton', 'West Central', 20, 145, 534, 7, NULL, NULL, 'Roach Pond Hubbardton', 'Pond', 43.7156197, -73.2053899, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROBINSON', 'Unnamed Pond referred to by DEC as Robinson', 'Northfield', 'East Central', 7, 2553, 1290, NULL, NULL, NULL, 'Robinson Pond Northfield', 'Pond', 44.12, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROCKY', 'Rocky Pond', 'Rutland City', 'West Central', 8, 74, 861, NULL, NULL, NULL, 'Rocky Pond Rutland City', 'Pond', 43.6267345, -73.0034408, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROGERS', 'Unnamed Pond referred to by DEC as Rogers', 'Westford', 'Champlain ', NULL, NULL, 675, NULL, NULL, NULL, 'Rogers Pond Westford', 'Pond', 44.6, -73.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROOD', 'Rood Pond', 'Williamstown', 'East Central', 23, 343, 1306, 52, 25, 'NATURAL with ARTIFICIAL CONTROL', 'Rood Pond Williamstown', 'Lake (Artificial Control)', 44.0770076, -72.5889944, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROOT', 'Root Pond', 'Benson', 'West Central', 18, 578, 412, 56, NULL, 'NATURAL', 'Root Pond Benson', 'Pond', 43.678953, -73.3495587, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROSS', 'Unnamed Pond referred to by DEC as Ross', 'Morristown', 'North Central', NULL, NULL, 820, NULL, NULL, NULL, 'Ross Pond Morristown', 'Pond', 44.52, -72.65, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROULEAU', 'Rouleau Pond', 'Williamstown', 'East Central', 1, 913, 970, NULL, NULL, NULL, 'Rouleau Pond Williamstown', 'Pond', 44.12, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROUND (EDEN)', 'Round Pond', 'Eden', 'North Central', 10, 98, 1206, NULL, NULL, NULL, 'Round Pond Eden', 'Pond', 44.7064385, -72.5265014, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROUND (HOLLND)', 'Round Pond', 'Holland', 'NE Kingdom', 14, 42, 1516, NULL, NULL, NULL, 'Round Pond Holland', 'Pond', 45.0019907, -71.9250961, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROUND (MILTON)', 'Round Pond', 'Milton', 'Champlain ', 22, 117, 390, 31, NULL, 'NATURAL', 'Round Pond Milton', 'Pond', 44.6117133, -73.2195746, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROUND (NEWBRY)', 'Round Pond', 'Newbury', 'East Central', 30, 260, 1241, 23, NULL, 'NATURAL', 'Round Pond Newbury', 'Pond', 44.1053421, -72.1589818, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROUND (SHEFLD)', 'Round Pond', 'Sheffield', 'North Central', 13, 154, 1631, NULL, NULL, NULL, 'Round Pond Sheffield', 'Pond', 44.6775511, -72.1503784, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROWE', 'Unnamed Pond referred to by DEC as Rowe', 'West Windsor', 'East Central', 7, 263, 770, NULL, NULL, NULL, 'Rowe Pond West Windsor', 'Pond', 43.47, -72.5, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROXBURY FLAT', 'Unnamed Pond referred to by DEC as Roxbury Flat', 'Roxbury', 'East Central', 13, 1806, 990, NULL, NULL, NULL, 'Roxbury Flat Pond Roxbury', 'Pond', 44.08, -72.73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ROYALTON HILL', 'Unnamed Pond referred to by DEC as Royalton Hill', 'Royalton', 'East Central', 11, 199, 1370, NULL, NULL, NULL, 'Royalton Hill Pond Royalton', 'Pond', 43.78, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RUNNEMEDE', 'Lake Runnemede (Evarts Pond)', 'Windsor', 'East Central', 62, 133, 322, 13, NULL, 'ARTIFICIAL', 'Lake Runnemede Windsor', 'Reservoir', 43.4839605, -72.3892576, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RUSH', 'Rush', 'Eden', 'North Central', 14, 131, 1290, NULL, NULL, NULL, 'Rush Pond Eden', 'Pond', 44.6711614, -72.5312238, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RUSS', 'Russ Pond', 'Elmore', 'North Central', 7, 59, 1290, NULL, NULL, NULL, 'Russ Pond Elmore', 'Pond', 44.4625546, -72.5303891, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RUTLAND CITY', 'Rutland City Reservoir', 'Rutland Town', 'West Central', 13, 49, 930, NULL, NULL, NULL, 'Rutland City Reservoir Rutland Town', 'Reservoir', 43.65, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RYDER', 'Ryder Pond', 'Whitingham', 'Green Mtn South', 14, 115, 1630, NULL, NULL, NULL, 'Ryder Pond Whitingham', 'Pond', 42.82, -72.85, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('RYEGATE CENTER', 'Unnamed Pond referred to by DEC as Ryegate Center', 'Ryegate', 'North Central', 7, 187, 1250, NULL, NULL, NULL, 'Ryegate Center Pond Ryegate', 'Pond', 44.22, -72.12, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SABIN', 'Sabin Pond (Woodbury Lake)', 'Calais', 'North Central', 142, 9014, 922, 58, 18, 'NATURAL', 'Sabin Pond Calais', 'Pond', 44.4042231, -72.4162173, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SADAWGA', 'Sadawga Pond', 'Whitingham', 'Green Mtn South', 194, 1169, 1670, 10, 6, 'NATURAL with ARTIFICIAL CONTROL', 'Sadawga Pond Whitingham', 'Lake (Artificial Control)', 42.78036, -72.8762088, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SALEM', 'Lake Salem', 'Derby', 'NE Kingdom', 764, 84133, 963, 70, 20, 'NATURAL', 'Lake Salem Derby', 'Lake', 44.9292138, -72.1037106, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SALMON', 'Unnamed Pond referred to by DEC as Salmon', 'Putney', 'Green Mtn South', 6, 464, 1090, NULL, NULL, NULL, 'Salmon Pond Putney', 'Pond', 42.98, -72.58, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SANGMAN', 'Unnamed Pond referred to by DEC as Sangman', 'Pittsford', 'West Central', NULL, NULL, 590, NULL, NULL, NULL, 'Sangman Pond Pittsford', 'Pond', 43.68, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SARAH MOORES', 'Sarah Moores Pond', 'Barnet', 'North Central', 13, 288, 975, NULL, NULL, NULL, 'Sarah Moores Pond Barnet', 'Pond', 44.323671, -72.0698169, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SARGENT', 'Sargent Pond (Unsargent Pond)', 'Coventry', 'NE Kingdom', 6, 1306, 930, NULL, NULL, NULL, 'Sargent Pond Coventry', 'Pond', 43.6770107, -73.075665, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SAWDUST', 'Sawdust Pond', 'Newark', 'NE Kingdom', 15, 2751, 1775, NULL, NULL, NULL, 'Sawdust Pond Newark', 'Pond', 44.7317172, -71.970374, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SAXE', 'Unnamed Pond referred to by DEC as Saxe', 'Highgate', 'Champlain ', 5, 350, 235, NULL, NULL, NULL, 'Saxe Pond Highgate', 'Pond', 44.97, -73.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SCHOFIELD', 'Schofield Pond', 'Hyde Park', 'North Central', 29, 936, 1268, 23, NULL, 'NATURAL', 'Schofield Pond Hyde Park', 'Pond', 44.6494951, -72.5317793, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SCHWARTZ', 'Unnamed Pond referred to by DEC as Schwartz', 'Morristown', 'North Central', NULL, NULL, 1250, NULL, NULL, NULL, 'Schwartz Pond Morristown', 'Pond', 44.53, -72.68, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SCOTCH', 'Unnamed Pond referred to by DEC as Scotch', 'Fair Haven', 'West Central', NULL, NULL, 350, NULL, NULL, NULL, 'Scotch Pond Fair Haven', 'Pond', 43.62, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SEARSBURG', 'Searsbury Reservoir', 'Searsburg', 'Green Mtn South', 25, 98, 1756, NULL, NULL, 'ARTIFICIAL', 'Searsburg Reservoir Searsburg', 'Reservoir', 42.92, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SEYMOUR', 'Seymour Lake', 'Morgan', 'NE Kingdom', 1769, 12920, 1279, 167, 70, 'NATURAL with ARTIFICIAL CONTROL', 'Seymour Lake Morgan', 'Lake (Artificial Control)', 44.8969923, -71.9817632, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHADOW (CONCRD)', 'Shadow Lake', 'Concord', 'NE Kingdom', 128, 1649, 1336, 55, 14, 'NATURAL', 'Shadow Lake Concord', 'Lake', 44.4003367, -71.8734249, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHADOW (GLOVER)', 'Shadow Lake', 'Glover', 'North Central', 210, 3575, 1396, 139, 55, 'NATURAL with ARTIFICIAL CONTROL', 'Shadow Lake Glover', 'Lake (Artificial Control)', 44.668103, -72.226571, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHADOW (WOODBY)', 'Shadow Pond', 'Woodbury', 'North Central', 2, 115, 1190, NULL, NULL, NULL, 'Shadow Pond Woodbury', 'Pond', 44.4653327, -72.4137185, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHAFTSBURY', 'Shaftsbury Lake', 'Shaftsbury', 'Green Mtn South', 27, 2311, 848, 7, NULL, 'ARTIFICIAL', 'Shaftsbury Lake Shaftsbury', 'Reservoir', 43.02, -73.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHARON-E', 'Unnamed Pond referred to by DEC as Sharon - E', 'Sharon', 'East Central', 8, 304, 1370, NULL, NULL, NULL, 'Sharon - E Pond Sharon', 'Pond', 43.78, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHAWVILLE', 'Unnamed Pond referred to by DEC as Shawville', 'Highgate', 'Champlain ', 11, 288, 580, NULL, NULL, NULL, 'Shawville Pond Highgate', 'Pond', 44.93, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHELBURNE', 'Shelburne Pond', 'Shelburne', 'Champlain ', 452, 4922, 332, 25, 11, 'NATURAL', 'Shelburne Pond Shelburne', 'Pond', 44.3867182, -73.1606809, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHELDON', 'Unnamed Pond referred to by DEC as Sheldon', 'Fair Haven', 'West Central', 2, 124, 717, NULL, NULL, NULL, 'Sheldon Pond Fair Haven', 'Pond', 43.67, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHERMAN', 'Sherman Reservoir', 'Whitingham', 'Green Mtn South', 160, 143000, 1102, NULL, NULL, 'ARTIFICIAL', 'Sherman Reservoir Whitingham', 'Reservoir', 42.73, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SHIPPEE', 'Shippee Pond', 'Whitingham', 'Green Mtn South', 24, 366, 1692, 6, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Shippee Pond Whitingham', 'Lake (Artificial Control)', 42.7467495, -72.8348185, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SILVER (BARNRD)', 'Silver Lake', 'Barnard', 'West Central', 84, 1091, 1307, 32, 16, 'NATURAL with ARTIFICIAL CONTROL', 'Silver Lake Barnard', 'Lake (Artificial Control)', 43.7297902, -72.6106541, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SILVER (GEORGA)', 'Silver Lake', 'Georgia', 'Champlain ', 27, 127, 783, 30, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Silver Lake Georgia', 'Lake (Artificial Control)', 44.72, -73.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SILVER (LEICTR)', 'Silver Lake', 'Leicester', 'West Central', 101, 413, 1250, 70, 29, 'ARTIFICIAL', 'Silver Lake Leicester', 'Reservoir', 43.88, -73.05, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SIMONDS', 'Simonds Reservoir', 'Hartford', 'East Central', 1, 504, 710, NULL, NULL, NULL, 'Simonds Reservoir Hartford', 'Reservoir', 43.63, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SIMPSONVILLE', 'Unnamed Pond referred to by DEC as Simpsonville', 'Townshend', 'Green Mtn South', 12, 433, 990, NULL, NULL, NULL, 'Simpsonville Pond Townshend', 'Pond', 43.07, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SKYLIGHT', 'Skylight Pond', 'Ripton', 'West Central', 2, 17, 3350, NULL, NULL, 'NATURAL', 'Skylight Pond Ripton', 'Pond', 43.9867293, -72.9351127, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SLAYTON (WOODBY)', 'Slayton Pond', 'Woodbury', 'North Central', 8, 166, 1470, NULL, NULL, NULL, 'Slayton Pond Woodbury', 'Pond', 44.4400553, -72.472331, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SMITH (COVNTY)', 'Smith Pond (Sargent Pond)', 'Coventry', 'NE Kingdom', 8, 141, 974, NULL, NULL, NULL, 'Smith Pond Coventry', 'Pond', 44.92, -72.28, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SMITH (PITTFD)', 'Smith Pond', 'Pittsford', 'West Central', 6, 57, 370, NULL, NULL, NULL, 'Smith Pond Pittsford', 'Pond', 43.7186767, -73.06261, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SMITH (WOODBY)', 'Smith Pond', 'Woodbury', 'North Central', 4, 90, 1170, NULL, NULL, NULL, 'Smith Pond Woodbury', 'Pond', 44.4295, -72.4642749, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SODOM', 'Sodom Pond', 'East Montpelier', 'North Central', 21, 1850, 1058, 5, NULL, 'NATURAL', 'Sodom Pond East Montpelier', 'Pond', 44.3256137, -72.4998296, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOMERSET', 'Somerset Reservoir', 'Somerset', 'Green Mtn South', 1568, 16313, 2134, 85, 24, 'ARTIFICIAL', 'Somerset Reservoir Somerset', 'Reservoir', 43.009708, -72.952621, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOMERSET-N', 'Unnamed Pond referred to by DEC as Somerset - N', 'Somerset', 'Green Mtn South', NULL, NULL, 2155, NULL, NULL, NULL, 'Somerset - N Pond Somerset', 'Pond', 43.02, -72.97, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOMERSET-W', 'Unnamed Pond referred to by DEC as Somerset - W', 'Somerset', 'Green Mtn South', NULL, NULL, 2130, NULL, NULL, NULL, 'Somerset - W Pond Somerset', 'Pond', 43, -72.95, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH (BRKFLD)', 'South Pond', 'Brookfield', 'East Central', 16, 365, 1423, 10, NULL, 'NATURAL', 'South Pond Brookfield', 'Pond', 44.0414527, -72.6214946, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH (CHITDN)', 'South Pond', 'Chittenden', 'West Central', 10, 254, 2266, NULL, NULL, NULL, 'South Pond Chittenden', 'Pond', 43.7159001, -72.8751057, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH (EDEN)', 'South Pond', 'Eden', 'North Central', 103, 1382, 1196, 66, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'South Pond Eden', 'Lake (Artificial Control)', 44.68, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH (MARLBR)', 'South Pond', 'Marlboro', 'Green Mtn South', 68, 344, 1650, 35, 15, 'NATURAL', 'South Pond Marlboro', 'Pond', 42.8445262, -72.7128712, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH AMERICA', 'South America Pond', 'Ferdinand', 'NE Kingdom', 29, 509, 1747, 4, NULL, 'NATURAL', 'South American Pond Ferdinand', 'Pond', 44.7056067, -71.7431474, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH BAY', 'South Bay', 'Newport City', 'NE Kingdom', 470, NULL, 682, NULL, NULL, NULL, 'South Bay Pond Newport City', 'Pond', 44.93, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH DOLLOFF', 'South Dolloff Pond', 'Sutton', 'NE Kingdom', 3, 768, 1450, NULL, NULL, NULL, 'South Dolloff Pond Sutton', 'Pond', 44.694218, -72.0314863, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH KING', 'South King Pond', 'Woodbury', 'North Central', 4, 58, 1190, NULL, NULL, NULL, 'South King Pond Woodbury', 'Pond', 44.42, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH LONDONDERRY', 'Unnamed Pond referred to by DEC as South Londonderry', 'Londonderry', 'Green Mtn South', NULL, NULL, 1170, NULL, NULL, NULL, 'South Londonderry Pond Londonderry', 'Pond', 43.2, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH MECAWEE', 'Unnamed Pond referred to by DEC as South Mecawee', 'Reading', 'East Central', 2, 294, 1580, NULL, NULL, 'NATURAL', 'South Mecawee Pond Reading', 'Pond', 43.53, -72.63, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH READING', 'Unnamed Pond referred to by DEC as South Reading', 'Reading', 'East Central', 12, 644, 1410, NULL, NULL, NULL, 'South Reading Pond Reading', 'Pond', 43.47, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH RICHFORD', 'Unnamed Pond referred to by DEC as South Richford', 'Richford', 'Champlain ', 12, 295, 970, NULL, NULL, NULL, 'South Richford Pond Richford', 'Pond', 44.95, -72.65, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH ST. ALBANS', 'St. Albans Reservoir, South', 'Fairfax', 'Champlain ', 27, 1346, 717, 23, 13, 'ARTIFICIAL', 'St. Albans Reservoir, South Fairfax', 'Reservoir', 44.75, -73.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH STREAM', 'South Stream Pond', 'Pownal', 'Green Mtn South', 24, 3456, 1150, NULL, NULL, 'ARTIFICIAL', 'South Stream Pond Pownal', 'Reservoir', 42.82, -73.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH VILLAGE', 'South Village Pond', 'Dorset', 'Green Mtn South', 5, 85, 750, NULL, NULL, NULL, 'South Village Pond Dorset', 'Pond', 43.2278531, -73.013159, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SOUTH WOODBURY', 'Unnamed Pond referred to by DEC as South Woodbury', 'Woodbury', 'North Central', 6, 1990, 1030, NULL, NULL, NULL, 'South Woodbury Pond Woodbury', 'Pond', 44.42, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPECTACLE', 'Spectacle Pond', 'Brighton', 'NE Kingdom', 103, 1024, 1173, 15, 8, 'NATURAL', 'Spectacle Pond Brighton', 'Pond', 44.8006048, -71.8503722, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPOONERVILLE', 'Unnamed Pond referred to by DEC as Spoonerville', 'Chester', 'East Central', 8, 154, 730, NULL, NULL, NULL, 'Spoonerville Pond Chester', 'Pond', 43.32, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPRING (BRANDN)', 'Spring Pond', 'Brandon', 'West Central', 5, 86, 490, NULL, NULL, NULL, 'Spring Pond Brandon', 'Pond', 43.8356192, -73.0637234, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPRING (SHRWBY)', 'Spring Lake (Shrewsbury Pond)', 'Shrewsbury', 'West Central', 66, 275, 1476, 84, 35, 'NATURAL', 'Spring Lake Shrewsbury', 'Lake', 43.4959033, -72.918992, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPRINGFIELD', 'Springfield Reservoir', 'Weathersfield', 'East Central', 10, 1696, 677, NULL, NULL, 'ARTIFICIAL', 'Springfield Reservoir Weathersfield', 'Reservoir', 43.35, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPRUCE (ORWELL)', 'Spruce Pond', 'Orwell', 'West Central', 25, 283, 638, 25, NULL, 'NATURAL', 'Spruce Pond Orwell', 'Pond', 43.7639512, -73.2773368, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SPRUCE (WILMTN)', 'Spruce Pond', 'Wilmington', 'Green Mtn South', 12, 987, 1645, NULL, NULL, 'ARTIFICIAL', 'Spruce Pond Wilmington', 'Reservoir', 42.85, -72.83, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ST. CATHERINE', 'Lake St. Catherine', 'Wells', 'West Central', 904, 7447, 484, 68, 37, 'NATURAL', 'Lake St. Catherine Wells', 'Lake', 43.47, -73.22, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STAMFORD', 'Stamford Pond', 'Stamford', 'Green Mtn South', 12, 260, 2370, NULL, NULL, NULL, 'Stamford Pond Stamford', 'Pond', 42.8223028, -73.0651034, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STANDING', 'Standing Pond', 'Sharon', 'East Central', 15, 76, 1326, NULL, NULL, NULL, 'Standing Pond Sharon', 'Pond', 43.8175682, -72.425373, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STANNARD', 'Stannard Pond', 'Stannard', 'North Central', 25, 125, 2310, 11, NULL, 'NATURAL', 'Stannard Pond Stannard', 'Pond', 44.5300544, -72.1653782, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STANNARD-E', 'Unnamed Pond referred to by DEC as Stannard - E', 'Stannard', 'North Central', NULL, NULL, 2220, NULL, NULL, NULL, 'Stannard - E Pond Stannard', 'Pond', 44.53, -72.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STAPLES', 'Staples Pond', 'Williamstown', 'East Central', 15, 326, 890, NULL, NULL, NULL, 'Staples Pond Williamstown', 'Pond', 44.085341, -72.5626049, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STAR', 'Star Lake', 'Mount Holly', 'West Central', 63, 709, 1851, 8, 5, 'NATURAL with ARTIFICIAL CONTROL', 'Star Lake Mount Holly', 'Lake (Artificial Control)', 43.419516, -72.8162108, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STEAM MILL', 'Unnamed Pond referred to by DEC as Steam Mill', 'Walden', 'North Central', NULL, NULL, 2195, NULL, NULL, NULL, 'Steam Mill Pond Walden', 'Pond', 44.5, -72.15, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STEARNS', 'Unnamed Pond referred to by DEC as Stearns', 'Holland', 'NE Kingdom', NULL, NULL, 1530, NULL, NULL, NULL, 'Stearns Pond Holland', 'Pond', 44.95, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STERLING', 'Sterling Pond', 'Cambridge', 'Champlain ', 8, 17, 3008, NULL, NULL, 'NATURAL', 'Sterling Pond Cambridge', 'Pond', 44.555885, -72.7742894, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STEVENS', 'Stevens Pond', 'Maidstone', 'NE Kingdom', 26, 178, 919, 9, NULL, 'ARTIFICIAL', 'Stevens Pond Maidstone', 'Reservoir', 44.5983874, -71.5706412, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STILES', 'Stiles Pond', 'Waterford', 'NE Kingdom', 135, 3884, 877, 33, 11, 'NATURAL with ARTIFICIAL CONTROL', 'Stiles Pond Waterford', 'Lake (Artificial Control)', 44.42, -71.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STILLWATER', 'Stillwater Pond', 'Charleston', 'NE Kingdom', 5, 2643, 1310, NULL, NULL, NULL, 'Stillwater Pond Charleston', 'Pond', 44.8397709, -71.9295403, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STONY', 'Unnamed Pond referred to by DEC as Stony', 'Eden', 'North Central', NULL, NULL, 1230, NULL, NULL, NULL, 'Stony Pond Eden', 'Pond', 44.7, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STOUGHTON', 'Stoughton Pond', 'Weathersfield', 'East Central', 56, 19257, 502, 20, 9, 'ARTIFICIAL', 'Stoughton Pond Weathersfield', 'Reservoir', 43.3792397, -72.4998126, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STRAFFORD', 'Unnamed Pond referred to by DEC as Strafford', 'Strafford', 'East Central', 18, 209, 1330, NULL, NULL, NULL, 'Strafford Pond Strafford', 'Pond', 43.85, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STRATTON', 'Stratton Pond', 'Stratton', 'Green Mtn South', 46, 264, 2555, 18, NULL, 'NATURAL', 'Stratton Pond Stratton', 'Pond', 43.1039661, -72.9698243, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STRATTON SKI AREA', 'Unnamed Pond referred to by DEC as Stratton Ski Area', 'Winhall', 'Green Mtn South', NULL, NULL, 1705, NULL, NULL, 'ARTIFICIAL', 'Stratton Ski Area Pond Winhall', 'Reservoir', 43.12, -72.9, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('STUART', 'Stuart Pond', 'Lyndon', 'NE Kingdom', 4, 115, 830, NULL, NULL, NULL, 'Stuart Pond Lyndon', 'Pond', 44.5061672, -72.0145404, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUGAR HILL', 'Sugar Hill Reservoir', 'Goshen', 'West Central', 63, 1667, 1768, 35, 22, 'ARTIFICIAL', 'Sugar Hill Reservoir Goshen', 'Reservoir', 43.92, -73, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUGAR HOLLOW', 'Sugar Hollow Pond', 'Pittsford', 'West Central', 21, 278, 750, 3, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Sugar Hollow Pond Pittsford', 'Lake (Artificial Control)', 43.7564542, -73.0281656, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUKES', 'Sukes Pond', 'Brighton', 'NE Kingdom', 9, 58, 1521, NULL, NULL, NULL, 'Sukes Pond Brighton', 'Pond', 44.7544943, -71.8964839, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUNRISE', 'Sunrise Lake', 'Benson', 'West Central', 57, 1775, 496, 43, 26, 'NATURAL with ARTIFICIAL CONTROL', 'Sunrise Lake Benson', 'Lake (Artificial Control)', 43.77, -73.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUNSET (BENSON)', 'Sunset Lake', 'Benson', 'West Central', 202, 1192, 497, 118, 50, 'NATURAL with ARTIFICIAL CONTROL', 'Sunset Lake Benson', 'Lake (Artificial Control)', 43.7564513, -73.2709476, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUNSET (BRKFLD)', 'Sunset Lake', 'Brookfield', 'East Central', 25, 2664, 1272, 32, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Sunset Lake Brookfield', 'Lake (Artificial Control)', 44.03, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SUNSET (MARLBR)', 'Sunset Lake', 'Marlboro', 'Green Mtn South', 96, 507, 1370, 35, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Sunset Lake Marlboro', 'Lake (Artificial Control)', 42.92, -72.68, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SWAMP', 'Swamp Pond', 'Leicester', 'West Central', 5, 29, 350, NULL, NULL, NULL, 'Swamp Pond Leicester', 'Pond', 43.8545066, -73.1478918, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SWEENEY', 'Sweeney Pond', 'Glover', 'North Central', 9, 70, 1950, NULL, NULL, NULL, 'Sweeney Pond Glover', 'Pond', 44.6953279, -72.2767709, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('SWEET', 'Sweet Pond', 'Guilford', 'Green Mtn South', 20, 682, 970, 11, NULL, 'ARTIFICIAL', 'Sweet Pond Guilford', 'Reservoir', 42.7539718, -72.6353693, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TABER', 'Unnamed Pond referred to by DEC as Taber', 'Stowe', 'North Central', NULL, NULL, 2290, NULL, NULL, NULL, 'Taber Pond Stowe', 'Pond', 44.45, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TABOR', 'Tabor Pond', 'Calais', 'North Central', 5, 6, 1170, NULL, NULL, NULL, 'Tabor Pond Calais', 'Pond', 44.3883899, -72.4784412, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TAMARACK', 'Unnamed Pond referred to by DEC as Tamarack', 'Wolcott', 'North Central', NULL, NULL, 1210, NULL, NULL, NULL, 'Tamarack Pond Wolcott', 'Pond', 44.57, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TELEPHONE', 'Unnamed Pond referred to by DEC as Telephone', 'Chester', 'East Central', 15, 349, 850, NULL, NULL, NULL, 'Telephone Pond Chester', 'Pond', 43.27, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TENNY', 'Tenny Pond (Hanson Pond)', 'Newbury', 'East Central', 10, 144, 1130, NULL, NULL, NULL, 'Tenny Pond Newbury', 'Pond', 44.17, -72.12, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('THE FISH', 'The Fish Pond', 'Newbury', 'East Central', 6, 380, 590, NULL, NULL, NULL, 'The Fish Pond Newbury', 'Pond', 44.08, -72.07, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('THE POGUE', 'The Pogue', 'Woodstock', 'East Central', 11, 80, 1150, NULL, NULL, NULL, 'The Pogue Pond Woodstock', 'Pond', 43.63, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('THOMPSONBURG', 'Unnamed Pond referred to by DEC as Thompsonburg', 'Londonderry', 'Green Mtn South', NULL, NULL, 1310, NULL, NULL, NULL, 'Thompsonburg Pond Londonderry', 'Pond', 43.2, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('THOMPSONS', 'Thompsons Pond', 'Pownal', 'Green Mtn South', 28, 548, 1406, 8, NULL, 'ARTIFICIAL', 'Thompsons Pond Pownal', 'Reservoir', 42.78, -73.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('THURMAN W. DIX', 'Thurman W. Dix Reservoir', 'Orange', 'North Central', 123, 5985, 1276, 24, 11, 'NATURAL with ARTIFICIAL CONTROL', 'Thurman W. Dix Reservoir Orange', 'Lake (Artificial Control)', 44.18, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TICKLENAKED', 'Ticklenaked Pond', 'Ryegate', 'North Central', 54, 1444, 885, 51, 16, 'NATURAL with ARTIFICIAL CONTROL', 'Ticklenaked Pond Ryegate', 'Lake (Artificial Control)', 44.1892294, -72.0987041, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TILDYS', 'Tildys Pond (Clark Pond)', 'Glover', 'North Central', 33, 1078, 1233, 24, 13, 'NATURAL', 'Tildys Pond Glover', 'Pond', 44.65, -72.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TIMBER RIDGE', 'Unnamed Pond referred to by DEC as Timber Ridge', 'Windham', 'Green Mtn South', NULL, NULL, 1920, NULL, NULL, NULL, 'Timber Ridge Pond Windham', 'Pond', 43.18, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TINY', 'Tiny Pond', 'Ludlow', 'Green Mtn South', 29, 616, 1758, 17, NULL, 'NATURAL', 'Tiny Pond Ludlow', 'Pond', 43.4603488, -72.724542, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TOAD (CHARTN)', 'Toad Pond', 'Charleston', 'NE Kingdom', 22, 2166, 1146, 4, NULL, 'NATURAL', 'Toad Pond Charleston', 'Pond', 44.8489373, -72.0475981, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TOAD (MORGAN)', 'Toad Pond', 'Morgan', 'NE Kingdom', 12, 576, 1810, NULL, NULL, NULL, 'Toad Pond Morgan', 'Pond', 44.9206031, -71.9400961, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TOWNSHEND', 'Townshend Reservoir', 'Townshend', 'Green Mtn South', 108, 177920, 478, NULL, NULL, 'ARTIFICIAL', 'Townshend Reservoir Townshend', 'Reservoir', 43.05, -72.7, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TRACER', 'Unnamed Pond referred to by DEC as Tracer', 'Reading', 'East Central', NULL, NULL, 1730, NULL, NULL, NULL, 'Tracer Pond Reading', 'Pond', 43.47, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TROUT BROOK', 'Unnamed Pond referred to by DEC as Trout Brook', 'Berkshire', 'Champlain ', 5, 1134, 490, NULL, NULL, NULL, 'Trout Brook Pond Berkshire', 'Pond', 44.93, -72.78, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TROY', 'Unnamed Pond referred to by DEC as Troy', 'Troy', 'NE Kingdom', NULL, NULL, 690, NULL, NULL, NULL, 'Troy Pond Troy', 'Pond', 44.98, -72.4, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TULIP', 'Unnamed Pond referred to by DEC as Tulip', 'Whitingham', 'Green Mtn South', NULL, NULL, 1780, NULL, NULL, NULL, 'Tulip Pond Whitingham', 'Pond', 42.83, -72.83, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TUNBRIDGE TROUT', 'Tunbridge Trout Pond', 'Tunbridge', 'East Central', 5, 229, 1370, NULL, NULL, NULL, 'Tunbridge Trout Pond Tunbridge', 'Pond', 43.8584008, -72.456208, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TURTLE', 'Turtle Pond', 'Holland', 'NE Kingdom', 27, 1228, 1438, 34, NULL, 'NATURAL', 'Turtle Pond Holland', 'Pond', 44.9933797, -71.9198182, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TURTLEHEAD', 'Turtlehead Pond', 'Marshfield', 'North Central', 69, 3707, 1279, 18, 7, 'NATURAL with ARTIFICIAL CONTROL', 'Turtlehead Pond Marshfield', 'Lake (Artificial Control)', 44.3258919, -72.330657, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TUTTLE (BRUNWK)', 'Tuttle Pond', 'Brunswick', 'NE Kingdom', 14, 176, 994, NULL, NULL, NULL, 'Tuttle Pond Brunswick', 'Pond', 44.7064397, -71.6270329, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TUTTLE (HARDWK)', 'Tuttle Pond', 'Hardwick', 'North Central', 21, 342, 1410, 6, NULL, 'NATURAL', 'Tuttle Pond Hardwick', 'Pond', 44.5581086, -72.310105, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('TWIN', 'Twin Ponds', 'Brookfield', 'East Central', 16, 438, 1208, NULL, NULL, NULL, 'Twin Ponds Brookfield', 'Pond', 44.0611747, -72.5795493, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UNDERPASS', 'Underpass Pond', 'Morgan', 'NE Kingdom', 3, 314, 1270, NULL, NULL, NULL, 'Underpass Pond Morgan', 'Pond', 44.8692149, -71.9020399, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UNION', 'Unnamed Pond referred to by DEC as Union', 'Northfield', 'East Central', NULL, NULL, 1430, NULL, NULL, NULL, 'Union Pond Northfield', 'Pond', 44.18, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UNKNOWN (AVYGOR)', 'Unknown Pond', 'Avery''s Gore', 'NE Kingdom', 19, 296, 2330, NULL, NULL, 'NATURAL', 'Unknown Pond Avery''s Gore', 'Pond', 44.9106032, -71.8428726, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UNKNOWN (FERDND)', 'Unknown Pond', 'Ferdinand', 'NE Kingdom', 12, 186, 1667, NULL, NULL, NULL, 'Unknown Pond Ferdinand', 'Pond', 44.6650522, -71.7214797, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER DANVILLE', 'Unnamed Pond referred to by DEC as Upper Danville', 'Danville', 'North Central', 19, 252, 1960, NULL, NULL, NULL, 'Upper Danville Pond Danville', 'Pond', 44.43, -72.18, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER FRYING PAN', 'Unnamed Pond referred to by DEC as Upper Frying Pan', 'Eden', 'North Central', NULL, NULL, 1390, NULL, NULL, NULL, 'Upper Frying Pan Pond Eden', 'Pond', 44.73, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER HURRICANE', 'Upper Hurricane Reservoir', 'Hartford', 'East Central', 4, 76, 1090, NULL, NULL, NULL, 'Upper Hurricane Reservoir Hartford', 'Reservoir', 43.65, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER MOORE', 'Upper Moore Pond', 'Plymouth', 'West Central', 3, 203, 1530, NULL, NULL, NULL, 'Upper Moore Pond Plymouth', 'Pond', 43.52, -72.72, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER SYMES', 'Upper Symes Pond', 'Ryegate', 'North Central', 20, 2035, 910, 5, NULL, 'NATURAL', 'Upper Symes Pond Ryegate', 'Pond', 44.25, -72.12, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER WINOOSKI', 'Unnamed Pond referred to by DEC as Upper Winooski', 'Winooski', 'Champlain ', 10, 176, 290, NULL, NULL, NULL, 'Upper Winooski Pond Winooski', 'Pond', 44.5, -73.17, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('UPPER WORCESTER', 'Worcester Pond - Upper', 'Worcester', 'North Central', 11, 581, 1090, NULL, NULL, NULL, 'Worcester Pond - Upper Worcester', 'Pond', 44.4053338, -72.5306657, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VAIL', 'Vail Pond', 'Sutton', 'NE Kingdom', 16, 142, 1493, NULL, NULL, NULL, 'Vail Pond Sutton', 'Pond', 44.7053286, -72.073432, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VALLEY', 'Valley Lake (Dog Pond)', 'Woodbury', 'North Central', 88, 472, 1207, 70, 24, 'NATURAL with ARTIFICIAL CONTROL', 'Valley Lake Woodbury', 'Lake (Artificial Control)', 44.447, -72.441, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VERGENNES WATERSHED', 'Vergennes Watershed', 'Bristol', 'Champlain ', 15, 101, 381, NULL, NULL, NULL, 'Vergennes Watershed Pond Bristol', 'Pond', 44.15, -73.13, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VERNON HATCHERY', 'Unnamed Pond referred to by DEC as Vernon Hatchery', 'Vernon', 'Green Mtn South', 10, NULL, 300, NULL, NULL, NULL, 'Vernon Hatchery Pond Vernon', 'Pond', 42.75, -72.5, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VERSHIRE-E', 'Unnamed Pond referred to by DEC as Vershire - E', 'Vershire', 'East Central', 10, 608, 1130, NULL, NULL, NULL, 'Vershire - E Pond Vershire', 'Pond', 43.97, -72.25, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VIEW', 'View Pond', 'Woodstock', 'East Central', 4, 216, 990, NULL, NULL, NULL, 'View Pond Woodstock', 'Pond', 43.6014586, -72.5228716, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('VONDELL', 'Vondell Reservoir', 'Woodstock', 'East Central', 10, 405, 1130, NULL, NULL, 'ARTIFICIAL', 'Vondell Reservoir Woodstock', 'Reservoir', 43.63, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WAITS', 'Unnamed Pond referred to by DEC as Waits', 'Topsham', 'North Central', 6, 660, 1110, NULL, NULL, NULL, 'Waits Pond Topsham', 'Pond', 44.08, -72.3, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALDEN-S', 'Unnamed Pond referred to by DEC as Walden - S', 'Walden', 'North Central', 8, 90, 1550, NULL, NULL, NULL, 'Walden - S Pond Walden', 'Pond', 44.43, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALKER (COVNTY)', 'Walker Pond', 'Coventry', 'NE Kingdom', 18, 204, 973, 9, NULL, 'NATURAL', 'Walker Pond Coventry', 'Pond', 44.93, -72.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALKER (HUBDTN)', 'Walker Pond', 'Hubbardton', 'West Central', 13, 312, 1050, NULL, NULL, NULL, 'Walker Pond Hubbardton', 'Pond', 43.7425642, -73.140945, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALKER (NEWARK)', 'Walker Pond', 'Newark', 'NE Kingdom', 3, 45, 1750, NULL, NULL, NULL, 'Walker Pond Newark', 'Pond', 44.7408835, -71.9170398, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALLACE', 'Wallace Pond', 'Canaan', 'NE Kingdom', 532, 19382, 1317, 62, 27, 'NATURAL with ARTIFICIAL CONTROL', 'Wallace Pond Canaan', 'Lake (Artificial Control)', 45.0119905, -71.6256445, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALLINGFORD', 'Wallingford Pond', 'Wallingford', 'West Central', 87, 1470, 2165, 28, 7, 'NATURAL', 'Wallingford Pond Wallingford', 'Pond', 43.4145161, -72.9095466, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WALTON', 'Walton Pond', 'Woodbury', 'North Central', 13, 128, 1312, NULL, NULL, NULL, 'Walton Pond Woodbury', 'Pond', 44.4450553, -72.4303852, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WANTASTIQUET', 'Wantastiquet Pond', 'Weston', 'West Central', 44, 1201, 1770, 14, NULL, 'ARTIFICIAL', 'Wantastiquet Pond Weston', 'Reservoir', 43.3, -72.82, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WAPANACKI', 'Wapanacki Lake', 'Wolcott', 'North Central', 21, 285, 1270, 23, NULL, 'ARTIFICIAL', 'Wapanacki Lake Wolcott', 'Reservoir', 44.5589417, -72.4006633, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WARDEN', 'Warden Pond', 'Barnet', 'North Central', 46, 1085, 993, 68, 30, 'NATURAL', 'Warden Pond Barnet', 'Pond', 44.3300597, -72.0781505, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WARNER', 'Unnamed Pond referred to by DEC as Warner', 'Jay', 'NE Kingdom', NULL, NULL, 975, NULL, NULL, NULL, 'Warner Pond Jay', 'Pond', 44.98, -72.43, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WATERBURY', 'Waterbury Reservoir', 'Waterbury', 'North Central', 839, 69760, 592, 100, NULL, 'ARTIFICIAL', 'Waterbury Reservoir Waterbury', 'Reservoir', 44.38, -72.77, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WATERFORD-E', 'Unnamed Pond referred to by DEC as Waterford - E', 'Waterford', 'NE Kingdom', 5, 195, 970, NULL, NULL, NULL, 'Waterford - E Pond Waterford', 'Pond', 44.4, -71.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WATSON', 'Watson Pond', 'Calais', 'North Central', 11, 102, 1190, NULL, NULL, NULL, 'Watson Pond Calais', 'Pond', 43.0748013, -72.5081447, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEATHERHEAD HOLLOW', 'Weatherhead Hollow', 'Guilford', 'Green Mtn South', 33, 620, 711, 10, 5, 'ARTIFICIAL', 'Weatherhead Hollow Pond Guilford', 'Reservoir', 42.73, -72.62, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEATHERSFIELD', 'Unnamed Pond referred to by DEC as Weathersfield', 'Weathersfield', 'East Central', NULL, NULL, 968, NULL, NULL, NULL, 'Weathersfield Pond Weathersfield', 'Pond', 43.37, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEAVER', 'Unnamed Pond referred to by DEC as Weaver', 'Grafton', 'Green Mtn South', 12, 334, 780, NULL, NULL, NULL, 'Weaver Pond Grafton', 'Pond', 43.18, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEST FAIRLEE', 'Unnamed Pond referred to by DEC as West Fairlee', 'West Fairlee', 'East Central', 15, 5956, 690, NULL, NULL, NULL, 'West Fairlee Pond West Fairlee', 'Pond', 43.92, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEST HILL', 'West Hill Pond', 'Cabot', 'North Central', 46, 1476, 1135, 13, NULL, 'ARTIFICIAL', 'West Hill Pond Cabot', 'Reservoir', 44.4177364, -72.3429895, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEST MOUNTAIN', 'West Mountain Pond', 'Maidstone', 'NE Kingdom', 60, 2311, 1235, 12, NULL, 'NATURAL', 'West Mountain Pond Maidstone', 'Pond', 44.6892181, -71.6620338, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WEST TWIN', 'West Twin Pond', 'Athens', 'Green Mtn South', 1, 1, 1150, NULL, NULL, NULL, 'West Twin Pond Athens', 'Pond', 43.13, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WESTFORD', 'Westford Pond', 'Westford', 'Champlain ', 9, 338, 790, NULL, NULL, NULL, 'Westford Pond Westford', 'Pond', 44.5958824, -73.0648544, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WESTMINSTER-E', 'Unnamed Pond referred to by DEC as Westminster - E', 'Westminster', 'Green Mtn South', 16, 60, 233, NULL, NULL, NULL, 'Westminster - E Pond Westminster', 'Pond', 43.1, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WESTMINSTER-W', 'Unnamed Pond referred to by DEC as Westminster - W', 'Westminster', 'Green Mtn South', 8, 1121, 800, NULL, NULL, NULL, 'Westminster - W Pond Westminster', 'Pond', 43.05, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHEELER (BARTON)', 'Wheeler Pond', 'Barton', 'NE Kingdom', 15, 742, 1450, NULL, NULL, NULL, 'Wheeler Pond Barton', 'Pond', 44.7153349, -72.10115745, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHEELER (BRUNWK)', 'Wheeler Pond', 'Brunswick', 'NE Kingdom', 66, 4159, 1028, 35, 13, 'NATURAL', 'Wheeler Pond Brunswick', 'Pond', 44.708384, -71.6395333, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHEELER (WOODBY)', 'Wheeler Pond', 'Woodbury', 'North Central', 4, 64, 1230, NULL, NULL, NULL, 'Wheeler Pond Woodbury', 'Pond', 44.43, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHEELOCK', 'Wheelock Pond', 'Calais', 'North Central', 4, 128, 1230, NULL, NULL, NULL, 'Wheelock Pond Calais', 'Pond', 44.4, -72.48, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHITCOMB', 'Whitcomb Pond', 'Williamstown', 'East Central', 1, 638, 1170, NULL, NULL, NULL, 'Whitcomb Pond Williamstown', 'Pond', 44.12, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WHITEHOUSE', 'Whitehouse Pond', 'Vershire', 'East Central', 5, 29, 1590, NULL, NULL, NULL, 'Whitehouse Pond Vershire', 'Pond', 43.98, -72.37, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WILEY;', 'Unnamed Pond referred to by DEC as Wiley', 'Eden', 'North Central', NULL, NULL, 1290, NULL, NULL, NULL, 'Wiley Pond Eden', 'Pond', 44.67, -72.53, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WILLARD', 'Unnamed Pond referred to by DEC as Willard', 'Mount Tabor', 'West Central', NULL, NULL, 2120, NULL, NULL, NULL, 'Willard Pond Mount Tabor', 'Pond', 43.38, -72.92, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WILLIAMSTOWN-NE', 'Unnamed Pond referred to by DEC as Williamstown - NE', 'Williamstown', 'East Central', 7, 106, 1490, NULL, NULL, NULL, 'Williamstown - NE Pond Williamstown', 'Pond', 44.13, -72.47, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WILLOUGHBY', 'Lake Willoughby', 'Westmore', 'NE Kingdom', 1687, 12256, 1170, 308, 140, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Willoughby Westmore', 'Lake (Artificial Control)', 44.7519942, -72.0628763, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WILMOT', 'Unnamed Pond referred to by DEC as Wilmot', 'Thetford', 'East Central', NULL, NULL, 610, NULL, NULL, NULL, 'Wilmot Pond Thetford', 'Pond', 43.78, -72.23, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WINDHAM', 'Unnamed Pond referred to by DEC as Windham', 'Stratton', 'Green Mtn South', NULL, NULL, 2290, NULL, NULL, NULL, 'Windham Pond Stratton', 'Pond', 43.12, -72.93, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WINHALL', 'Unnamed Pond referred to by DEC as Winhall', 'Stratton', 'Green Mtn South', 16, 150, 2610, NULL, NULL, NULL, 'Winhall Pond Stratton', 'Pond', 43.1, -72.98, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WINONA', 'Winona Lake (Bristol Pond)', 'Bristol', 'Champlain ', 248, 2564, 467, 9, 4, 'NATURAL with ARTIFICIAL CONTROL', 'Winona Lake Bristol', 'Lake (Artificial Control)', 44.1731125, -73.0870642, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ABBEY', 'Abbey Pond', 'Ripton', 'West Central', 3, 433, 1710, NULL, NULL, 'NATURAL', 'Abbey Pond Ripton', 'Pond', 44.0336714, -73.0601163, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ABENAKI', 'Lake Abenaki', 'Thetford', 'East Central', 44, 645, 840, 11, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Lake Abenaki Thetford', 'Lake (Artificial Control)', 43.8328472, -72.2345354, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ADAM', 'Adam Pond', 'Jamaica', 'Green Mtn South', 7, 186, 900, NULL, NULL, NULL, 'Adam Pond Jamaica', 'Pond', 43.1089666, -72.7603735, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ADAMS (ENOSBG)', 'Adams Pond', 'Enosburgh', 'Champlain ', 11, 1477, 850, NULL, NULL, NULL, 'Adams Pond Enosburg', 'Pond', 44.8808804, -72.7201307, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ADAMS (WOODFD)', 'Adams Reservoir', 'Woodford', 'Green Mtn South', 21, 821, 2317, 15, 6, 'ARTIFICIAL', 'Adams Reservoir Woodford', 'Reservoir', 42.886908, -73.03933, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('AINSWORTH', 'Unnamed pond referred to by DEC as Ainsworth', 'Williamstown', 'East Central', NULL, NULL, 875, NULL, NULL, NULL, 'Ainsworth Pond Williamstown', 'Pond', 44.08, -72.57, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ALBANY-NE', 'Unnamed pond referred to by DEC as Albany-NE', 'Albany', 'North Central', NULL, NULL, 1635, NULL, NULL, NULL, 'Albany-NE Pond Albany', 'Pond', 44.75, -72.27, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ALBERT LORD', 'Unnamed pond referred to by DEC as Albert Lord', 'Cavendish', 'East Central', 7, 62, 1090, NULL, NULL, NULL, 'Albert Lord Pond Cavendish', 'Pond', 43.43, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ALDER', 'Unnamed pond referred to by DEC as Alder', 'Sunderland', 'Green Mtn South', NULL, NULL, 2458, NULL, NULL, NULL, 'Alder Pond Sunderland', 'Pond', 43.07, -73.03, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('AMES', 'Unnamed pond referred to by DEC as Ames', 'Albany', 'North Central', NULL, NULL, 1505, NULL, NULL, NULL, 'Ames Pond Albany', 'Pond', 44.7, -72.3, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('AMHERST', 'Amherst Lake', 'Plymouth', 'West Central', 81, 12204, 1071, 90, 60, 'NATURAL with ARTIFICIAL CONTROL', 'Amherst Lake Plymouth', 'Lake (Artificial Control)', 43.4856261, -72.7042639, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ANDOVER', 'Unnamed pond referred to by DEC as Andover', 'Andover', 'West Central', 11, 389, 1545, NULL, NULL, NULL, 'Andover Pond Andover', 'Pond', 43.23, -72.75, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ANNIS', 'Unnamed pond referred to by DEC as Annis', 'Barton', 'NE Kingdom', NULL, NULL, 1185, NULL, NULL, NULL, 'Annis Pond Barton', 'Pond', 44.7, -72.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ANSEL', 'Ansel Pond', 'Bethel', 'West Central', 2, 544, 810, NULL, NULL, NULL, 'Ansel Pond Bethel', 'Pond', 43.8370111, -72.6173232, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('APPALACHIAN GAP', 'Unnamed Pond referred to by DEC as Appalachian Gap Pond', 'Buel''s Gore', 'Champlain ', NULL, NULL, NULL, NULL, NULL, NULL, 'Appalachian Gap Pond Buel''s Gore', 'Pond', 44.212233, -72.934377, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ARROWHEAD MOUNTAIN', 'Arrowhead Mountain Lake', 'Milton', 'Champlain ', 760, 442880, 290, 30, 11, 'ARTIFICIAL', 'Arrowhead Mountain Lake Milton', 'Reservoir', 44.67, -73.1, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ATHENS', 'Athens Pond', 'Athens', 'Green Mtn South', 21, 356, 1180, 12, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Athens Pond Athens', 'Lake (Artificial Control)', 43.1225778, -72.6039806, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ATHENS-357', 'Unnamed pond referred to by DEC as Athens - 357', 'Athens', 'Green Mtn South', 6, 477, 1170, NULL, NULL, NULL, 'Athens - 357 Pond Athens', 'Pond', 43.12, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('AUSTIN', 'Austin Pond', 'Hubbardton', 'West Central', 28, 3137, 442, 7, NULL, 'NATURAL with ARTIFICIAL CONTROL', 'Austin Pond Hubbardton', 'Lake (Artificial Control)', 43.72, -73.2, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BABCOCK', 'Unnamed pond referred to by DEC as Babcock', 'Sharon', 'East Central', NULL, NULL, 630, NULL, NULL, NULL, 'Babcock Pond Sharon', 'Pond', 43.73, -72.45, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BACK', 'Back Pond', 'Brighton', 'NE Kingdom', 10, 2432, 1180, NULL, NULL, NULL, 'Back Pond Brighton', 'Pond', 44.8142157, -71.8678726, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BAILEY', 'Bailey Pond', 'Marshfield', 'North Central', 17, 3847, 1250, NULL, NULL, NULL, 'Bailey Pond Marshfield', 'Pond', 44.33, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BAILEYS MILLS', 'Unnamed pond referred to by DEC as Baileys Mills', 'Chester', 'East Central', 10, 103, 630, NULL, NULL, NULL, 'Baileys Mills Pond Chester', 'Pond', 43.3, -72.6, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('BAKER (BARTON)', 'Baker Pond', 'Barton', 'North Central', 51, 1439, 1152, 30, 16, 'NATURAL', 'Baker Pond Barton', 'Pond', 44.746438, -72.2348255, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LOCKWOOD', 'Lockwood Pond', 'Lowell', 'North Central', 1, 38, 2610, NULL, NULL, NULL, 'Lockwood Pond Lowell', 'Pond', 44.8, -72.55, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WOLCOTT', 'Wolcott Pond', 'Wolcott', 'North Central', 74, 920, 1196, 23, 9, 'NATURAL with ARTIFICIAL CONTROL', 'Wolcott Pond Wolcott', 'Lake (Artificial Control)', 44.56532569, -72.42045722, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WOODBURY', 'Unnamed Pond referred to by DEC as Woodbury', 'Woodbury', 'North Central', NULL, NULL, 1155, NULL, NULL, NULL, 'Woodbury Pond Woodbury', 'Pond', 44.43, -72.42, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WOODWARD', 'Woodward Reservoir', 'Plymouth', 'West Central', 106, 1878, 1343, 48, 22, 'NATURAL with ARTIFICIAL CONTROL', 'Woodward Reservoir Plymouth', 'Lake (Artificial Control)', 43.56577923, -72.75853066, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WORDEN', 'Unnamed Pond referred to by DEC as Worden', 'Marlboro', 'Green Mtn South', NULL, NULL, 1545, NULL, NULL, NULL, 'Worden Pond Malboro', 'Pond', 42.9, -72.77, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WRIGHT', 'Wright Reservoir', 'Hartford', 'East Central', 4, 53, 1047, NULL, NULL, NULL, 'Wright Reservoir Hartford', 'Reservoir', 43.65, -72.35, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('WRIGHTSVILLE', 'Wrightsville Reservoir', 'East Montpelier', 'North Central', 190, 44008, 620, 19, NULL, 'ARTIFICIAL', 'Wrightsville Reservoir East Montpelier', 'Reservoir', 44.32345335, -72.57340942, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('YAW', 'Yaw Pond', 'Readsboro', 'Green Mtn South', 2, 2007, 2010, NULL, NULL, NULL, 'Yaw Pond Readsboro', 'Pond', 42.8470252, -73.0131576, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ZACK WOODS', 'Zack Woods Pond', 'Hyde Park', 'North Central', 23, 36, 1179, 55, NULL, 'NATURAL', 'Zack Woods Pond Hyde Park', 'Pond', 44.6106072, -72.5012221, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('LITTLE SALEM', 'Lake Salem', 'Derby', 'NE Kingdom', 50, 84133, 963, 70, 20, 'NATURAL', 'Lake Salem Derby', 'Lake', 44.915, -72.091, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('HAPPENSTANCE', NULL, 'Goshen', 'West Central', 12, NULL, 1640, NULL, NULL, NULL, 'Happenstance Farm Pond', 'Pond', 44.8899, -73.0091, NULL, NULL);
INSERT INTO public.vt_water_body VALUES ('ADAMANT', NULL, 'Calais', 'North Central', 20, NULL, NULL, NULL, NULL, NULL, 'Adamant Pond', 'Pond', 44.334050, -72.502490, NULL, NULL);


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 212
-- Name: loonwatch_event_lweventid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loonwatch_event_lweventid_seq', 1, true);


--
-- TOC entry 3781 (class 2606 OID 92562)
-- Name: vt_loon_locations loon_location_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_loon_locations
    ADD CONSTRAINT loon_location_unique UNIQUE (locationname);


--
-- TOC entry 3793 (class 2606 OID 92516)
-- Name: loonwatch_event lw_event_primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_event
    ADD CONSTRAINT lw_event_primary_key PRIMARY KEY (lweventid);


--
-- TOC entry 3797 (class 2606 OID 92544)
-- Name: loonwatch_observation lw_event_unique_time_counts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_observation
    ADD CONSTRAINT lw_event_unique_time_counts UNIQUE (lwobseventid, lwobstime, lwobsadult, lwobssubadult, lwobschick);


--
-- TOC entry 3795 (class 2606 OID 92518)
-- Name: loonwatch_event lw_event_unique_wbid_date_time_observer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_event
    ADD CONSTRAINT lw_event_unique_wbid_date_time_observer UNIQUE (lweventwaterbodyid, lweventdate, lweventstart, lweventobserveremail);


--
-- TOC entry 3799 (class 2606 OID 92719)
-- Name: loonwatch_ingest lw_ingest_unique_location_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_ingest
    ADD CONSTRAINT lw_ingest_unique_location_date UNIQUE (lwingestlocation, lwingestdate);


--
-- TOC entry 3785 (class 2606 OID 90755)
-- Name: vt_county vt_county_govCountyId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_county
    ADD CONSTRAINT "vt_county_govCountyId_key" UNIQUE ("govCountyId");


--
-- TOC entry 3787 (class 2606 OID 90757)
-- Name: vt_county vt_county_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_county
    ADD CONSTRAINT vt_county_pkey PRIMARY KEY ("countyId");


--
-- TOC entry 3789 (class 2606 OID 90773)
-- Name: vt_town vt_town_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_town
    ADD CONSTRAINT vt_town_pkey PRIMARY KEY ("townId");


--
-- TOC entry 3783 (class 2606 OID 90734)
-- Name: vt_water_body vt_water_bodies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_water_body
    ADD CONSTRAINT vt_water_bodies_pkey PRIMARY KEY (wbtextid);


--
-- TOC entry 3802 (class 2606 OID 90774)
-- Name: vt_town fk_gov_county_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_town
    ADD CONSTRAINT fk_gov_county_id FOREIGN KEY ("townCountyId") REFERENCES public.vt_county("govCountyId");


--
-- TOC entry 3806 (class 2606 OID 92720)
-- Name: loonwatch_ingest fk_location; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_ingest
    ADD CONSTRAINT fk_location FOREIGN KEY (lwingestlocation) REFERENCES public.vt_loon_locations(locationname);


--
-- TOC entry 3801 (class 2606 OID 90784)
-- Name: vt_loon_locations fk_loon_location_town_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_loon_locations
    ADD CONSTRAINT fk_loon_location_town_id FOREIGN KEY (locationtownid) REFERENCES public.vt_town("townId");


--
-- TOC entry 3805 (class 2606 OID 92538)
-- Name: loonwatch_observation fk_lw_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_observation
    ADD CONSTRAINT fk_lw_event_id FOREIGN KEY (lwobseventid) REFERENCES public.loonwatch_event(lweventid);


--
-- TOC entry 3804 (class 2606 OID 92524)
-- Name: loonwatch_event fk_town_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_event
    ADD CONSTRAINT fk_town_id FOREIGN KEY (lweventtownid) REFERENCES public.vt_town("townId");


--
-- TOC entry 3803 (class 2606 OID 92519)
-- Name: loonwatch_event fk_water_body_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loonwatch_event
    ADD CONSTRAINT fk_water_body_id FOREIGN KEY (lweventwaterbodyid) REFERENCES public.vt_water_body(wbtextid);


--
-- TOC entry 3800 (class 2606 OID 90736)
-- Name: vt_loon_locations fk_waterbody_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vt_loon_locations
    ADD CONSTRAINT fk_waterbody_id FOREIGN KEY (waterbodyid) REFERENCES public.vt_water_body(wbtextid);


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 3957
-- Name: DATABASE loonweb; Type: ACL; Schema: -; Owner: postgres
--

GRANT CONNECT ON DATABASE loonweb TO ipt;


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA public TO ipt;


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE loonwatch_sampling_event; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.loonwatch_sampling_event TO ipt;


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE loonwatch_sampling_occurrence; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.loonwatch_sampling_occurrence TO ipt;


-- Completed on 2023-09-20 13:34:13

--
-- PostgreSQL database dump complete
--

