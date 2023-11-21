-- Lab 5
-- satiwari
-- Nov 20, 2023

USE `AIRLINES`;
-- AIRLINES-1
-- Find all airports with exactly 17 outgoing flights. Report airport code and the full name of the airport sorted in alphabetical order by the code.
select distinct airports.code, airports.name from airports join flights on flights.source = airports.code group by airports.code, airports.name having count(airports.code) = 17 order by airports.code;


USE `AIRLINES`;
-- AIRLINES-2
-- Find the number of airports from which airport ANP can be reached with exactly one transfer. Make sure to exclude ANP itself from the count. Report just the number.
select COUNT(DISTINCT f1.source) from flights f1 join flights f2 on f1.destination = f2.source where f2.destination = "ANP" and f1.source != "ANP";


USE `AIRLINES`;
-- AIRLINES-3
-- Find the number of airports from which airport ATE can be reached with at most one transfer. Make sure to exclude ATE itself from the count. Report just the number.
select COUNT(DISTINCT f1.source) from flights f1 join flights f2 on f1.destination = f2.source where f1.destination = "ATE" or f2.destination = "ATE" and f1.source != "ATE";


USE `AIRLINES`;
-- AIRLINES-4
-- For each airline, report the total number of airports from which it has at least one outgoing flight. Report the full name of the airline and the number of airports computed. Report the results sorted by the number of airports in descending order. In case of tie, sort by airline name A-Z.
select airlines.name,count(distinct flights.source) as num_airports from flights join airlines on flights.airline = airlines.id group by airlines.name ORDER BY num_airports DESC, airlines.name ASC;


USE `BAKERY`;
-- BAKERY-1
-- For each flavor which is found in more than three types of items offered at the bakery, report the flavor, the average price (rounded to the nearest penny) of an item of this flavor, and the total number of different items of this flavor on the menu. Sort the output in ascending order by the average price.
select flavor, round(avg(price),2) as avg_price, count(distinct food) from goods group by flavor having count(distinct food) > 3 order by avg_price;


USE `BAKERY`;
-- BAKERY-2
-- Find the total amount of money the bakery earned in October 2007 from selling eclairs. Report just the amount.
select sum(price) from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt where saledate >= "2007-10-01" and saledate <= "2007-10-31" and food = "Eclair" group by food;


USE `BAKERY`;
-- BAKERY-3
-- For each visit by NATACHA STENZ output the receipt number, sale date, total number of items purchased, and amount paid, rounded to the nearest penny. Sort by the amount paid, greatest to least.
select receipts.Rnumber, receipts.saledate, count(items.item), round(sum(goods.price),2) as paid_amt from customers join receipts on receipts.customer = customers.cid join items on items.receipt = receipts.Rnumber join goods on items.item = goods.gid where customers.firstname = "NATACHA" and customers.lastname = "STENZ" group by receipts.Rnumber, receipts.saledate order by paid_amt desc;


USE `BAKERY`;
-- BAKERY-4
-- For the week starting October 8, report the day of the week (Monday through Sunday), the date, total number of purchases (receipts), the total number of pastries purchased, and the overall daily revenue rounded to the nearest penny. Report results in chronological order.
select dayname(receipts.saledate), receipts.saledate, count(distinct items.receipt), count(items.item), round(sum(goods.price),2) from receipts join items on receipts.rnumber = items.receipt join goods on goods.gid = items.item where receipts.saledate > "2007-10-07" and receipts.saledate < "2007-10-15" group by receipts.saledate;


USE `BAKERY`;
-- BAKERY-5
-- Report all dates on which more than ten tarts were purchased, sorted in chronological order.
select receipts.saledate from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt where goods.food = "Tart" group by receipts.saledate having count(food) > 10;


USE `CSU`;
-- CSU-1
-- For each campus that averaged more than $2,500 in fees between the years 2000 and 2005 (inclusive), report the campus name and total of fees for this six year period. Sort in ascending order by fee.
select campuses.campus, sum(fees.fee) as total_fee from campuses join fees on campuses.id = fees.campusid where fees.year >= 2000 and fees.year <=2005 group by campuses.campus having avg(fees.fee) > 2500 order by total_fee;


USE `CSU`;
-- CSU-2
-- For each campus for which data exists for more than 60 years, report the campus name along with the average, minimum and maximum enrollment (over all years). Sort your output by average enrollment.
select campuses.campus, avg(enrollments.enrolled) as avgEnrolls, min(enrollments.enrolled), max(enrollments.enrolled) from campuses join enrollments on campuses.id = enrollments.campusid group by campuses.campus having (max(enrollments.year) - min(enrollments.year)) > 60 order by avgEnrolls;


