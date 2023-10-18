
INSERT INTO Albums (AlbumId, title, year, label, album_Type) VALUES (1, 'Le Pop', 2008, 'Propeller Recordings', 'Studio');
INSERT INTO Albums (AlbumId, title, year, label, album_Type) VALUES (2, 'A Kiss Before You Go', 2011, 'Propeller Recordings', 'Studio');
INSERT INTO Albums (AlbumId, title, year, label, album_Type) VALUES (3, 'A Kiss Before You Go: Live in Hamburg', 2012, 'Universal Music Group', 'Live');
INSERT INTO Albums (AlbumId, title, year, label, album_Type) VALUES (4, 'Rockland', 2015, 'Propeller Recordings', 'Studio');


INSERT INTO Band (BandId, Firstname, Lastname) VALUES (1, 'Solveig', 'Heilo');
INSERT INTO Band (BandId, Firstname, Lastname) VALUES (2, 'Marianne', 'Sveen');
INSERT INTO Band (BandId, Firstname, Lastname) VALUES (3, 'Anne-Marit', 'Bergheim');
INSERT INTO Band (BandId, Firstname, Lastname) VALUES (4, 'Turid', 'Jorgensen');



INSERT INTO Songs (SongId, Title) VALUES (1, 'Overture');
INSERT INTO Songs (SongId, Title) VALUES (2, 'A Bar In Amsterdam');
INSERT INTO Songs (SongId, Title) VALUES (3, 'Demon Kitty Rag');
INSERT INTO Songs (SongId, Title) VALUES (4, 'Tea With Cinnamon');
INSERT INTO Songs (SongId, Title) VALUES (5, 'Hey Ho on the Devil''s Back');
INSERT INTO Songs (SongId, Title) VALUES (6, 'Wading in Deeper');
INSERT INTO Songs (SongId, Title) VALUES (7, 'Le Pop');
INSERT INTO Songs (SongId, Title) VALUES (8, 'Der Kapitan');
INSERT INTO Songs (SongId, Title) VALUES (9, 'Virginia Clemm');
INSERT INTO Songs (SongId, Title) VALUES (10, 'Play My Darling, Play');
INSERT INTO Songs (SongId, Title) VALUES (11, 'To the Sea');
INSERT INTO Songs (SongId, Title) VALUES (12, 'Mother Superior');
INSERT INTO Songs (SongId, Title) VALUES (13, 'Aint no Thang');
INSERT INTO Songs (SongId, Title) VALUES (14, 'A Kiss Before You Go');
INSERT INTO Songs (SongId, Title) VALUES (15, 'I Will Dance (When I Walk Away)');
INSERT INTO Songs (SongId, Title) VALUES (16, 'Cherry Pie');
INSERT INTO Songs (SongId, Title) VALUES (17, 'Land of Confusion');
INSERT INTO Songs (SongId, Title) VALUES (18, 'Lady Marlene');
INSERT INTO Songs (SongId, Title) VALUES (19, 'Rock-Paper-Scissors');
INSERT INTO Songs (SongId, Title) VALUES (20, 'Cocktails and Ruby Slippers');
INSERT INTO Songs (SongId, Title) VALUES (21, 'Soviet Trumpeter');
INSERT INTO Songs (SongId, Title) VALUES (22, 'Loathsome M');
INSERT INTO Songs (SongId, Title) VALUES (23, 'Shepherds Song');
INSERT INTO Songs (SongId, Title) VALUES (24, 'Gypsy Flee');
INSERT INTO Songs (SongId, Title) VALUES (25, 'God''s Great Dust Storm');
INSERT INTO Songs (SongId, Title) VALUES (26, 'Ouch');
INSERT INTO Songs (SongId, Title) VALUES (27, 'Listening to the World');
INSERT INTO Songs (SongId, Title) VALUES (28, 'Johnny Blowtorch');
INSERT INTO Songs (SongId, Title) VALUES (29, 'Flash');
INSERT INTO Songs (SongId, Title) VALUES (30, 'Driving After You');
INSERT INTO Songs (SongId, Title) VALUES (31, 'My Own Tune');
INSERT INTO Songs (SongId, Title) VALUES (32, 'Badlands');
INSERT INTO Songs (SongId, Title) VALUES (33, 'Old De Spain');
INSERT INTO Songs (SongId, Title) VALUES (34, 'Oh My God');
INSERT INTO Songs (SongId, Title) VALUES (35, 'Lady Gray');
INSERT INTO Songs (SongId, Title) VALUES (36, 'Shine Like Neon Rays');
INSERT INTO Songs (SongId, Title) VALUES (37, 'Flash in the Dark');
INSERT INTO Songs (SongId, Title) VALUES (38, 'My Dear');
INSERT INTO Songs (SongId, Title) VALUES (39, 'Bad Girl');
INSERT INTO Songs (SongId, Title) VALUES (40, 'Rockland');
INSERT INTO Songs (SongId, Title) VALUES (41, 'Curvaceous Needs');
INSERT INTO Songs (SongId, Title) VALUES (42, 'Borka');
INSERT INTO Songs (SongId, Title) VALUES (43, 'Let it Snow');


INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES
(1, 1, 'trumpet'),
(1, 2, 'keyboard'),
(1, 3, 'accordion'),
(1, 4, 'bass balalaika'),
(2, 1, 'trumpet'),
(2, 2, 'drums'),
(2, 3, 'guitar'),
(2, 4, 'bass balalaika'),
(3, 1, 'drums'),
(3, 1, 'ukulele'),
(3, 2, 'banjo'),
(3, 3, 'bass balalaika'),
(3, 4, 'keyboards'),
(4, 1, 'drums'),
(4, 2, 'ukulele'),
(4, 3, 'accordion'),
(4, 4, 'bass balalaika');

INSERT INTO Performance (SongId, Bandmate, StagePosition) VALUES
(1, 1, 'back'),
(1, 2, 'left'),
(1, 3, 'center'),
(1, 4, 'right'),
(2, 1, 'center'),
(2, 2, 'back'),
(2, 3, 'left'),
(2, 4, 'right'),
(3, 1, 'back'),
(3, 2, 'right'),
(3, 3, 'center'),
(3, 4, 'left'),
(4, 1, 'back'),
(4, 2, 'center'),
(4, 3, 'left'),
(4, 4, 'right');

