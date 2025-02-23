--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-02-23 07:08:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 222 (class 1259 OID 24722)
-- Name: estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudio (
    studyid integer NOT NULL,
    uniid integer,
    estudios_realizados character varying(255)
);


ALTER TABLE public.estudio OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24721)
-- Name: estudio_studyid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estudio_studyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estudio_studyid_seq OWNER TO postgres;

--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 221
-- Name: estudio_studyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estudio_studyid_seq OWNED BY public.estudio.studyid;


--
-- TOC entry 218 (class 1259 OID 24708)
-- Name: habilidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidades (
    habilidadid integer NOT NULL,
    habilidad character varying(100)
);


ALTER TABLE public.habilidades OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24707)
-- Name: habilidades_habilidadid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.habilidades_habilidadid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habilidades_habilidadid_seq OWNER TO postgres;

--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 217
-- Name: habilidades_habilidadid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.habilidades_habilidadid_seq OWNED BY public.habilidades.habilidadid;


--
-- TOC entry 220 (class 1259 OID 24715)
-- Name: universidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universidad (
    "UniID" smallint NOT NULL,
    "UniNombre" character varying(100),
    "Ciudad" character varying(100)
);


ALTER TABLE public.universidad OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24714)
-- Name: universidad_uniid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universidad_uniid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universidad_uniid_seq OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 219
-- Name: universidad_uniid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universidad_uniid_seq OWNED BY public.universidad."UniID";


--
-- TOC entry 223 (class 1259 OID 24795)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    dni character varying(9) NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    estudios integer,
    habilidad integer,
    correo character varying(255),
    telefono integer
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 4753 (class 2604 OID 24725)
-- Name: estudio studyid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio ALTER COLUMN studyid SET DEFAULT nextval('public.estudio_studyid_seq'::regclass);


--
-- TOC entry 4752 (class 2604 OID 24711)
-- Name: habilidades habilidadid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidades ALTER COLUMN habilidadid SET DEFAULT nextval('public.habilidades_habilidadid_seq'::regclass);


--
-- TOC entry 4913 (class 0 OID 24722)
-- Dependencies: 222
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudio (studyid, uniid, estudios_realizados) FROM stdin;
1	6	Universidad Autónoma de Madrid
2	7	Universidad Politécnica de Valencia
3	4	Universidad de Salamanca (USAL)
4	6	Universidad Complutense de Madrid
5	6	Universidad de Sevilla
6	4	Universidad de Zaragoza
7	9	Universidad de Valencia
8	2	Universidad de Granada
9	5	Universidad de Navarra
10	3	Universidad de Barcelona
\.


--
-- TOC entry 4909 (class 0 OID 24708)
-- Dependencies: 218
-- Data for Name: habilidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habilidades (habilidadid, habilidad) FROM stdin;
1	Desarrollador Software
2	Programador Fullstack
3	Jefe de Ingenieria Software
4	Ingeniero de Datos
5	Desarrollo web
6	Ciberseguridad
7	Mantenimiento de Computadores
8	Inteligencia Artificial
9	Desarrollo de Aplicaciones Móviles
10	Computación en la Nube
11	Programación en Python
\.


--
-- TOC entry 4911 (class 0 OID 24715)
-- Dependencies: 220
-- Data for Name: universidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universidad ("UniID", "UniNombre", "Ciudad") FROM stdin;
1	Maddox, Gordon and Navarro	Suarezstad
2	Young-Pratt	West Brett
3	Delacruz-King	Johnsonberg
4	Wise-Dodson	New Jennifer
5	Powell and Sons	Matthewtown
6	Mcdonald-Martinez	New Denisefurt
7	Odom PLC	Port Connie
8	Patterson-Jones	Port Tinaside
9	Jefferson, Lee and Ramirez	Meganside
10	Chang Group	Hayeston
\.


