
DROP TABLE public.alertSource;

CREATE TABLE public.alertSource (
    id serial primary key,
    name VARCHAR(100),
    url VARCHAR(200),
    description VARCHAR(200),
    sourceTypeID integer NOT NULL,
    classificationID integer NOT NULL,
    trustLevel integer,
    languageId integer NOT NULL
);



DROP TABLE public.classificationType;


CREATE TABLE public.classificationType (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200),
    KeywordList VARCHAR(500)
);


DROP TABLE public.filteredAlerts

CREATE TABLE public.filteredAlerts (
    id serial primary key,
    name VARCHAR(100),
    url VARCHAR(200),
    subject VARCHAR(300),
    summary VARCHAR(500),
    sourceTypeID integer NOT NULL,
    classificationID integer NOT NULL,
    trustLevel integer,
    languageId integer NOT NULL
    timestamp VARCHAR(200),
    keywords VARCHAR(500),
    locationKeywords VARCHAR(500),
    locationID integer NOT NULL,
    finalRating double precision,
    enabled integer
);


DROP TABLE public.languageType;

CREATE TABLE public.languageType (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200)
);


DROP TABLE public.location;

CREATE TABLE public.location (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200),
    dependancyList VARCHAR(500)
);


ALTER TABLE location OWNER TO postgres;

--
-- Name: location_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "location_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "location_Id_seq" OWNER TO postgres;

--
-- Name: location_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "location_Id_seq" OWNED BY location."Id";


--
-- Name: rawAlerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "rawAlerts" (
    "Id" integer NOT NULL,
    "Name" character(100),
    "Subject" character(300),
    "AlertSourceID" integer NOT NULL,
    "RawData" character varying,
    "Timestamp" character(200),
    "Keywords" character(500),
    "LocationID" integer NOT NULL,
    "LocationKeywords" character(500),
    "InitialRating" double precision
);


ALTER TABLE "rawAlerts" OWNER TO postgres;

--
-- Name: rawAlerts_AlertSourceID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "rawAlerts_AlertSourceID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "rawAlerts_AlertSourceID_seq" OWNER TO postgres;

--
-- Name: rawAlerts_AlertSourceID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "rawAlerts_AlertSourceID_seq" OWNED BY "rawAlerts"."AlertSourceID";


--
-- Name: rawAlerts_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "rawAlerts_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "rawAlerts_Id_seq" OWNER TO postgres;

--
-- Name: rawAlerts_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "rawAlerts_Id_seq" OWNED BY "rawAlerts"."Id";


--
-- Name: rawAlerts_LocationID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "rawAlerts_LocationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "rawAlerts_LocationID_seq" OWNER TO postgres;

--
-- Name: rawAlerts_LocationID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "rawAlerts_LocationID_seq" OWNED BY "rawAlerts"."LocationID";


--
-- Name: sourceType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "sourceType" (
    "Id" integer NOT NULL,
    "Name" character(100),
    "Description" character(200)
);


ALTER TABLE "sourceType" OWNER TO postgres;

--
-- Name: sourceType_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "sourceType_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "sourceType_Id_seq" OWNER TO postgres;

--
-- Name: sourceType_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "sourceType_Id_seq" OWNED BY "sourceType"."Id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    "Id" integer NOT NULL,
    "Name" character varying
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "users_Id_seq" OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "users_Id_seq" OWNED BY users."Id";


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "alertSource" ALTER COLUMN "Id" SET DEFAULT nextval('"alertSource_Id_seq"'::regclass);


--
-- Name: SourceTypeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "alertSource" ALTER COLUMN "SourceTypeID" SET DEFAULT nextval('"alertSource_SourceTypeID_seq"'::regclass);


--
-- Name: ClassificationID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "alertSource" ALTER COLUMN "ClassificationID" SET DEFAULT nextval('"alertSource_ClassificationID_seq"'::regclass);


--
-- Name: LanguageId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "alertSource" ALTER COLUMN "LanguageId" SET DEFAULT nextval('"alertSource_LanguageId_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "classificationType" ALTER COLUMN "Id" SET DEFAULT nextval('"classificationType_Id_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts" ALTER COLUMN "Id" SET DEFAULT nextval('"filteredAlerts_Id_seq"'::regclass);


--
-- Name: SourceTypeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts" ALTER COLUMN "SourceTypeID" SET DEFAULT nextval('"filteredAlerts_SourceTypeID_seq"'::regclass);


--
-- Name: ClassificationID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts" ALTER COLUMN "ClassificationID" SET DEFAULT nextval('"filteredAlerts_ClassificationID_seq"'::regclass);


--
-- Name: LocationID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts" ALTER COLUMN "LocationID" SET DEFAULT nextval('"filteredAlerts_LocationID_seq"'::regclass);


--
-- Name: LanguageID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts" ALTER COLUMN "LanguageID" SET DEFAULT nextval('"filteredAlerts_LanguageID_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "languageType" ALTER COLUMN "Id" SET DEFAULT nextval('"languageType_Id_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location ALTER COLUMN "Id" SET DEFAULT nextval('"location_Id_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "rawAlerts" ALTER COLUMN "Id" SET DEFAULT nextval('"rawAlerts_Id_seq"'::regclass);


--
-- Name: AlertSourceID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "rawAlerts" ALTER COLUMN "AlertSourceID" SET DEFAULT nextval('"rawAlerts_AlertSourceID_seq"'::regclass);


--
-- Name: LocationID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "rawAlerts" ALTER COLUMN "LocationID" SET DEFAULT nextval('"rawAlerts_LocationID_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "sourceType" ALTER COLUMN "Id" SET DEFAULT nextval('"sourceType_Id_seq"'::regclass);


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN "Id" SET DEFAULT nextval('"users_Id_seq"'::regclass);


--
-- Name: alertSource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "alertSource"
    ADD CONSTRAINT "alertSource_pkey" PRIMARY KEY ("Id");


--
-- Name: classificationType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "classificationType"
    ADD CONSTRAINT "classificationType_pkey" PRIMARY KEY ("Id");


--
-- Name: filteredAlerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "filteredAlerts"
    ADD CONSTRAINT "filteredAlerts_pkey" PRIMARY KEY ("Id");


--
-- Name: languageType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "languageType"
    ADD CONSTRAINT "languageType_pkey" PRIMARY KEY ("Id");


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY ("Id");


--
-- Name: rawAlerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "rawAlerts"
    ADD CONSTRAINT "rawAlerts_pkey" PRIMARY KEY ("Id");


--
-- Name: sourceType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "sourceType"
    ADD CONSTRAINT "sourceType_pkey" PRIMARY KEY ("Id");


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("Id");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    "Id" integer NOT NULL,
    "Name" character varying
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "users_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "users_Id_seq" OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "users_Id_seq" OWNED BY users."Id";


--
-- Name: Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN "Id" SET DEFAULT nextval('"users_Id_seq"'::regclass);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("Id");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

