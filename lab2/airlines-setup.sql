-- Lab 2
-- satiwari
-- Oct 7, 2023

CREATE TABLE airlines (
    ID INTEGER NOT NULL,
    Airlines VARCHAR(100) NOT NULL,
    Abbreviation VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE airport (
    City varchar(100)NOT NULL,
    AirportCode varchar(100) not null,
    AirportName varchar(100) not null,
    country varchar(100) not null,
    CountryAbbrev varchar(100) not null,
    primary key (AirportCode)
);

ALTER TABLE airlines
CHANGE COLUMN airlines airline VARCHAR(100) not null;

ALTER TABLE airport RENAME TO airports;

CREATE TABLE flights (
    Airline integer not null,
    FlightNo integer not null,
    SourceAirport varchar(100) not null,
    DestAirport varchar(100) not null,
    Foreign key (airline) REFERENCES airlines (Id),
    foreign key (SourceAirport) REFERENCES airports (AirportCode),
    foreign key (DestAirport) REFERENCES airports (AirportCode),
    UNIQUE (Airline, FlightNo)
);

ALTER TABLE airlines
ADD CONSTRAINT unique_Abbreviation UNIQUE (Abbreviation);