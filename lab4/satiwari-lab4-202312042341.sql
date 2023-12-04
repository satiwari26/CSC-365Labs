-- Lab 4
-- satiwari
-- Dec 4, 2023

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
select FirstName, LastName from list where classroom = 111 order by LastName;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom DESC;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
select distinct teachers.First,teachers.Last, teachers.classroom from teachers Join list where list.grade = 5 and teachers.classroom = list.classroom order by teachers.classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
Select list.firstName, list.lastName from list JOIN teachers where list.classroom = teachers.classroom and teachers.classroom = 103
order by list.lastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Output teacher last name, first name, and grade. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
select distinct teachers.last, teachers.first, list.grade from teachers Join list on teachers.classroom = list.classroom where list.grade < 4 order by list.grade,teachers.last;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
select flavor, Food, price from goods where Flavor = 'Chocolate' and price < 5.00 order by price desc;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
select flavor, Food, price from goods where food = 'cookie' and price > 1.10 or flavor = 'lemon' or flavor = 'apple' and food != 'pie' order by flavor, Food;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
select distinct customers.lastName, customers.firstname from customers join receipts on customers.cid = receipts.customer where receipts.SaleDate = '2007-10-03' order by customers.lastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
select distinct flavor,Food from goods join items join receipts on goods.Gid = items.item and items.receipt = receipts.rnumber where receipts.saledate = '2007-10-04' and Food = 'cake';


USE `BAKERY`;
-- BAKERY-5
-- List all purchases by ARIANE CRUZEN on October 25, 2007. For each item purchased, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each item needs to appear the number of times it was purchased).
select distinct goods.flavor,goods.food, goods.price from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt where receipts.customer = 16 and receipts.saledate = '2007-10-25';


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

select distinct goods.flavor,goods.food from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt where receipts.customer = 13 and goods.food = 'cookie' and receipts.saledate >= '2007-10-01' and receipts.saledate < '2007-11-01' ;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
select campus from campuses where county = 'Los Angeles' order by campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
select distinct year, degrees from degrees where campusid= 11 and year >= 1994 and year <= 2000 order by year;


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
select campuses.campus, disciplines.name, discEnr.Gr, discEnr.Ug from campuses join disciplines join discEnr on discEnr.campusid = campuses.id and discEnr.discipline = disciplines.id where (campuses.id = 14 or campuses.id = 20) and (disciplines.id = 17 or disciplines.id = 9 or disciplines.id = 7) order by campuses.campus, disciplines.name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
select campuses.campus, disc1.gr,disc2.gr from campuses join discEnr disc1 on disc1.campusid = campuses.id join discEnr disc2 on disc1.campusid = disc2.campusid where disc1.year = 2004 and disc2.year = 2004 and disc1.discipline = 1 and disc2.discipline = 4 and disc1.gr != 0 and disc2.gr != 0 order by disc1.gr DESC;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
select campuses.campus, disciplines.name, discEnr.ug, discEnr.gr from campuses join disciplines join discEnr on discEnr.campusid = campuses.id and discEnr.discipline = disciplines.id where discEnr.year = 2004 and discEnr.gr > 3*discEnr.ug order by campuses.campus, disciplines.name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
select enrollments.year, (fees.fee * enrollments.FTE), ROUND((fees.fee * enrollments.FTE / faculty.FTE),2) from fees join enrollments on fees.campusId = enrollments.campusid join faculty on fees.campusid = faculty.campusid where enrollments.year = faculty.year and enrollments.year = fees.year and enrollments.year > 2001 and enrollments.year < 2005 and enrollments.campusid = 6 order by enrollments.year;


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
select campuses.campus, (enrollments.FTE), ( faculty.FTE), round((enrollments.FTE/ faculty.FTE),1) as ratio from campuses join enrollments on enrollments.campusId= campuses.id join faculty on faculty.campusid = campuses.id where enrollments.year = 2003 and faculty.year = 2003 and campuses.id != 19 and enrollments.FTE > 21027 order by ratio;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
select roomcode, roomname from rooms where decor = 'modern' and beds = '2' and baseprice < 160 order by roomcode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
select lastname, checkin, checkout, (adults + kids), rate from reservations where room = 'CAS' and checkin >= '2010-07-01' and checkout < '2010-08-01';


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
select rooms.roomname, reservations.checkin, reservations.checkout from reservations join rooms on reservations.room = rooms.roomcode where reservations.checkin <= '2010-02-06' and reservations.checkout > '2010-02-06' order by rooms.roomname;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

select reservations.code, rooms.roomname,reservations.checkin, reservations.checkout, DATEDIFF(reservations.checkout, reservations.checkin)*reservations.rate from reservations join rooms on reservations.room = rooms.roomcode where reservations.lastName = 'knerien' and reservations.firstName = 'Grant' order by reservations.checkin;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
select rooms.roomname, reservations.rate, DATEDIFF( reservations.checkout, reservations.checkin) as days, (DATEDIFF( reservations.checkout, reservations.checkin) * reservations.rate) as money from reservations join rooms on reservations.room = rooms.roomcode where reservations.checkin = '2010-12-31' order by days DESC;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
select reservations.code, reservations.room, rooms.roomname, reservations.checkin, reservations.checkout from reservations join rooms on reservations.room = rooms.roomcode where rooms.beds = '2' and rooms.bedType = 'Double' and reservations.adults = '4';


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
select place, runtime, pace from marathon where firstname = 'Teddy' and lastname = 'Brasel';


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
select firstname, lastname, place, runtime, groupplace from marathon where sex = 'F' and town = 'QUNICY' and state = 'MA' order by place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
select firstname, lastname, town, runtime from marathon where age = 34 and sex = 'F' and state = 'CT' order by runtime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
select distinct m1.bibnumber from marathon m1 join marathon m2 where m1.place != m2.place and m1.bibnumber = m2.bibnumber order by m1.bibnumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Include only age/gender groups with both a first and second place runner. Order the output by gender, then by age group.
select m1.sex, m1.agegroup, m1.firstname, m1.lastname, m1.age, m2.firstname,m2.lastname, m2.age from marathon m1 join marathon m2 on m1.agegroup = m2.agegroup and m1.sex = m2.sex where m1.groupplace = 1 and m2.groupplace = 2 order by m1.sex, m1.agegroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
select distinct airlines.name, airlines.abbr from airlines join flights on flights.airline = airlines.id where flights.source = 'AXX' order by airlines.name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

