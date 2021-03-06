
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
    name VARCHAR(500),
    title VARCHAR(1000),
    alertSource VARCHAR(1000),
    rawData  TEXT,
    timestamp VARCHAR(200),
    keywords VARCHAR(500),
    locationKeywords VARCHAR(500),
    orderNr integer,
    classification VARCHAR(200),
    initialRating VARCHAR(100),
    finalRating VARCHAR(100),
    originalId integer
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
    name VARCHAR(500),
    title VARCHAR(1000),
    alertSource VARCHAR(1000),
    rawData  TEXT,
    timestamp VARCHAR(200),
    keywords VARCHAR(500),
    locationKeywords VARCHAR(500),
    orderNr integer,
    classification VARCHAR(200),
    initialRating VARCHAR(100),
    finalRating VARCHAR(100)
);


DROP TABLE public.sourceType;

CREATE TABLE public.sourceType (
    id serial primary key,
    name VARCHAR(100),
    description VARCHAR(200)
);



