import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import DataStorage.ReservationsInfo;
import DataStorage.RoomInfo;

import java.sql.ResultSet;
import java.util.Scanner;


public class App{
    public static boolean exit;

    public boolean dataRoomFlag;
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

            exit = true;

            while (exit) {
                printOptions();
                getUserInput(DataRoom,connection);
                
            }


            connection.close(); // Close the connection when done
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }


    public static void printOptions() {
    System.out.println("Options: Enter the number of your choice");
    System.out.println("1) Rooms and Rates");
    System.out.println("2) Booking Reservation");
    System.out.println("3) Reservation Cancellation");
    System.out.println("4) Detailed Reservation Information");
    System.out.println("5) Revenue");
    System.out.println("6) Exit");
    }

    public static void getUserInput(RoomsData DataRoom,Connection connection) throws SQLException {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your choice: ");
        int choice = scanner.nextInt();

        // Process user input based on the chosen option
        switch (choice) {
            case 1:
                for(int i=0;i<DataRoom.suggestedRoom.size();i++){
                    RoomInfo tempData = DataRoom.suggestedRoom.get(i);
                    System.out.println("Room Code: " + tempData.getRoomCode());
                    System.out.println("Room Name: " + tempData.getRoomName());
                    System.out.println("Number of Beds: " + tempData.getBeds());
                    System.out.println("Bed Type: " + tempData.getBedType());
                    System.out.println("Max Occupancy: " + tempData.getMaxOcc());
                    System.out.println("Base Price: " + tempData.getBasePrice());
                    System.out.println("Decor: " + tempData.getDecor());
                    System.out.println("Room Popularity: " + tempData.getRoomPopularity());
                    System.out.println("Next Checkin Date: " + tempData.getNextCheckinDate());
                    System.out.println("Most Recent Checkout Date: " + tempData.getCheckOutdate());
                    System.out.println("Length of Stay: " + tempData.getLengthDays());
                    System.out.println("--------------------------------------------------");
                }
                break;
            case 2:
                // BookingReservation booking = new BookingReservation();
                // booking.Bookreservations(connection);
                System.out.print("Partially working");
                break;
            case 3:
                System.out.print("Enter the reservation code: ");
                int reservCode = scanner.nextInt();
                ReservationCancellation cancellation = new ReservationCancellation();
                cancellation.CancelReservation(connection, reservCode);
                break;
            case 4:
                System.out.print("Enter FirstName: ");
                String firstName = scanner.next();
                System.out.print("Enter LastName: ");
                String lastName = scanner.next();
                System.out.print("Enter Checkin Date: ");
                String checkin = scanner.next();
                System.out.print("Enter Checkout Date: ");
                String checkout = scanner.next();
                System.out.print("Enter Room Code: ");
                String RoomCode = scanner.next();
                System.out.print("Enter Reservation Code: ");
                String ReservationCode = scanner.next();

                Detailedreservation detailReserv = new Detailedreservation();
                detailReserv.DetailedReserv(connection, firstName, lastName, checkin, checkout, RoomCode, ReservationCode);
                break;
            case 5:
                RevenueInfo revInfo = new RevenueInfo();
                revInfo.calcRev(connection);
                break;
            case 6:
                System.out.println("Exiting...");
                exit = false;
                break;
            default:
                System.out.println("Invalid choice!");
                break;
        }

        scanner.close();
    }
}

