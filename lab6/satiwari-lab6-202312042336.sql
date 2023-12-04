-- Lab 6
-- satiwari
-- Dec 4, 2023

USE `BAKERY`;
-- BAKERY-1
-- Find all customers who did not make a purchase between October 5 and October 11 (inclusive) of 2007. Output first and last name in alphabetical order by last name.
SELECT firstName, lastName
FROM customers
WHERE NOT EXISTS (
    SELECT *
    FROM receipts
    WHERE receipts.customer = customers.cid
    AND receipts.saleDate BETWEEN '2007-10-05' AND '2007-10-11'
)
ORDER BY lastName, firstName;


USE `BAKERY`;
-- BAKERY-2
-- Find the customer(s) who spent the most money at the bakery during October of 2007. Report first, last name and total amount spent (rounded to two decimal places). Sort by last name.
select firstname, lastname, Round(max(totalPrice),2) as maxPrice from(select customers.firstname as firstname,customers.lastname as lastname, sum(goods.price) as totalPrice from customers join receipts on customers.cid = receipts.customer join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item where receipts.saledate between '2007-10-01' and '2007-10-31' group by customers.cid order by totalprice desc) as sum;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who never purchased a twist ('Twist') during October 2007. Report first and last name in alphabetical order by last name.

select firstname, lastname from customers as cust where not exists (select * from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt join customers on customers.cid = receipts.customer where goods.food = 'twist' and receipts.saledate between '2007-10-01' and '2007-10-31' and customers.cid = cust.cid group by customers.cid) order by cust.lastname;


USE `BAKERY`;
-- BAKERY-4
-- Find the baked good(s) (flavor and food type) responsible for the most total revenue.
select flavor, food from(select food, flavor, max(maxRev) from (select goods.food, goods.flavor, sum(goods.price) as maxRev from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item group by goods.gid order by maxRev desc) as flavour) as foodFlav;


USE `BAKERY`;
-- BAKERY-5
-- Find the most popular item, based on number of pastries sold. Report the item (flavor and food) and total quantity sold.
select flavor, food, popitem from(select flavor, food, max(popularItem) as popitem from (select *, count(goods.gid) as popularItem from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item group by goods.gid order by popularItem desc) as popularFood) as itemspop;


USE `BAKERY`;
-- BAKERY-6
-- Find the date(s) of highest revenue during the month of October, 2007. In case of tie, sort chronologically.
select saledate from(select saledate,max(totalsale) from(select *, sum(goods.price) as totalsale from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item 
 where receipts.saledate between '2007-10-01' and '2007-11-01'
group by receipts.saledate order by totalsale desc) as listDates) as maxsale;


USE `BAKERY`;
-- BAKERY-7
-- Find the best-selling item(s) (by number of purchases) on the day(s) of highest revenue in October of 2007.  Report flavor, food, and quantity sold. Sort by flavor and food.
select flavor, food, maxpopularDateItem from(select *, max(popularDateItem) as maxpopularDateItem from(select *, count(gid) as popularDateItem from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item 
 where receipts.saledate between '2007-10-01' and '2007-11-01' and receipts.saledate = (select saledate from(select *, max(totalsale) as sale from(select *, sum(goods.price) as totalsale from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item 
 where receipts.saledate between '2007-10-01' and '2007-11-01'
group by receipts.saledate order by totalsale desc) as maxSale) as maxsaledate) group by gid order by popularDateItem desc) as populateItemDateQuant) as eoutput;


USE `BAKERY`;
-- BAKERY-8
-- For every type of Cake report the customer(s) who purchased it the largest number of times during the month of October 2007. Report the name of the pastry (flavor, food type), the name of the customer (first, last), and the quantity purchased. Sort output in descending order on the number of purchases, then in alphabetical order by last name of the customer, then by flavor.
select flavor, food, firstname, lastname, maxCake  from(select *, max(timePurchased) over(partition by gid) as maxCake from(select *, count(price) as timePurchased from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt join customers on customers.cid = receipts.customer where goods.food = 'cake' and receipts.saledate between '2007-10-01' and '2007-10-31' group by goods.gid, customers.cid order by timePurchased desc) as purTimes) as customFoodCheck where maxCake = timePurchased order by timePurchased desc, lastname, flavor;


