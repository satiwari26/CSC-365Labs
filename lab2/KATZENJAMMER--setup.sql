-- Lab 2
-- satiwari
-- Oct 7, 2023

CREATE TABLE albums (
    AId INTEGER NOT NULL,
    title VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    label VARCHAR(100) NOT NULL,
    album_Type VARCHAR(100) NOT NULL,
    UNIQUE (AId, title),
    PRIMARY KEY (AId)
);

CREATE TABLE band (
    BId integer not null,
    FirstName varchar(100) not null,
    LastName varchar(100) not null,
    Primary key (BId)
);

CREATE TABLE songs (
    SId integer not null,
    title varchar(100) not null,
    primary key (SId),
    UNIQUE (SId, title)
);

ALTER TABLE albums RENAME TO Albums;
ALTER TABLE band RENAME TO Band;
ALTER TABLE songs RENAME TO Songs;


CREATE TABLE Instruments (
    SongId integer not null,
    BandmateId integer not null,
    Instrument varchar(100) not null,
    FOREIGN KEY (SongId) references Songs (SId),
    FOREIGN KEY (BandmateId) references Band (BId),
    primary key (SongId, Instrument),
    UNIQUE (SongId, BandmateId)
);

CREATE TABLE Performance (
    SongId integer not null,
    Bandmate integer not null,
    StagePosition varchar(100) not null,
    FOREIGN KEY (SongId) references Songs (SId),
    FOREIGN KEY (Bandmate) references Band (BId),
    primary key (SongId, StagePosition),
    UNIQUE (SongId, Bandmate)
);

ALTER TABLE Songs
CHANGE COLUMN SId SongId INTEGER not null;

ALTER TABLE Band
CHANGE COLUMN BId BandId INTEGER not null;

ALTER TABLE Albums
CHANGE COLUMN AId AlbumId INTEGER not null;

CREATE TABLE TrackLists (
    AlbumId integer not null,
    Position integer not null,
    SongId integer not null,
    FOREIGN KEY (SongId) references Songs (SongId),
    FOREIGN KEY (AlbumId) references Albums (AlbumId),
    primary key (AlbumId, SongId),
    UNIQUE (AlbumId, Position)
);

ALTER TABLE TrackLists RENAME TO Tracklists;


CREATE TABLE Vocals (
    SongId integer not null,
    BandMate integer not null,
    VocalType varchar(100) not null,
    FOREIGN KEY (SongId) references Songs (SongId),
    FOREIGN KEY (BandMate) references Band (BandId),
    primary key (SongId, BandMate, VocalType)
);

DROP table Performance;

CREATE TABLE Performance (
    SongId integer not null,
    Bandmate integer not null,
    StagePosition varchar(100) not null,
    FOREIGN KEY (SongId) references Songs (SongId),
    FOREIGN KEY (Bandmate) references Band (BandId),
    primary key (SongId, Bandmate)
);

DROP table Instruments;

CREATE TABLE Instruments (
    SongId integer not null,
    BandmateId integer not null,
    Instrument varchar(100) not null,
    FOREIGN KEY (SongId) references Songs (SongId),
    FOREIGN KEY (BandmateId) references Band (BandId),
    primary key (SongId,BandmateId, Instrument)
);

