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



----------------------------------------------------------------------------------------------------------------