USE `BAKERY`;
-- BAKERY-9
-- Output the names of all customers who made multiple purchases (more than one receipt) on the latest day in October on which they made a purchase. Report names (last, first) of the customers and the *earliest* day in October on which they made a purchase, sorted in chronological order, then by last name.

select lastname, firstname,earliestdate from(select * from(select *, max(saledate) over(partition by cid) as latestdate, min(receipts.saledate) over(partition by cid) as earliestdate from receipts join customers on customers.cid = receipts.customer where receipts.saledate > '2007-09-30' and receipts.saledate < '2007-11-01') as latestsaledate group by saledate, cid having count(rnumber) > 1) as latestdatesetcust where latestdate = saledate and earliestdate != saledate order by earliestdate, lastname;


USE `BAKERY`;
-- BAKERY-10
-- Find out if sales (in terms of revenue) of Chocolate-flavored items or sales of Croissants (of all flavors) were higher in October of 2007. Output the word 'Chocolate' if sales of Chocolate-flavored items had higher revenue, or the word 'Croissant' if sales of Croissants brought in more revenue.

WITH foodPriceInfo AS (select max(sumChocolatePrice) as maxChoc, max(sumCroissantPrice) as maxCro from(select *, sum(goodsPrice) over(partition by flavor = 'chocolate') as sumChocolatePrice, sum(goodsPrice) over(partition by food = 'Croissant') as sumCroissantPrice from(select *, sum(goods.price) as goodsPrice from receipts join items on items.receipt = receipts.rnumber join goods on goods.gid = items.item 
 where receipts.saledate between '2007-10-01' and '2007-11-01' and goods.flavor = 'chocolate' or goods.food = 'croissant' group by goods.gid) as choiceGoodsPrice) AS groupchoCroPrice where sumChocolatePrice > 100 and sumCroissantPrice > 100 group by sumChocolatePrice)
 
 select
    CASE
        when maxChoc > maxCro then 'Chocolate'
        when maxChoc < maxCro then 'Croissant'
        ELSE 'Unknown'
    END as foodChoice
    from foodPriceInfo;


USE `INN`;
-- INN-1
-- Find the most popular room(s) (based on the number of reservations) in the hotel  (Note: if there is a tie for the most popular room, report all such rooms). Report the full name of the room, the room code and the number of reservations.

select roomname, roomcode, max(numReservation) from(select *, count(reservations.code) as numReservation from rooms join reservations on rooms.roomcode = reservations.room group by rooms.roomcode order by numReservation desc) as roomsCount;


USE `INN`;
-- INN-2
-- Find the room(s) that have been occupied the largest number of days based on all reservations in the database. Report the room name(s), room code(s) and the number of days occupied. Sort by room name.
select roomname, roomcode, max(totaldaysReserv) as bookedDays from(select *, sum(dateReserv) as totaldaysReserv from(select  *, datediff(reservations.checkout,reservations.checkin) as dateReserv from rooms join reservations on rooms.roomcode = reservations.room) as daysReserved group by room order by totaldaysReserv desc) as reservSum;


USE `INN`;
-- INN-3
-- For each room, report the most expensive reservation. Report the full room name, dates of stay, last name of the person who made the reservation, daily rate and the total amount paid (rounded to the nearest penny.) Sort the output in descending order by total amount paid.
select roomname, checkin, checkout, lastname, rate, round(reservationCost,2) as amountPaid from(select *, max(reservationCost) over(partition by room) as maxCostOfRooms from(select *, (dateReserv * rate) as reservationCost from(select  *, datediff(reservations.checkout,reservations.checkin) as dateReserv from rooms join reservations on rooms.roomcode = reservations.room) as dateResv) as cost) as maxDerivedCost where maxCostOfRooms = reservationCost order by amountPaid desc;


