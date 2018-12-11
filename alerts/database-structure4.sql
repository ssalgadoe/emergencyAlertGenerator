
DROP TABLE public.alertSource;

CREATE TABLE public.alertSource (
    id serial primary key,
    name VARCHAR(100),
    url VARCHAR(200),
    description VARCHAR(200),
    sourceTypeID integer NOT NULL,
    classificationID integer NOT NULL,
    trustLevel double precision,
    languageId integer NOT NULL
);



DROP TABLE public.classificationType;


CREATE TABLE public.classificationType (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200),
    KeywordList VARCHAR(500)
);


DROP TABLE public.filteredAlerts;

CREATE TABLE public.filteredAlerts (
    id serial primary key,
    name VARCHAR(100),
    url VARCHAR(200),
    subject VARCHAR(300),
    summary VARCHAR(500),
    alertSource VARCHAR(300),
    classificationID integer NOT NULL,
    trustLevel double precision,
    languageId integer NOT NULL,
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


DROP TABLE public.rawAlerts;

CREATE TABLE public.rawAlerts (
    id serial primary key,
    name VARCHAR(100),
    subject VARCHAR(300),
    alertSource VARCHAR(300),
    rawData  TEXT,
    timestamp VARCHAR(200),
    keywords VARCHAR(500),
    locationKeywords VARCHAR(500),
    locationID integer,
    initialRating double precision
);


DROP TABLE public.sourceType;

CREATE TABLE public.sourceType (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200)
);