USE `CSU`;
-- CSU-3
-- For each campus in LA and Orange counties report the campus name and total number of degrees granted between 1998 and 2002 (inclusive). Sort the output in descending order by the number of degrees.

select campuses.campus, sum(degrees.degrees) as totalDeg from campuses join degrees on campuses.id = degrees.campusid where degrees.year >=1998 and degrees.year<= 2002 and (campuses.county = "los Angeles" or campuses.county = "orange") group by campuses.campus order by totalDeg desc;


USE `CSU`;
-- CSU-4
-- For each campus that had more than 20,000 enrolled students in 2004, report the campus name and the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name of the campus. (Exclude campuses that had no graduate enrollment at all.)
select campuses.campus as campus, count(discEnr.discipline) from campuses join enrollments on enrollments.campusid = campuses.id join discEnr on discEnr.campusid = campuses.id where enrollments.year = 2004 and enrollments.enrolled > 20000 and discEnr.Gr > 0 group by campuses.campus order by campus;


USE `INN`;
-- INN-1
-- For each room, report the full room name, total revenue (number of nights times per-night rate), and the average revenue per stay. In this summary, include only those stays that began in the months of September, October and November of calendar year 2010. Sort output in descending order by total revenue. Output full room names.
select rooms.roomname as roomname, sum(datediff(reservations.checkout, reservations.checkin)*reservations.rate) as totalRev,
round(avg(datediff(reservations.checkout, reservations.checkin)*reservations.rate),2) as avgRev
from rooms join reservations on rooms.roomcode = reservations.room where reservations.checkin >= "2010-09-01" and reservations.checkin <= "2010-11-30" group by rooms.roomname order by totalRev DESC, roomname;


USE `INN`;
-- INN-2
-- Report the total number of reservations that began on Fridays, and the total revenue they brought in.
select count(distinct code), sum(datediff(checkout,checkin)*rate) from reservations where dayname(checkin) = "friday" group by dayname(checkin);


USE `INN`;
-- INN-3
-- List each day of the week. For each day, compute the total number of reservations that began on that day, and the total revenue for these reservations. Report days of week as Monday, Tuesday, etc. Order days from Sunday to Saturday.
select dayname(checkin) as day,count(distinct code),sum(datediff(checkout,checkin)*rate) from reservations group by dayname(checkin)
order by dayofweek(checkin);


USE `INN`;
-- INN-4
-- For each room list full room name and report the highest markup against the base price and the largest markdown (discount). Report markups and markdowns as the signed difference between the base price and the rate. Sort output in descending order beginning with the largest markup. In case of identical markup/down sort by room name A-Z. Report full room names.
select rooms.roomname as roomname, max(reservations.rate - rooms.baseprice) as markup, min(reservations.rate - rooms.baseprice) from rooms join reservations on rooms.roomcode = reservations.room group by rooms.roomname order by markup DESC, roomname;


USE `INN`;
-- INN-5
-- For each room report how many nights in calendar year 2010 the room was occupied. Report the room code, the full name of the room, and the number of occupied nights. Sort in descending order by occupied nights. (Note: this should be number of nights during 2010. Some reservations extend beyond December 31, 2010. The ”extra” nights in 2011 must be deducted).
select rooms.roomcode, rooms.roomname, sum(
CASE
    WHEN reservations.checkin <= '2010-12-31' AND reservations.checkout >= '2011-01-01' THEN
        DATEDIFF(
            LEAST('2010-12-31', reservations.checkout),
            GREATEST('2010-01-01', reservations.checkin)
        ) + 1
    ELSE
        datediff(reservations.checkout,reservations.checkin) 
END) 

as days from rooms join reservations on rooms.roomcode = reservations.room where reservations.checkin <= "2010-12-31" and reservations.checkout >= "2010-01-01" group by rooms.roomname
order by days desc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- For each performer, report first name and how many times she sang lead vocals on a song. Sort output in descending order by the number of leads. In case of tie, sort by performer first name (A-Z.)
select Band.firstName, count(distinct Vocals.Song) as song from Band join Vocals on Band.id = Vocals.bandmate where Vocals.VocalType = "lead" group by Band.id order by song desc, Band.firstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report how many different instruments each performer plays on songs from the album 'Le Pop'. Include performer's first name and the count of different instruments. Sort the output by the first name of the performers.
select Band.firstName as firstname, count(DISTINCT Instruments.instrument) from Tracklists join Albums on Tracklists.Album = Albums.Aid join Instruments on Instruments.song = Tracklists.song join Band on Band.id = Instruments.bandmate where Albums.title = "Le Pop" group by Band.id order by firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List each stage position along with the number of times Turid stood at each stage position when performing live. Sort output in ascending order of the number of times she performed in each position.