USE `INN`;
-- INN-4
-- For each room, report whether it is occupied or unoccupied on July 4, 2010. Report the full name of the room, the room code, and either 'Occupied' or 'Empty' depending on whether the room is occupied on that day. (the room is occupied if there is someone staying the night of July 4, 2010. It is NOT occupied if there is a checkout on this day, but no checkin). Output in alphabetical order by room code. 
select roomname, roomcode, occupancy from(select *, row_number() over(partition by room order by occupancy desc) as rowRank from(select  *,

case
    when reservations.checkin <= '2010-07-04' and reservations.checkout > '2010-07-04' then 'Occupied'
    else 'Empty'
End as occupancy

from rooms join reservations on rooms.roomcode = reservations.room group by reservations.room, occupancy) as occResult) as rankOccResult where rowRank !=2 order by roomcode;


USE `INN`;
-- INN-5
-- Find the highest-grossing month (or months, in case of a tie). Report the month name, the total number of reservations and the revenue. For the purposes of the query, count the entire revenue of a stay that commenced in one month and ended in another towards the earlier month. (e.g., a September 29 - October 3 stay is counted as September stay for the purpose of revenue computation). In case of a tie, months should be sorted in chronological order.
select month, reservations, max(monthyNetAmount) as monthAmount from(select *, count(code) as reservations, sum(amountPaid) monthyNetAmount from(select *, (reservedDays * rate) as amountPaid from(select *, datediff(reservations.checkout, reservations.checkin) as reservedDays,  monthname(reservations.checkin) as month from rooms join reservations on rooms.roomcode = reservations.room) as datedata) as amountData group by month order by monthyNetAmount desc) as MaxMonthamount;


USE `STUDENTS`;
-- STUDENTS-1
-- Find the teacher(s) with the largest number of students. Report the name of the teacher(s) (last, first) and the number of students in their class.

select last,first, max(numberofStudents) from(select teachers.first, teachers.last, count(list.lastname) as numberofStudents from list join teachers on list.classroom = teachers.classroom group by teachers.first order by numberofStudents desc) as studentCount;


USE `STUDENTS`;
-- STUDENTS-2
-- Find the grade(s) with the largest number of students whose last names start with letters 'A', 'B' or 'C' Report the grade and the number of students. In case of tie, sort by grade number.
select grade, max(studentNames) from(select grade, count(list.lastname) as studentNames from list join teachers on list.classroom = teachers.classroom where lastname like 'A%' or lastname like 'B%' or lastname like 'C%' group by list.grade order by studentNames desc) as StudentNamesGrade;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all classrooms which have fewer students in them than the average number of students in a classroom in the school. Report the classroom numbers and the number of student in each classroom. Sort in ascending order by classroom.
With numberOfStudents as (select avg(numStudent) as avgStudents from(select count(list.lastname) as numStudent from list join teachers on list.classroom = teachers.classroom group by list.classroom) as listStudents)


select classroom, numStudent from(select list.classroom, avgStudents, count(list.lastname) as numStudent from list join teachers on list.classroom = teachers.classroom cross join numberOfStudents group by list.classroom having avgStudents > numStudent) as reportedClass order by classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all pairs of classrooms with the same number of students in them. Report each pair only once. Report both classrooms and the number of students. Sort output in ascending order by the number of students in the classroom.
With studentsnumbers as (select l1.classroom as room, l1.grade,count(l1.lastname) as numStudent from list l1 join teachers on l1.classroom = teachers.classroom group by l1.classroom)

select room, classroom, numStudent from(select *,ABS(classroom - room) as Absdiff from(select list.classroom,count(list.lastname) as numStudentActual from list join teachers on list.classroom = teachers.classroom group by list.classroom) as groupedClass join studentsnumbers on numStudent = numStudentActual and studentsnumbers.room != groupedClass.classroom) as expectRes group by absdiff order by numStudent;


USE `STUDENTS`;
-- STUDENTS-5
-- For each grade with more than one classroom, report the grade and the last name of the teacher who teaches the classroom with the largest number of students in the grade. Output results in ascending order by grade.
select grade, last from(select *, max(gradePopulation) over(partition by grade) as gradeStudents from(select list.firstname,count(lastname) as gradePopulation, list.lastname, list.grade,list.classroom,teachers.first,teachers.last, count(list.classroom) over(partition by grade) as numsOfClassRoom from list join teachers on list.classroom = teachers.classroom group by list.grade, list.classroom) as gradeinfo where numsOfClassRoom > 1)as gradeBased where gradeStudents = gradePopulation;