select flights.flightno, flights.destination, airports.name from flights join airports on flights.destination = airports.code where flights.airline = 6 and flights.source = 'AXX' order by flights.flightno;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
select f1.flightno, f2.flightno, f2.destination, airports.name from flights f1 join flights f2 on f1.airline = f2.airline and f1.destination = f2.source and f1.source != f2.destination join airports on airports.code = f2.destination where f1.airline = 6 and f1.source = 'AXX' order by f2.destination;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
select distinct f1.source, f1.destination from flights f1 join flights f2 on (f1.source = f2.source AND f1.destination = f2.destination) where f1.airline = 8 and f2.airline = 9 AND f1.source <= f1.destination;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
SELECT DISTINCT airports.code
FROM airports
JOIN flights f1 ON (airports.code = f1.source OR airports.code = f1.destination)
JOIN flights f2 ON (airports.code = f2.source OR airports.code = f2.destination)
JOIN flights f3 ON (airports.code = f3.source OR airports.code = f3.destination)
JOIN flights f4 ON (airports.code = f4.source OR airports.code = f4.destination)
JOIN flights f5 ON (airports.code = f5.source OR airports.code = f5.destination)
WHERE f1.airline = 3 AND f2.airline = 9 AND f3.airline = 2 AND f4.airline = 1 AND f5.airline = 4 order by airports.code;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
select distinct airports.code FROM airports
JOIN flights f1 ON (airports.code = f1.source)
JOIN flights f2 ON (airports.code = f2.source)
JOIN flights f3 ON (airports.code = f3.source)
where f1.flightno != f2.flightno AND f1.flightno != f3.flightno
AND f2.flightno != f3.flightno AND f1.airline = 4 AND f2.airline = 4 AND f3.airline = 4 order by airports.code;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
select Songs.title from Songs join Tracklists on Tracklists.song = Songs.songid join Albums on Tracklists.Album = Albums.Aid where Albums.aid = 1;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
select Band.firstName, Instruments.Instrument from Instruments Join Band on Instruments.Bandmate = Band.Id where Instruments.Song = 12 order by Band.firstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct Instruments.instrument from Instruments join Performance on Instruments.Bandmate = Performance.Bandmate where Instruments.Bandmate = 3 order by Instruments.instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
select Songs.title from Instruments Join Songs on Instruments.Song = Songs.songid where Instruments.instrument = 'ukalele' order by Songs.title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct Instruments.instrument from Instruments join Band on Instruments.Bandmate = Band.id join Vocals on Band.id = Vocals.Bandmate AND Vocals.Song = Instruments.Song where VocalType = 'lead' AND Band.id = 4 order by Instruments.instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
Select Songs.Title, Band.firstname, Performance.StagePosition from Songs join Vocals on Vocals.Song = Songs.SongId AND Vocals.Vocaltype = 'lead' Join Performance on Performance.song = Songs.songId Join Band on Band.id = Performance.Bandmate AND Band.id = Vocals.Bandmate where Performance.stagePosition != 'center' order by Songs.Title,Band.firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
select distinct Songs.title from Songs join Instruments i1 on i1.Song = Songs.songid 
Join Instruments i2 on i2.Song = Songs.songid 
join Instruments i3 on i3.Song = Songs.songid 
join Band on Band.id = i1.bandmate AND Band.id = i2.bandmate AND Band.id = i3.bandmate
where i1.instrument != i2.instrument AND i2.instrument != i3.instrument AND Band.id = 3;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
-- select b1.firstname, b2.firstname, b3.firstname, b4.firstname from Performance Join Band b1 on Performance.Bandmate = b1.id 
-- join Band b2 on Performance.Bandmate = b2.id
-- join Band b3 on Performance.Bandmate = b3.id
-- join Band b4 on Performance.Bandmate = b4.id
-- join Songs on Performance.Song = Songs.songid
-- where Songs.songid = 2;


SELECT
    MAX(CASE WHEN b1.id = Performance.Bandmate AND Performance.stageposition = 'right' THEN b1.firstname END) AS firstname1,
    MAX(CASE WHEN b2.id = Performance.Bandmate AND Performance.stageposition = 'center' THEN b2.firstname END) AS firstname2,
    MAX(CASE WHEN b3.id = Performance.Bandmate AND Performance.stageposition = 'back' THEN b3.firstname END) AS firstname3,
    MAX(CASE WHEN b4.id = Performance.Bandmate AND Performance.stageposition = 'left' THEN b4.firstname END) AS firstname4
FROM 
    Performance
JOIN 
    Band b1 ON Performance.Bandmate = b1.id 
JOIN 
    Band b2 ON Performance.Bandmate = b2.id
JOIN 
    Band b3 ON Performance.Bandmate = b3.id
JOIN 
    Band b4 ON Performance.Bandmate = b4.id
JOIN 
    Songs ON Performance.Song = Songs.songid
WHERE 
    Songs.songid = 2;