select Performance.stagePosition, count(song) as position from Band join Performance on Band.id = Performance.Bandmate where Band.firstName = "Turid" group by Performance.StagePosition order by position;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Report how many times each performer (other than Anne-Marit) played bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. List performer first name and a number for each performer. Sort output alphabetically by the name of the performer.

select Band.firstName, count(distinct Instruments.song) from Band join Instruments on Band.id = Instruments.Bandmate join Performance on Performance.Song = Instruments.song where Instruments.Instrument = "bass balalaika" and Performance.Bandmate = 3 and Performance.stageposition = "left" group by Band.id order by Band.firstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Report all instruments (in alphabetical order) that were played by three or more people.
select Instrument from Instruments group by Instrument having count(distinct Bandmate)> 2 order by instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- For each performer, list first name and report the number of songs on which they played more than one instrument. Sort output in alphabetical order by first name of the performer
select Band.firstName, count(distinct Songs.songid ) from Band join Instruments I1 on Band.id = I1.Bandmate join Songs on Songs.songid = I1.song join Instruments I2 on Band.id = I2.bandmate and I2.song = Songs.songid and I2.instrument != I1.instrument group by Band.id order by Band.firstname;


USE `MARATHON`;
-- MARATHON-1
-- List each age group and gender. For each combination, report total number of runners, the overall place of the best runner and the overall place of the slowest runner. Output result sorted by age group and sorted by gender (F followed by M) within each age group.
select Agegroup, sex, count(distinct place), min(distinct place), max(distinct place) from marathon group by agegroup, sex order by ageGroup, sex;


USE `MARATHON`;
-- MARATHON-2
-- Report the total number of gender/age groups for which both the first and the second place runners (within the group) are from the same state.
select count(m1.place) from marathon m1 join marathon m2 on m1.agegroup = m2.agegroup and m1.sex = m2.sex where m1.groupplace = 1 and m2.groupplace = 2 and m1.state = m2.state group by m1.sex;


USE `MARATHON`;
-- MARATHON-3
-- For each full minute, report the total number of runners whose pace was between that number of minutes and the next. In other words: how many runners ran the marathon at a pace between 5 and 6 mins, how many at a pace between 6 and 7 mins, and so on.
select minute(pace), count(distinct place) from marathon group by minute(pace);


USE `MARATHON`;
-- MARATHON-4
-- For each state with runners in the marathon, report the number of runners from the state who finished in top 10 in their gender-age group. If a state did not have runners in top 10, do not output information for that state. Report state code and the number of top 10 runners. Sort in descending order by the number of top 10 runners, then by state A-Z.
select state, count(distinct place) as place from marathon where groupplace <=10 group by state order by place desc;


USE `MARATHON`;
-- MARATHON-5
-- For each Connecticut town with 3 or more participants in the race, report the town name and average time of its runners in the race computed in seconds. Output the results sorted by the average time (lowest average time first).
select town, round(avg(TIME_TO_SEC(runtime)),1) as avgTime from marathon where state = "CT" group by town having count(distinct place) >= 3 order by avgTime;


USE `STUDENTS`;
-- STUDENTS-1
-- Report the last and first names of teachers who have between seven and eight (inclusive) students in their classrooms. Sort output in alphabetical order by the teacher's last name.
select teachers.last, teachers.first from teachers join list on teachers.classroom = list.classroom group by teachers.classroom having count(distinct list.lastname) =7 or count(distinct list.lastname) =8 order by teachers.last;


USE `STUDENTS`;
-- STUDENTS-2
-- For each grade, report the grade, the number of classrooms in which it is taught, and the total number of students in the grade. Sort the output by the number of classrooms in descending order, then by grade in ascending order.

select list.grade, count(distinct teachers.classroom) classroom, count(list.firstname) from list join teachers on list.classroom = teachers.classroom group by list.grade order by classroom desc, list.grade asc;


USE `STUDENTS`;
-- STUDENTS-3
-- For each Kindergarten (grade 0) classroom, report classroom number along with the total number of students in the classroom. Sort output in the descending order by the number of students.
select classroom, count(firstname) as count from list where grade = 0 group by classroom order by count desc;


USE `STUDENTS`;
-- STUDENTS-4
-- For each fourth grade classroom, report the classroom number and the last name of the student who appears last (alphabetically) on the class roster. Sort output by classroom.
select classroom, max(lastname) from list where grade = 4 group by classroom order by classroom;