USE `CSU`;
-- CSU-1
-- Find the campus(es) with the largest enrollment in 2000. Output the name of the campus and the enrollment. Sort by campus name.

select campus,enrolled from(select campuses.campus,enrollments.enrolled, max(enrollments.enrolled) over() as maxEnroll from campuses join enrollments on enrollments.campusid = campuses.id where enrollments.year = 2000 order by enrollments.enrolled desc) as maxEnrollments where enrolled = maxEnroll;


USE `CSU`;
-- CSU-2
-- Find the university (or universities) that granted the highest average number of degrees per year over its entire recorded history. Report the name of the university, sorted alphabetically.

select campus from(select *, max(avgDegree) from(select campuses.campus, degrees.year, avg(degrees.degrees) as avgDegree from campuses join degrees on campuses.id = degrees.campusid group by campuses.id order by avgDegree desc) as avgCalDeg)as campusOrder;


USE `CSU`;
-- CSU-3
-- Find the university with the lowest student-to-faculty ratio in 2003. Report the name of the campus and the student-to-faculty ratio, rounded to one decimal place. Use FTE numbers for enrollment. In case of tie, sort by campus name.
select campus,round(studentToFacultyRatio,1) from(select campus,studentToFacultyRatio, min(studentToFacultyRatio) over()as minFTE from(select campuses.campus, (enrollments.FTE/faculty.FTE) as studentToFacultyRatio from campuses join enrollments on campuses.id = enrollments.campusid join faculty on campuses.id = faculty.campusid where enrollments.year = 2003 and faculty.year = 2003 order by studentToFacultyRatio) as FTEratio)as minFTEratio where minFTE = studentToFacultyRatio;


USE `CSU`;
-- CSU-4
-- Among undergraduates studying 'Computer and Info. Sciences' in the year 2004, find the university with the highest percentage of these students (base percentages on the total from the enrollments table). Output the name of the campus and the percent of these undergraduate students on campus. In case of tie, sort by campus name.
select campus, round(percentCS,1) from(select *, max(percentCS) over() as maxPerc from(select campuses.campus, ((discEnr.Ug/enrollments.enrolled)*100) as percentCS from campuses join enrollments on campuses.id = enrollments.campusid join discEnr on discEnr.campusid = campuses.id join disciplines on discEnr.discipline = disciplines.id where discEnr.year = 2004 and enrollments.year = 2004 and disciplines.name = 'Computer and Info. Sciences' order by percentCS desc) as percentRes) as expectedRes where maxPerc = percentCS;


USE `CSU`;
-- CSU-5
-- For each year between 1997 and 2003 (inclusive) find the university with the highest ratio of total degrees granted to total enrollment (use enrollment numbers). Report the year, the name of the campuses, and the ratio. List in chronological order.
select year, campus,maxPerYear from(select *, max(degToEnrRatio) over(partition by year) as maxPerYear from(select degrees.year, campuses.campus, (degrees.degrees/enrollments.enrolled) as degToEnrRatio from campuses join degrees on campuses.id = degrees.campusid join enrollments on campuses.id = enrollments.campusid where degrees.year >= 1997 and degrees.year <= 2003 and enrollments.year = degrees.year) as degRatio) as maxDegPerYear where maxPerYear = degToEnrRatio;


USE `CSU`;
-- CSU-6
-- For each campus report the year of the highest student-to-faculty ratio, together with the ratio itself. Sort output in alphabetical order by campus name. Use FTE numbers to compute ratios and round to two decimal places.
SELECT campus, year, FtoRratio
FROM (
    SELECT campus, year, ROUND(studentToFacultyRatio, 2) AS FtoRratio,
        MAX(studentToFacultyRatio) OVER (PARTITION BY campus) AS maxFTE
    FROM (
        SELECT campuses.campus, faculty.year, ROUND((enrollments.FTE / faculty.FTE), 2) AS studentToFacultyRatio
        FROM campuses
        JOIN enrollments ON campuses.id = enrollments.campusid
        JOIN faculty ON campuses.id = faculty.campusid
        where enrollments.year = faculty.year
        ORDER BY studentToFacultyRatio
    ) AS FTEratio
    ORDER BY campus
) AS higherFTEratio
WHERE ROUND(maxFTE, 2) = FtoRratio;