--
-- TOC entry 4914 (class 0 OID 24795)
-- Dependencies: 223
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (dni, nombre, apellido, "contraseña", estudios, habilidad, correo, telefono) FROM stdin;
00000000X	admin	admin	$2b$12$a2QwwFk5bg03jFBxKJX0iOuFD6z0dlrKEJ34ufZINk1flgt5O.IRK	10	10	admin@empresa.com	600000000
22042053A	Bailey	Barrett	$2b$12$sZXowNQC3RRBtsqNGnF2sefphz76xg7RzsZrHanhbfsddqc9YRJXG	4	8	bailey.barrett@empresa.com	600000001
39920263Z	Paul	Edwards	$2b$12$u9gVcrMxnYbkKoZneSl7..3b1m2lmacgXwTGWdIfPgPdu0aBGiyxa	9	2	paul.edwards@empresa.com	600000002
46831776G	Brad	Diaz	$2b$12$KtiVy4iTyT4oaCZ6RYYRSeAIh4EFeQ7hrHhvTAJ/rZqqGNWm2Kh4K	9	5	brad.diaz@empresa.com	600000003
22944171S	Karen	Carroll	$2b$12$OgbExJPmxjQAU3voH60yeOvkb6xdTnxvMypz93fUkeSWB3TfIlGaC	4	7	karen.carroll@empresa.com	600000004
79764366K	Marcus	Martin	$2b$12$bpuccNQ/BQEsjHdzLIFUE.5BeHSEx0XouRl2bExwlUkhmP0GtUrri	2	9	marcus.martin@empresa.com	600000005
89237134D	Hunter	Murphy	$2b$12$59uBgua8Jj/R7NkUQbhHpu0RwVvAy0Bwret/ANDx8gJzzv7b7kvT.	9	6	hunter.murphy@empresa.com	600000006
87712776E	Amy	Henry	$2b$12$oqrSf8jEUyPoJtpOkzizUe4Qt8fL9TqaTCLkFwO.1fRh/O0SR5clq	8	1	amy.henry@empresa.com	600000007
60029251X	Daniel	Tapia	$2b$12$Vy3lB2.x8yWkH9CV1hZ6meUgDknSk.4hsxHzP3x/kr7pb/PM/tZo6	5	5	daniel.tapia@empresa.com	600000008
31542756G	Jody	Robinson DVM	$2b$12$5AMNs2fp6o3LF/rtP2Fmsug6VvHbDj/dKa4Om1EIG3xuMtTjKEnY2	8	7	jody.robinson dvm@empresa.com	600000009
30361037W	Jessica	Cox	$2b$12$7Oe377hrGxGgSG4i3CVEau4yC.PMJ077GevcADh2Kn47.Gm0PLFgO	10	5	jessica.cox@empresa.com	600000010
39863351G	Jorge	Brown	$2b$12$FSZ74.YEHZ6sFjiNeul3cebDHu7XVTiXeQPNPSRlXTUTuG7UTTdkG	5	6	jorge.brown@empresa.com	600000011
10294127V	Lindsey	Dickerson	$2b$12$8e283qsihlBT5cZdgjYjvumh4RWt9xCx9sRqYLE/K8aEdPwsmdDa2	2	5	lindsey.dickerson@empresa.com	600000012
54383017T	Matthew	Hill	$2b$12$LsjhS9hC86Hsx3jUzxljQul5Nbv7kfZ20zomYaG0mbWYNyLiuAm6S	9	6	matthew.hill@empresa.com	600000013
65522480B	Robert	Becker	$2b$12$PVrdxK9D2../qEBBO.1vu.RYeqDFo4hRfegDqLxqFjAHoAWIzU4am	9	2	robert.becker@empresa.com	600000014
97397701S	Stephen	Small	$2b$12$e/VbFH1wIL.VhlcS1OJVP.sQF2jyRdYEKQARzfd96Y6H3E/VPCZkS	8	1	stephen.small@empresa.com	600000015
51308807Q	Isaiah	Madden	$2b$12$pWxhWQ84iV28xRHAkcYsWe9PaTkL3EiYIML4Rzy8vIc7Vsii1FTzS	2	2	isaiah.madden@empresa.com	600000016
15690382N	Daniel	Brown	$2b$12$x8Gd7apvuMTEmXLtwdnzou7laYDgDo48n7ozy3dlK5VjArS3Aw.yy	10	10	daniel.brown@empresa.com	600000017
44228012R	Robert	Knight	$2b$12$8bjJAZkc73P20hwNo.oC7u.3x91RXMXnOoDrMXt5s/7n5x3ORCjQO	6	2	robert.knight@empresa.com	600000018
32498630K	Jacqueline	Booker	$2b$12$qEyuGWIt8mziIFAtIohvfehxJLWSQpf7seBBGX6nl6wnw1sdmZAoa	9	8	jacqueline.booker@empresa.com	600000019
56998990E	Andrew	Mejia	$2b$12$W0iOOmmPfw1KGCWszLrpvej9UALA/fULSsHseAzDO2cMjO3D2HU5O	10	4	andrew.mejia@empresa.com	600000020
41691840Q	Debra	Smith	$2b$12$rL9WUOBXKD/TlPf.dcctZu0H/cmBcM6rILnyUjm3FxRqD59D5C6q6	8	7	debra.smith@empresa.com	600000021
79482147N	Erica	Brown	$2b$12$9mQo/2RrVzZ0ilj72zC2IOxa9AtvihLW4ZEczzFhlvvziTWjAAXpW	6	1	erica.brown@empresa.com	600000022
25875840N	Eric	Wilson	$2b$12$YxW9N5//QtsF24M0032wH.G2ZajgJLQs0d5y7ENzFz9De0SriTkl6	10	3	eric.wilson@empresa.com	600000023
36429717V	Tracey	Carter	$2b$12$/C4PLgcDHZempAUlK7EdpONzenDHuUpbth0qS7EeRkaiMsZ/.flFW	6	4	tracey.carter@empresa.com	600000024
44745455J	Eddie	Thornton	$2b$12$QvYSv1nPJE//N28oRl0RwOAYqRgaJ99UtYI0eQdLt3IVIg7FPVwGC	1	1	eddie.thornton@empresa.com	600000025
74534808L	Christina	Miles	$2b$12$xtsyGX9JDduyb6cmIlKFE.jGEFUVXtxRCuGp6UIjmtYPZHm1G11me	2	7	christina.miles@empresa.com	600000026
22423842S	Carrie	Chavez	$2b$12$OoH6mYi5tLuk4rM5XuCkxe6M3OE74xX3OL6ykSzi2rKKG3UrEz7wO	7	9	carrie.chavez@empresa.com	600000027
63394524S	Andrea	Chapman	$2b$12$5uEjQLtnpl3YhrNsbwOLZ.RwCGVByxFNFPLh8nIH/wxpVgjgs8iJa	4	5	andrea.chapman@empresa.com	600000028
85964553Y	Emily	Mason	$2b$12$IcTNsiQquH6AcOjesOCJpeL7dbnPzpdlyZWyi1UJAnELoHNlC9KFu	2	5	emily.mason@empresa.com	600000029
81245383E	William	Moses	$2b$12$9eEu7cFvgnYL13BL9.Xsme0/osVfQQm7d/ZtEMyjOqLuOSlkd59W2	2	7	william.moses@empresa.com	600000030
14354130Z	Amber	Watkins	$2b$12$BBujvrF12ZRzOk67x4xm/OGejKjyKe6TSDHgwXrllz.xDGWUeQvC.	4	10	amber.watkins@empresa.com	600000031
36660962C	James	Simon	$2b$12$UnyiZ6nP0SXJ.9mAQYIwPOI.dXSgBjZfab3HsTyRlvAnLojhvH9ki	1	7	james.simon@empresa.com	600000032
72572774T	Thomas	Haas	$2b$12$RvrOOTDnWeB2JubF/SSre.hP/4/SArZvVLlL.JjxU4Lc66nggHDKK	9	7	thomas.haas@empresa.com	600000033
34104139S	Katherine	Harris	$2b$12$yQfQyceMKJtClABi.8AnYes2/FsbsFR9bRSNpCBxLRMqE.xuoLaP2	10	5	katherine.harris@empresa.com	600000034
40125970D	Marc	Ramirez	$2b$12$FNmL8mhvPNLk6Kg6b.Mwz.ycvk6Be2JolIuFVn3u/I40H0MZZR53a	2	4	marc.ramirez@empresa.com	600000035
92641477F	Tiffany	Flores MD	$2b$12$Fo7vNBr2Yk9wtHe2RXkxUOwGDWUCq9dCfq6ZDVvSfzKy/eFLl.9vW	4	3	tiffany.flores md@empresa.com	600000036
87359458F	David	Wilson	$2b$12$/e32PPyZdNnZreZgbKPZQ.H0OsDNHeZhPldx5X62cw5ULYLeGrJHO	7	10	david.wilson@empresa.com	600000037
70439679V	Erica	Austin	$2b$12$DKgcQ8OtyHO6U9ftfq2OaewBXfI.vkGyyE/Q53q0UcKZe0ctOavdG	5	5	erica.austin@empresa.com	600000038
74043393E	Jeffrey	Smith	$2b$12$kzbCrO5089gYBm/4IieKcuWAV3PoEm7eNxmLQsaQYL4yim93urKba	9	6	jeffrey.smith@empresa.com	600000039
26752739J	Benjamin	Sanchez	$2b$12$vFnQq1q.rzlsC2.YqE9tjuiurcDIaXkHQManXaegUDarsTCETd5WG	7	6	benjamin.sanchez@empresa.com	600000040
48328747C	Nichole	Brown	$2b$12$hN6lbFh8LSMow.xLBEGZ0.JOWXm1g1C.hz1uCdco13On5m77Ju.d2	7	4	nichole.brown@empresa.com	600000041
89748579A	Meghan	Klein	$2b$12$bSzJ.IgoPWkK/gM8zYMNdu2rPjrp5FOHLMI.fx5NxIW93drsZOfwi	3	4	meghan.klein@empresa.com	600000042
87219433Y	Matthew	Ramirez	$2b$12$x3jXGTBr/h/pwpSCa/PHb.2v4uj8Vzp80gDzeQ22VE5dKI4Ozecz2	10	1	matthew.ramirez@empresa.com	600000043
84613533Y	Natasha	Fowler	$2b$12$W2hddltXjWs11ezR6s9eGOu4mXTuZz75eOj/N3Rb1aETliaUl7PGO	1	10	natasha.fowler@empresa.com	600000044
36518931Z	Joshua	Dickerson	$2b$12$TQG8OFBV/qme1wv8AYYnIuWbylbgpi2suFrj.HZO2kxRF638pKbPm	8	1	joshua.dickerson@empresa.com	600000045
64389289F	Kevin	Thomas	$2b$12$PaXA4YYFYazxIQSwAmsM4OhBXNpCW.HCWvY5nghDZETD1eq7CmrrK	1	7	kevin.thomas@empresa.com	600000046
63756291S	Shawn	Hudson	$2b$12$VKTlDjsP1lcnVgBM7T886O88405Cku6FkF6loLABqvt1BUPRdQtai	5	6	shawn.hudson@empresa.com	600000047
37172435L	Wayne	Fitzgerald	$2b$12$s30UxlMHF8zzcAMbbOf0BOpUeFNBu3BS4I4/xvgEPlnbrUUH93P1S	8	10	wayne.fitzgerald@empresa.com	600000048
52107961N	Matthew	Singleton	$2b$12$R.HkXydqK5z6oNvR4bknP.FTwwa7C3R22wCcSxoCZ0sm0YSg1OoD2	9	8	matthew.singleton@empresa.com	600000049
21284126H	Daniel	Nelson	$2b$12$pmX.1MhOlOuHxDi4AVOpfu05yELW5kjX0i30jGVeUIBHFx3Ng8Kbe	3	5	daniel.nelson@empresa.com	600000050
12345678B	Juan	Antonio	$2b$12$ztwW4EjFG3FyM2OlVmCpO.Nv2Un3dBrbT3fO8zIwlRXwOJ9xwwxai	3	7	juan.antonio@email.com	605123456
\.


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 221
-- Name: estudio_studyid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estudio_studyid_seq', 1, false);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 217
-- Name: habilidades_habilidadid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.habilidades_habilidadid_seq', 1, false);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 219
-- Name: universidad_uniid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universidad_uniid_seq', 1, false);


--
-- TOC entry 4759 (class 2606 OID 24727)
-- Name: estudio estudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_pkey PRIMARY KEY (studyid);


--
-- TOC entry 4755 (class 2606 OID 24713)
-- Name: habilidades habilidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidades
    ADD CONSTRAINT habilidades_pkey PRIMARY KEY (habilidadid);


--
-- TOC entry 4757 (class 2606 OID 24775)
-- Name: universidad universidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universidad
    ADD CONSTRAINT universidad_pkey PRIMARY KEY ("UniID");


--
-- TOC entry 4761 (class 2606 OID 24801)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (dni);


--
-- TOC entry 4762 (class 2606 OID 24776)
-- Name: estudio estudio_uniid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_uniid_fkey FOREIGN KEY (uniid) REFERENCES public.universidad("UniID");


-- Completed on 2025-02-23 07:08:18

--
-- PostgreSQL database dump complete
--

