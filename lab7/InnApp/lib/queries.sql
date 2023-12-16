--  part 1 queries
---------------------------------------------------------------------------------------------------------------
-- 1) popularity query data
-- query with assumption that previous 180 days starts from the latest checkout room date
with recentDataStay as (select * from (select *, max(reservations.checkout) over(partition by rooms.roomcode) as mostRecentDate from rooms join reservations on rooms.roomcode = reservations.room) as mostRecentData where mostRecentData.checkout >= mostRecentDate - INTERVAL 180 DAY) select roomcode, roomname, Beds, bedtype, maxOcc, basePrice, decor, round(sum(occupied_days)/180, 2) as roomPopularity from (SELECT *, CASE WHEN recentDataStay.checkin < recentDataStay.mostRecentDate - INTERVAL 180 DAY THEN DATEDIFF(recentDataStay.checkout, recentDataStay.mostRecentDate - INTERVAL 180 DAY) ELSE DATEDIFF(recentDataStay.checkout, recentDataStay.checkin) END AS occupied_days FROM recentDataStay) as occupiedDaysDATA group by roomcode order by roomPopularity DESC;
-- with recentDataStay as(select * from(select *,max(reservations.checkout) over(partition by rooms.roomcode) as mostRecentDate from rooms join reservations on rooms.roomcode = reservations.room) as mostRecentData where mostRecentData.checkout >= mostRecentDate - INTERVAL 180 DAY)


-- select roomcode, roomname,Beds,bedtype,maxOcc,basePrice,decor, round(sum(occupied_days)/180, 2) as roomPopularity from(SELECT *,
--     CASE 
--         WHEN recentDataStay.checkin < recentDataStay.mostRecentDate - INTERVAL 180 DAY 
--         THEN DATEDIFF(recentDataStay.checkout, recentDataStay.mostRecentDate - INTERVAL 180 DAY)
--         ELSE DATEDIFF(recentDataStay.checkout, recentDataStay.checkin)
--     END AS occupied_days
-- FROM recentDataStay) as occupiedDaysDATA group by roomcode order by roomPopularity DESC;

-- 2) Next checkin availaible date
-- assumption: the first available date room is available after the earliest recorded reservation for the room

select roomcode, (checkin - Interval dayDiffdata DAY) as nextCheckin  from(
    select *,DATEDIFF(checkin, prevCheckoutUpData) as dayDiffdata from(
        select *, COALESCE(prevCheckout, checkin) as prevCheckoutUpData from(
            select *,lag(checkout) over(partition by room order by checkout) 
            as prevCheckout from rooms join reservations on rooms.roomcode = reservations.room) 
        as prevCheckoutData) 
    as currUpdateData) 
as nextAvailableCheckin where dayDiffdata > 1 group by room;

-- select *, (checkin - Interval dayDiffdata DAY)  from(
--     select *,DATEDIFF(checkin, prevCheckoutUpData) as dayDiffdata from(
--         select *, COALESCE(prevCheckout, checkin) as prevCheckoutUpData from(
--             select *,lag(checkout) over(partition by room order by checkout) 
--             as prevCheckout from rooms join reservations on rooms.roomcode = reservations.room) 
--         as prevCheckoutData) 
--     as currUpdateData) 
-- as nextAvailableCheckin where dayDiffdata > 1 group by room;

-- 3) Length in days and check out date of the most recent (completed) stay in the room.
-- assuming the last checkout of each room

select DATEDIFF(checkout,checkin) as lengthInDays, checkout as mostRecentCheckout,roomcode from(select *,max(reservations.checkout) over(partition by room) as maxCheckout from rooms join reservations on rooms.roomcode = reservations.room) as recentStay where maxCheckout = checkout

-- FR2



-- FR3 Reservation Cancellation
select * from reservations

-- delete from the table based on the required reservations
DELETE FROM reservations WHERE given_reserv_code;


-- FR4 Detailed Reservation Information
select code,room,checkin,checkout,rate,lastname,firstname,adults,kids,roomname,decor from rooms join reservations on reservations.room = rooms.roomcode where 1=1


-- FR5 Revenue information
    -- split month one
select *,sum(secondMonthPrice) as setPrice from (select room as checkoutRoom,checkoutMonth, (checkoutDays * rate) as secondMonthPrice from (select *, case When DATEDIFF(maxCheckinDate,checkin) = 0 then 1 ELSE DATEDIFF(maxCheckinDate,checkin) END as checkinDays, case WHEN DATEDIFF(checkout,minCheckoutDate) = 0 then 1 ELSE DATEDIFF(checkout,minCheckoutDate) END as checkoutDays from (select *,LAST_DAY(checkin) as maxCheckinDate, LAST_DAY(checkout) - INTERVAL (DAY(LAST_DAY(checkout)) - 1) DAY AS minCheckoutDate from (select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth != checkoutMonth) as minMaxDays) as daysofMonth) as checkoutData group by checkoutRoom,checkoutMonth;
    -- split month two
select *,sum(firstMonthPrice) as checkinMonthPrice from (select room as checkinRoom,checkinMonth,(checkinDays * rate) as firstMonthPrice from (select *, case When DATEDIFF(maxCheckinDate,checkin) = 0 then 1 ELSE DATEDIFF(maxCheckinDate,checkin) END as checkinDays, case WHEN DATEDIFF(checkout,minCheckoutDate) = 0 then 1 ELSE DATEDIFF(checkout,minCheckoutDate) END as checkoutDays from (select *,LAST_DAY(checkin) as maxCheckinDate, LAST_DAY(checkout) - INTERVAL (DAY(LAST_DAY(checkout)) - 1) DAY AS minCheckoutDate from (select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth != checkoutMonth) as minMaxDays) as daysofMonth) as checkinData group by checkinRoom, checkinMonth
-- non split moth price
select *,sum(spentMoney) as expectedMoney from(select room,checkinMonth,daysSpent*rate as spentMoney from(select *,DATEDIFF(checkout,checkin) as daysSpent from(select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth = checkoutMonth) as daysCounted) as priceMoney group by room, checkinMonth

-- total room price
select room,sum(amountPaid) as totalRoomPrice from(select *,days*rate as amountPaid from(select *,DATEDIFF(checkout,checkin) as days from reservations) as daysSpend) as amountTaken group by room
;----------------------------------------------------------------------------------------------------------------


-- need to fetch the rooms that are booked within the specified range
SELECT * FROM rooms r1 WHERE NOT EXISTS (SELECT * FROM rooms JOIN reservations ON reservations.room = rooms.roomcode WHERE checkin >= '2010-10-08' AND checkout <= '2010-10-14' AND r1.roomcode = rooms.roomcode GROUP BY roomcode);

-- fetching the day based on the checkin and checkout date and the number of days
select * from(select *, (checkin - dateDelay) as openDay from (select *, COALESCE(prevCheckout,checkin) as dateDelay from (select *,lag(checkout,1) over(partition by room order by checkin) as prevCheckout from rooms join reservations on rooms.roomcode = reservations.room) as datesModi) as bookdays) oday where openDay >=4;