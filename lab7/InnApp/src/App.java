import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import DataStorage.ReservationsInfo;
import DataStorage.RoomInfo;

import java.sql.ResultSet;


public class App{
    public static void main(String[] args) {
        String url = System.getenv("HP_JDBC_URL");
        String username = System.getenv("HP_JDBC_USER");
        String password = System.getenv("HP_JDBC_PW");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to the database!");

            //SQL statement
            Statement statement = connection.createStatement();
            //switch the data base to INN
            String query = "USE INN";
            ResultSet resultset = statement.executeQuery(query);

            // 1) Rooms and Rates-----------------------------------------------------------------
            RoomsData DataRoom = new RoomsData();
            
            //popularity query
            query = "with recentDataStay as (select * from (select *, max(reservations.checkout) over(partition by rooms.roomcode) as mostRecentDate from rooms join reservations on rooms.roomcode = reservations.room) as mostRecentData where mostRecentData.checkout >= mostRecentDate - INTERVAL 180 DAY) select roomcode, roomname, Beds, bedtype, maxOcc, basePrice, decor, round(sum(occupied_days)/180, 2) as roomPopularity from (SELECT *, CASE WHEN recentDataStay.checkin < recentDataStay.mostRecentDate - INTERVAL 180 DAY THEN DATEDIFF(recentDataStay.checkout, recentDataStay.mostRecentDate - INTERVAL 180 DAY) ELSE DATEDIFF(recentDataStay.checkout, recentDataStay.checkin) END AS occupied_days FROM recentDataStay) as occupiedDaysDATA group by roomcode order by roomPopularity DESC;";
            resultset = statement.executeQuery(query);
            while(resultset.next()){
                RoomInfo info = new RoomInfo();
                info.setRoomCode(resultset.getString("RoomCode"));
                info.setRoomName(resultset.getString("RoomName"));
                info.setBeds(resultset.getInt("Beds"));
                info.setBedType(resultset.getString("BedType"));
                info.setMaxOcc(resultset.getInt("MaxOcc"));
                info.setBasePrice(resultset.getInt("BasePrice"));
                info.setDecor(resultset.getString("Decor"));
                info.setRoomPopularity(resultset.getFloat("RoomPopularity"));
                //adding data to the RoomsData
                DataRoom.newRoomInfo(info);
            }
            //next availaible checkin date
            query = "select roomcode, (checkin - Interval dayDiffdata DAY) as nextCheckin from (select *, DATEDIFF(checkin, prevCheckoutUpData) as dayDiffdata from (select *, COALESCE(prevCheckout, checkin) as prevCheckoutUpData from (select *, lag(checkout) over(partition by room order by checkout) as prevCheckout from rooms join reservations on rooms.roomcode = reservations.room) as prevCheckoutData) as currUpdateData) as nextAvailableCheckin where dayDiffdata > 1 group by room;";
            resultset = statement.executeQuery(query);
            while(resultset.next()){
                String RoomCode = resultset.getString("RoomCode");
                String nextCheckIn = resultset.getString("nextCheckIn");
                
                //setting this info based on the roomcode
                for(int i=0;i<DataRoom.suggestedRoom.size();i++){
                    RoomInfo tempData = DataRoom.suggestedRoom.get(i);
                    if(tempData.getRoomCode().equals(RoomCode)){
                        DataRoom.suggestedRoom.get(i).setNextCheckinDate(nextCheckIn);
                    }
                }
            }
            //more recent checkout date and daysSpent
            query = "select DATEDIFF(checkout,checkin) as lengthInDays, checkout as mostRecentCheckout,roomcode from(select *,max(reservations.checkout) over(partition by room) as maxCheckout from rooms join reservations on rooms.roomcode = reservations.room) as recentStay where maxCheckout = checkout;";
            resultset = statement.executeQuery(query);
            while(resultset.next()){
                String RoomCode = resultset.getString("RoomCode");
                String mostRecentCheckout = resultset.getString("mostRecentCheckout");
                int lengthInDays = resultset.getInt("lengthInDays");

                //setting this info based on the roomcode
                for(int i=0;i<DataRoom.suggestedRoom.size();i++){
                    RoomInfo tempData = DataRoom.suggestedRoom.get(i);
                    if(tempData.getRoomCode().equals(RoomCode)){
                        DataRoom.suggestedRoom.get(i).setCheckOutdate(mostRecentCheckout);
                        DataRoom.suggestedRoom.get(i).setLengthDays(lengthInDays);
                    }
                }
            }

            // 2) reservation requirement------------------------------------------------------------------------------------

            // 3) Cancel Reservation  ----------------------------------------------------------------------------
            // ReservationCancellation cancellation = new ReservationCancellation();
            // cancellation.CancelReservation(connection, 0);

            // 4) Detailed reservation information --------------------------------------------------------
            Detailedreservation detailReserv = new Detailedreservation();

            detailReserv.DetailedReserv(connection);

            // 5) revenue information --------------------------------------------------------
            RevenueInfo revInfo = new RevenueInfo();
            revInfo.calcRev(connection);


            connection.close(); // Close the connection when done
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}