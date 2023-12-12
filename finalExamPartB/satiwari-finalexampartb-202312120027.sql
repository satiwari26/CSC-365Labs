-- Final Exam Part b
-- satiwari
-- Dec 12, 2023

USE `satiwari`;
-- DDL-1
-- Define the following relations: book(isbn, title, author, pub_date), patron(id, first_name, last_name, sign_up), borrow(patron, book, check_out_date, due_date). Define constraints sufficient to pass all test cases.
create table borrow(
    patron int,
    book varchar(100),
    check_out_date DATE,
    due_date DATE,
    
    primary key(patron, book, check_out_date),
    Foreign key (patron) references patron(id),
    Foreign key (book) references book(isbn),
    CHECK (due_date > check_out_date)
);


USE `satiwari`;
-- DDL-2
-- Add a new relation: late_notice(patron, book, check_out_date, notice_date)  Define constraints sufficient to pass all test cases. You do not need to define any additional constraints beyond those exercised by the test cases.
create table late_notice(
    patron int,
    book varchar(100),
    check_out_date DATE,
    notice_date DATE,
    
    primary key(patron, book, notice_date),
    foreign key (patron, book, check_out_date) references borrow(patron, book, check_out_date)
);


USE `satiwari`;
-- DML-1
-- Add sample data to your library tables. Ensure that there are at least 6 "borrow" rows, 3 of which should represent patrons borrowing a book on their date of sign up (these need not be the same patron)  Also add 2 late notices.
INSERT INTO book (isbn, title, author, pub_date) VALUES
    ('111-222', 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10'),
    ('123-456', 'Readme', 'Tesla', '2018-09-12'),
    ('321-789', 'Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', '1998-06-26'),
    ('444-555', 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11'),
    ('456-789', 'Facebook', 'Meta', '2019-06-22'),
    ('556-488', 'github', 'Microsoft', '2020-01-12'),
    ('675-234', 'Lofi', 'LofiMusic', '2012-11-13'),
    ('777-888', '1984', 'George Orwell', '1949-06-08'),
    ('987-654', 'The Art of War', 'Sun Tzu', '2005-08-21');

INSERT INTO borrow (patron, book, check_out_date, due_date) VALUES
    (30, '123-456', '2022-11-24', '2022-12-24'),
    (35, '123-456', '2023-09-19', '2023-10-19'),
    (37, '444-555', '2023-12-19', '2024-01-18'),
    (43, '777-888', '2023-12-19', '2023-12-23'),
    (45, '987-654', '2020-09-01', '2020-10-01'),
    (49, '987-654', '2022-11-24', '2022-12-24');

INSERT INTO late_notice (patron, book, check_out_date, notice_date) VALUES
    (43, '777-888', '2023-12-19', '2024-01-06'),
    (49, '987-654', '2022-11-24', '2023-12-06');

INSERT INTO patron (id, first_name, last_name, sign_up) VALUES
    (30, 'Junior', 'Perez', '2019-09-01'),
    (35, 'Dhruv', 'Tiwari', '2023-09-19'),
    (37, 'Saumitra', 'Tiwari', '2023-12-19'),
    (43, 'Himani', 'Pandey', '2021-10-14'),
    (45, 'Saksham', 'Perez', '2020-09-01'),
    (49, 'Spencer', 'Selz', '2022-11-24');

USE `satiwari`;
-- DML-2
-- Write a single UPDATE statement to change the due date for all books borrowed on same day as the borrowing patron's sign-up. These due dates should be changed to exactly 30 days after patron sign-up. 
UPDATE borrow
SET due_date = check_out_date + INTERVAL 30 DAY
WHERE check_out_date = (SELECT sign_up FROM patron WHERE id = borrow.patron);

select * from borrow;


USE `BAKERY`;
-- BAKERY-1
-- Based on purchase count, which items(s) are more popular on Fridays than Mondays? Report food, flavor, and purchase counts for Monday and Friday as two separate columns. Report a count of 0 if a given item has not been purchased on that day. Sort by food then flavor, both in A-Z order.
With mondayset as(select items.item,DAYNAME(receipts.saledate) as dayPurchase1,count(receipts.rnumber) as monCount from goods join items on items.item = goods.gid join receipts on receipts.rnumber = items.receipt WHERE DAYNAME(receipts.saledate) IN ('Monday') group by dayPurchase1, items.item),
fridayset as(select goods.gid,goods.flavor, goods.food,DAYNAME(receipts.saledate) as dayPurchase,count(receipts.rnumber) as FriCount from goods join items on items.item = goods.gid join receipts on receipts.rnumber = items.receipt WHERE DAYNAME(receipts.saledate) IN ('friday') group by dayPurchase, items.item)


select food,flavor,updatedMonCount,friCount from(select *,COALESCE(monCount,0) as updatedMonCount from fridayset left join mondayset on fridayset.gid = mondayset.item) as countedval where updatedMonCount < friCount order by food, flavor;


USE `BAKERY`;
-- BAKERY-2
-- Find all pairs of customers who have purchased the exact same combination of cookie flavors. For example, customers with ID 1 and 10 have each purchased at least one Marzipan cookie and neither customer has purchased any other flavor of cookie. Report each pair of customers just once, sort by the numerically lower customer ID. The MySQL-specific GROUP_CONCAT and JSON_ARRAYAGG functions are not permitted.
with customerFood1 as(select lastname,firstname,  customer,item from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt join customers on customers.cid = receipts.customer where food = 'cookie' group by goods.gid,customers.cid),

customer1_items as(select *,count(item) over(partition by customer) as cust1Pur from customerFood1),
customer2_items as(select *,count(item) over(partition by customer) as cust2Pur from customerFood1),

customerInfo as(select c1.cid as c1CID, c1.firstname as c1first, c1.lastname as c1last,c2.cid as c2CID, c2.firstname as c2first, c2.lastname as c2last from customers c1 cross join customers c2)

SELECT c1cid,c1last,c1first,c2cid,c2last,c2first
FROM (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY uniqueId ORDER BY uniqueId) AS rowNumber
    FROM (
        SELECT
            ABS(cus2 - cus1) AS uniqueId,
            cus2,
            cus1,
            cust2Pur
        FROM (
            SELECT
                customer2_items.customer AS cus2,
                customer1_items.customer AS cus1,
                customer2_items.item,
                cust2Pur,
                cust1Pur
            FROM
                customer2_items
            JOIN
                customer1_items ON customer1_items.item = customer2_items.item
            WHERE
                customer1_items.customer != customer2_items.customer
                AND cust2Pur = cust1Pur
        ) AS sameNumItem
        GROUP BY
            cus1, cus2
        HAVING
            COUNT(item) = cust2Pur
    ) AS assignedRow
) AS orderedRow join customerInfo on cus1 = c1CID and cus2 = c2CID
WHERE
    rowNumber = 1 order by c1cid;


USE `BAKERY`;
-- BAKERY-3
-- For each date between October 8th, 2007 and October 31st, 2007, show the absolute difference in spend compared to a week before. For example, if October 8th had $50.00 more in spend than October 1st, you'd print "October 8th, 2007, 50.00".
select DATE_FORMAT(saleDate, '%M %D, %Y') AS formatted_date,Round((currSum - prevWeekPrice),2) as diffPrice from(select *, LAG(currSum,7) over() as prevWeekPrice from(select *, sum(goods.price) as currSum from goods join items on goods.gid = items.item join receipts on receipts.rnumber = items.receipt group by receipts.saledate order by receipts.saledate) as currentPrice) as prevPrice where saledate >= '2007-10-08' and saledate <= '2007-10-31';


USE `AIRLINES`;
-- AIRLINES-1
-- Find the number of different destinations that can be reached starting from airport ABQ, flying a one-transfer route with both flights on the same airline. Report a single integer: the number of destinations.
with connectingflight as (select * from airlines join flights on flights.airline = airlines.id)

select max(totalDes) from(select count(connectingflight.destination) over() as totalDes from airlines join flights on flights.airline = airlines.id join (connectingflight) on connectingflight.airline = flights.airline where flights.source = 'ABQ' and flights.destination = connectingflight.source and connectingflight.destination != 'ABQ' group by connectingflight.destination) as numDest;


USE `AIRLINES`;
-- AIRLINES-2
-- List all airlines. For every airline, compute the number of regional airports (full name of airport contains the string 'Regional') from which that airline does NOT fly, considering source airport only. Sort by airport count in descending order.
select AName,(Allregional - selectedRegional) as nonregionalFlights from(select * from(SELECT ap.name as apName, a.name as AName, a.id as AId, f2.source as f2Source,count(f2.source) over(partition by a.id) as selectedRegional
    FROM airlines a
    JOIN flights f2 ON f2.airline = a.id
    JOIN airports ap ON f2.source = ap.code
    WHERE 
        ap.name LIKE '%Regional%' 
    group by f2.source, a.id) as RegionalAirport cross join (select *,count(airports.name) over() as Allregional from airports where airports.name like '%Regional%') as Allregional) as nonRegionalAirline group by Aid order by nonregionalFlights DESC, AName;


USE `AIRLINES`;
-- AIRLINES-3
-- List all airports from which airline Southwest operates more flights than Northwest. Include only airports that have at least one outgoing flight on Southwest and at least one on Northwest. List airport code along with counts for each airline as two separate columns. Order by source airport code.
with southwestAirlines as(select abbr,source,flightNo,count(flights.flightNo) as southWestCount from airlines join flights on airlines.id = flights.airline join airports on airports.code = flights.source where airlines.abbr = 'southwest' group by flights.source,airlines.abbr),
northwestAirlines as (select abbr,source,flightNo,count(flights.flightNo) as northWestCount from airlines join flights on airlines.id = flights.airline join airports on airports.code = flights.source where airlines.abbr = 'northwest' group by flights.source,airlines.abbr)

select northwestAirlines.source, southWestCount,northWestCount  from northwestAirlines join southwestAirlines on southwestAirlines.source = northwestAirlines.source where southWestCount > northWestCount order by northwestAirlines.source;


USE `INN`;
-- INN-1
-- Find all reservations in room HBB that overlap by at least one day with any stay by customer with last name KNERIEN. Last last and first name along with checkin and checkout dates. Sort by check in date in chronological order.
with KNERIENreservation as(select reservations.checkin as Kcheckin,reservations.checkout as Kcheckout from rooms join reservations on reservations.room = rooms.roomcode where reservations.lastName = 'KNERIEN'),

existReserv as (select reservations.lastname, reservations.firstname, reservations.checkin,reservations.checkout, Kcheckin, Kcheckout from rooms join reservations on reservations.room = rooms.roomcode cross join KNERIENreservation where rooms.roomcode = 'HBB' and not((reservations.checkout <= Kcheckin) or (Kcheckout <= reservations.checkin)))

select lastname, firstname, checkin, checkout from existReserv order by checkin;


USE `INN`;
-- INN-2
-- Find all rooms that are unoccupied on both the night of March 20, 2010 and every night during the date range March 12, 2010 through March 14, 2010 (inclusive). List room code and room name, sort by room code A-Z.
with unregRoom as(select * from rooms join reservations on rooms.roomcode = reservations.room where (reservations.checkout <= '2010-03-12' or reservations.checkin > '2010-03-14') and (reservations.checkout < '2010-03-20' or reservations.checkin > '2010-03-20')),

regRoom as(select roomcode from(select unregRoom.roomcode as unregRoomCode, allRooms.roomcode,allRooms.checkin, allRooms.checkout, COALESCE(unregRoom.roomcode, 'rev') AS occupiedRoom from unregRoom right join (select * from rooms join reservations on rooms.roomcode = reservations.room) as allRooms on unregRoom.checkin = allRooms.checkin and allRooms.checkout = unregRoom.checkout) as respondRoom where occupiedRoom = 'rev' group by roomcode)

select roomcode,Roomname from rooms where not exists (select * from regRoom where regRoom.roomcode = rooms.roomcode);


USE `INN`;
-- INN-3
-- Group all stays by the percent difference from rate was from the base price. For each grouping, list the percent difference (e.g., 15% off the base price would show as -15) and the total number of days with that percent difference. Sort the results by the total number of days in ascending order. 
select percentage, sum(day_count) as totalDays from(select *, ((reservations.rate - rooms.baseprice)/rooms.baseprice)*100 as percentage, DATEDIFF(reservations.checkout, reservations.checkin) AS day_count from reservations join rooms on rooms.roomcode = reservations.room) as percentageCumulative group by percentage order by totalDays;