USE `CSU`;
-- CSU-7
-- For each year for which the data is available, report the total number of campuses in which student-to-faculty ratio became worse (i.e. more students per faculty) as compared to the previous year. Report in chronological order.

select year, count(campus) from(select *, lag(studentToFacultyRatio) over(partition by campus order by year) as prevData from(    
        SELECT campuses.campus, faculty.year, ROUND((enrollments.FTE / faculty.FTE), 2) AS studentToFacultyRatio
        FROM campuses
        JOIN enrollments ON campuses.id = enrollments.campusid
        JOIN faculty ON campuses.id = faculty.campusid
        where enrollments.year = faculty.year
        ) as StrFaculty) as prevDataRes where studentToFacultyRatio > prevData group by year;


USE `MARATHON`;
-- MARATHON-1
-- Find the state(s) with the largest number of participants. List state code(s) sorted alphabetically.

select state from(select state, max(maxParticipants) from(select *, count(firstname) as maxParticipants from marathon group by state order by maxParticipants desc) as maxPart)as participants;


USE `MARATHON`;
-- MARATHON-2
-- Find all towns in Rhode Island (RI) which fielded more female runners than male runners for the race. Include only those towns that fielded at least 1 male runner and at least 1 female runner. Report the names of towns, sorted alphabetically.

with malePlayers as(select *, count(firstname) as stateparticipants from marathon where state = 'RI' and sex = 'M' group by town, sex)

select femalePlayers.town from malePlayers join (select *, count(firstname) as stateparticipants from marathon where state = 'RI' and sex = 'F' group by town, sex) as femalePlayers on femalePlayers.town = malePlayers.town where femalePlayers.stateparticipants > malePlayers.stateparticipants order by femalePlayers.town;


USE `MARATHON`;
-- MARATHON-3
-- For each state, report the gender-age group with the largest number of participants. Output state, age group, gender, and the number of runners in the group. Report only information for the states where the largest number of participants in a gender-age group is greater than one. Sort in ascending order by state code, age group, then gender.
select state, agegroup, sex, maxParticipants  from(select *, max(participantsGroup) over(partition by state) as maxParticipants from(select *, count(firstname) as participantsGroup from marathon group by agegroup, sex, state order by state) as ageGenderGroup) as participantsMaxGroup where maxParticipants = participantsGroup and maxParticipants != 1 order by state, agegroup, sex;


USE `MARATHON`;
-- MARATHON-4
-- Find the 30th fastest female runner. Report her overall place in the race, first name, and last name. This must be done using a single SQL query (which may be nested) that DOES NOT use the LIMIT clause. Think carefully about what it means for a row to represent the 30th fastest (female) runner.
select place, firstname, lastname from(select *, row_number() over() as Rnum from marathon where sex = 'F' order by Runtime) as fastestRunner where Rnum = 30;


USE `MARATHON`;
-- MARATHON-5
-- For each town in Connecticut report the total number of male and the total number of female runners. Both numbers shall be reported on the same line. If no runners of a given gender from the town participated in the marathon, report 0. Sort by number of total runners from each town (in descending order) then by town.

With maleRunners as(select *,count(firstname) as Mcount from marathon where state = 'CT' and sex = 'M' group by town),
FemaleRunners as(select *,count(firstname) as Fcount from marathon where state = 'CT' and sex = 'F' group by town),
allParticipants as(select * from marathon where state = 'CT' group by town)

select COALESCE(maleRunners.town,allParticipants.town,FemaleRunners.town) as town , COALESCE(Mcount, 0) as maleCounter, COALESCE(Fcount, 0) as FemaleCounter from maleRunners right join allParticipants on maleRunners.town = allParticipants.town left join FemaleRunners on FemaleRunners.town = allParticipants.town order by (maleCounter + FemaleCounter) desc, town ;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report the first name of the performer who never played accordion.

