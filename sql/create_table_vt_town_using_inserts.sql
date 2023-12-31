--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

-- Started on 2023-09-08 12:05:09

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
-- TOC entry 276 (class 1259 OID 19895)
-- Name: vt_town; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vt_town (
    "townId" integer NOT NULL,
    "townName" character varying(50) NOT NULL,
    "townCountyId" integer NOT NULL,
    "townAlias" text
);


--
-- TOC entry 4102 (class 0 OID 19895)
-- Dependencies: 276
-- Data for Name: vt_town; Type: TABLE DATA; Schema: public; Owner: -
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
INSERT INTO public.vt_town VALUES (14, 'Averys Gore', 9, E'Avery\'s Gore');
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
INSERT INTO public.vt_town VALUES (151, 'Mount Holly', 21, 'Mt. Holly');
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


--
-- TOC entry 3959 (class 2606 OID 20328)
-- Name: vt_town vt_town_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vt_town
    ADD CONSTRAINT vt_town_pkey PRIMARY KEY ("townId");


--
-- TOC entry 3960 (class 2606 OID 20396)
-- Name: vt_town fk_gov_county_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vt_town
    ADD CONSTRAINT fk_gov_county_id FOREIGN KEY ("townCountyId") REFERENCES public.vt_county("govCountyId");


-- Completed on 2023-09-08 12:05:10

--
-- PostgreSQL database dump complete
--

