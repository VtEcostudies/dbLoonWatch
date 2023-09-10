--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

-- Started on 2023-09-08 11:33:42

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 257 (class 1259 OID 19780)
-- Name: vt_county; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vt_county (
    "countyId" integer NOT NULL,
    "govCountyId" integer,
    "countyName" character varying(50) NOT NULL
);


--
-- TOC entry 4103 (class 0 OID 19780)
-- Dependencies: 257
-- Data for Name: vt_county; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (0, 0, 'Unknown');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (1, 19, 'Orleans');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (2, 13, 'Grand Isle');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (3, 7, 'Chittenden');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (4, 27, 'Windsor');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (5, 25, 'Windham');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (6, 3, 'Bennington');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (7, 11, 'Franklin');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (8, 9, 'Essex');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (9, 15, 'Lamoille');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (10, 5, 'Caledonia');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (11, 17, 'Orange');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (12, 23, 'Washington');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (13, 21, 'Rutland');
INSERT INTO public.vt_county ("countyId", "govCountyId", "countyName") VALUES (14, 1, 'Addison');


--
-- TOC entry 3959 (class 2606 OID 20298)
-- Name: vt_county vt_county_govCountyId_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vt_county
    ADD CONSTRAINT "vt_county_govCountyId_key" UNIQUE ("govCountyId");


--
-- TOC entry 3961 (class 2606 OID 20300)
-- Name: vt_county vt_county_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vt_county
    ADD CONSTRAINT vt_county_pkey PRIMARY KEY ("countyId");


-- Completed on 2023-09-08 11:33:42

--
-- PostgreSQL database dump complete
--