WITH accordionPlayer as(select firstname,id from Band join Instruments on Band.id = Instruments.bandmate join Performance on Performance.Bandmate = Band.id where Instruments.instrument = 'accordion' group by Band.id, Instruments.instrument)

select firstName from Band ap where Not exists (select * from accordionPlayer a2 where ap.id = a2.id);


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report, in alphabetical order, the titles of all instrumental compositions performed by Katzenjammer ("instrumental composition" means no vocals).

select title from(select *, COALESCE(Song, 0) as unknowVocal from Songs left join Vocals on Songs.songid = Vocals.song) as updateSong where unknowVocal = 0;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- Report the title(s) of the song(s) that involved the largest number of different instruments played (if multiple songs, report the titles in alphabetical order).
select title from(select *, max(numOfInstruments) from(select *, count(Instruments.instrument) as numOfInstruments from Songs join Instruments on Songs.songid = Instruments.song group by Songs.songid order by numOfInstruments Desc) as Instrumentsnumber) as maxInstrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find the favorite instrument of each performer. Report the first name of the performer, the name of the instrument, and the number of songs on which the performer played that instrument. Sort in alphabetical order by the first name, then instrument.

with favInstrument as(select Bandmate, Instrument from(select *,max(instrumentPlayer) over(partition by Bandmate) as maxplayed from(select *,count(Instruments.instrument) as instrumentPlayer from Songs join Band on Songs.songid = Band.id join Instruments on Instruments.Bandmate = Band.id group by Band.id, Instruments.instrument) as instrumentPlayers) as favInstrument where maxplayed = instrumentPlayer)

select firstname,Instruments.instrument,count(Instruments.song) from Band join Instruments on Band.id = Instruments.bandmate join favInstrument on favInstrument.bandmate = Band.id
where favInstrument.instrument = Instruments.instrument
group by Instruments.instrument, Band.id order by Band.firstname, Instruments.instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments played ONLY by Anne-Marit. Report instrument names in alphabetical order.
with playerInstrument as (select Instruments.instrument as annInstrument from Band join Instruments on Instruments.Bandmate = Band.id where Band.firstname = 'Anne-Marit' group by Band.id, Instruments.instrument),
allplayers as (select Instruments.instrument as allInstrument from Band join Instruments on Instruments.Bandmate = Band.id where Band.firstname != 'Anne-Marit' group by Band.id, Instruments.instrument)

select annInstrument from(select *,COALESCE(allinstrument, 'unknown') as selectedInstrument from playerInstrument left join allplayers on annInstrument = allInstrument) as selInstrument where selectedInstrument = 'unknown';


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Report, in alphabetical order, the first name(s) of the performer(s) who played the largest number of different instruments.

with multipleInstruments as (select distinct Band.id, Band.firstname, Band.lastname, Instruments.instrument from Band join Instruments on Band.id = Instruments.Bandmate group by Band.id, Instruments.instrument)

select firstname from(select *,max(maxInstrument) over() as mostPLayer from(select *, count(multipleInstruments.instrument) as maxInstrument from multipleInstruments group by multipleInstruments.id) as maxPlayer)as selPLayers where mostPLayer = maxInstrument order by firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Which instrument(s) was/were played on the largest number of songs? Report just the names of the instruments, sorted alphabetically (note, you are counting number of songs on which an instrument was played, make sure to not count two different performers playing same instrument on the same song twice).
with intrumentOnSongs as(select distinct song, instrument from Songs join Instruments on Songs.songid = Instruments.song)

select instrument from(select *, max(numOfTimes) over() as maxPlayed from(select *, count(song) as numOfTimes from intrumentOnSongs group by instrument)as maxPlayedInstrument) as playMax where maxPlayed = numOfTimes;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Who spent the most time performing in the center of the stage (in terms of number of songs on which she was positioned there)? Return just the first name of the performer(s), sorted in alphabetical order.

select firstname from(select *,Max(numTimes) over() as maxedPer from(select *, count(song) as numTimes from Band join Performance on Band.id = Performance.Bandmate join Songs on Songs.songid = Performance.song where Performance.stagePosition = 'center' group by Band.id) as performedMax) as maxedOut where maxedPer = numTimes order by firstname;


