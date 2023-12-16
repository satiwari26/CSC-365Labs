import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import DataStorage.DetailReservationInfo;
import DataStorage.RoomInfo;

public class BookingReservation {
    private String firstName;
    private String lastName;
    private String roomCode;
    private String bedType;
    private String beginDate;
    private String endDate;
    private int numChildren;
    private int numAdult;

    void Bookreservations(Connection connection) throws SQLException {
        ArrayList<RoomInfo> suggestedRooms = new ArrayList<RoomInfo>(); //room list developed based on the data specified

        this.firstName = "John";
        this.lastName = "Doe";
        this.roomCode = "FNA";
        this.bedType = "Single";
        this.beginDate = "2010-03-09";
        this.endDate = "2010-03-14";
        this.numChildren = 2;
        this.numAdult = 2;

        boolean roomSpecifiedBydate = false; //if the room is availaible specified by the date

        //fetch the rooms availaible based on the data specified
        StringBuilder query = new StringBuilder("SELECT * FROM rooms r1 WHERE NOT EXISTS (SELECT * FROM rooms JOIN reservations ON reservations.room = rooms.roomcode WHERE checkin >= ? AND checkout <= ? AND r1.roomcode = rooms.roomcode GROUP BY roomcode);");
        ArrayList<RoomInfo> availaibleRooms = new ArrayList<RoomInfo>();    //store the availaible rooms for specified date

        ArrayList<DetailReservationInfo> reserVationSuggestions = new ArrayList<DetailReservationInfo>(); //storing suggested reservations based on date matched
        
        PreparedStatement statement = connection.prepareStatement(query.toString());
        statement.setString(1, this.beginDate);
        statement.setString(2, this.endDate);
        ResultSet resultset = statement.executeQuery();
        while(resultset.next()){
            roomSpecifiedBydate = true;
            RoomInfo info = new RoomInfo();
            info.setRoomCode(resultset.getString("RoomCode"));
            info.setRoomName(resultset.getString("RoomName"));
            info.setBeds(resultset.getInt("Beds"));
            info.setBedType(resultset.getString("BedType"));
            info.setMaxOcc(resultset.getInt("MaxOcc"));
            info.setBasePrice(resultset.getInt("BasePrice"));
            info.setDecor(resultset.getString("Decor"));
            availaibleRooms.add(info);
        }

        //specified date matches the availaible rooms flag
        boolean dateMatchesBased = false;

        if(roomSpecifiedBydate){//room availaible based on the date
            //if the room code is not specified, then we provide suggestions or the best options
            if(this.roomCode.equals("")){

                String chosenRoom = ""; //if user decides to confirm the reservation then this is the room he chose

                //if the room code is specified, then we need to check if the room is availaible
                boolean roomAvailaible = false;
                //to display only 5 availaible rooms that are present
                for(int i=0;i<availaibleRooms.size();i++){
                    if(this.numChildren + this.numAdult <= availaibleRooms.get(i).getMaxOcc()){
                        roomAvailaible = true;
                        chosenRoom = availaibleRooms.get(i).getRoomCode();
                        break;
                    }
                }
                if(!roomAvailaible){
                    System.out.println("The room is not availaible for the specified number of people \n");
                    for(int i=0;i<availaibleRooms.size();i++){
                        suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                        dateMatchesBased = true;
                    }
                    return;
                }

                //if the room is availaible, check bed compatibility
                if(!this.bedType.equals("") && roomAvailaible){
                    boolean bedAvailaible = false;
                    for(int i=0;i<availaibleRooms.size();i++){
                        if(this.bedType.equals(availaibleRooms.get(i).getBedType())){
                            bedAvailaible = true;
                            break;
                        }
                    }
                    if(!bedAvailaible){
                        System.out.println("The room is not availaible for the specified beds \n");
                        for(int i=0;i<availaibleRooms.size();i++){
                            suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                            dateMatchesBased = true;
                        }
                        return;
                    }

                    //if bed is compatible, ask user to confirm the reservation or exit
                    if(bedAvailaible){
                        System.out.println("The room is availaible for the specified date \n");
                        System.out.println("Do you want to confirm the reservation? (Y/N)");
                        Scanner scanner = new Scanner(System.in);
                        String confirm = scanner.nextLine();
                        if(confirm.equals("Y")){
                            //insert the reservation into the database
                            query = new StringBuilder("INSERT INTO reservations (CODE, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);");
                            statement = connection.prepareStatement(query.toString());
                            statement.setString(1, generateCode()); //generate a random code for the reservation
                            statement.setString(2, chosenRoom); //set manually the room he chose
                            statement.setString(3, this.beginDate);
                            statement.setString(4, this.endDate);
                            statement.setInt(5, 100);
                            statement.setString(6, this.lastName);
                            statement.setString(7, this.firstName);
                            statement.setInt(8, this.numAdult);
                            statement.setInt(9, this.numChildren);
                            statement.executeUpdate();
                            System.out.println("Reservation confirmed \n");
                            scanner.close(); //close this scanner
                        }
                        else{
                            System.out.println("Reservation cancelled \n");
                        }
                    }
                }
                else if(roomAvailaible && this.bedType.equals("")){ //no specific bed type is provided
                    for(int i=0;i<availaibleRooms.size();i++){
                        suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                        dateMatchesBased = true;
                    }
                }
            }
            if(!this.roomCode.equals("")){ //if user did specified the room code
                for(int i=0; i<availaibleRooms.size();i++){
                    if(this.roomCode.equals(availaibleRooms.get(i).getRoomCode())){
                        //if the room code is specified, then we need to check if the room is availaible
                        boolean roomAvailaible = false;
                        String chosenRoom = ""; //if user decides to confirm the reservation then this is the room he chose
                        for(int t=0;t<availaibleRooms.size();t++){
                            if(this.numChildren + this.numAdult <= availaibleRooms.get(t).getMaxOcc()){
                                roomAvailaible = true;
                                chosenRoom = availaibleRooms.get(t).getRoomCode();
                                break;
                            }
                        }
                        if(!roomAvailaible){
                            System.out.println("The room is not availaible for the specified number of people \n");
                            for(int t=0;t<availaibleRooms.size();t++){
                                suggestedRooms.add(availaibleRooms.get(t)); //add the rooms to the suggested list
                                dateMatchesBased = true;
                            }
                            return;
                        }

                        //if the room is availaible, check bed compatibility
                        if(!this.bedType.equals("") && roomAvailaible){
                            boolean bedAvailaible = false;
                            for(int t=0;t<availaibleRooms.size();t++){
                                if(this.bedType.equals(availaibleRooms.get(t).getBedType())){
                                    bedAvailaible = true;
                                    break;
                                }
                            }
                            if(!bedAvailaible){
                                suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                                dateMatchesBased = true;
                            }

                            //if bed is compatible, ask user to confirm the reservation or exit
                            if(bedAvailaible){
                                System.out.println("The room is availaible for the specified date \n");
                                System.out.println("Do you want to confirm the reservation? (Y/N)");
                                Scanner scanner = new Scanner(System.in);
                                String confirm = scanner.nextLine();
                                if(confirm.equals("Y")){
                                    //insert the reservation into the database
                                    query = new StringBuilder("INSERT INTO reservations (CODE, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);");
                                    statement = connection.prepareStatement(query.toString());
                                    statement.setString(1, generateCode()); //generate a random code for the reservation
                                    statement.setString(2, chosenRoom); //set manually the room he chose
                                    statement.setString(3, this.beginDate);
                                    statement.setString(4, this.endDate);
                                    statement.setInt(5, 100);
                                    statement.setString(6, this.lastName);
                                    statement.setString(7, this.firstName);
                                    statement.setInt(8, this.numAdult);
                                    statement.setInt(9, this.numChildren);
                                    statement.executeUpdate();
                                    System.out.println("Reservation confirmed \n");
                                    scanner.close(); //close this scanner
                                }
                                else{
                                    System.out.println("Reservation cancelled \n");
                                }
                            }
                        }
                        else if(roomAvailaible && this.bedType.equals("")){ //no specific bed type is provided
                                suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                                dateMatchesBased = true;
                        }
                    }
                    else{
                        suggestedRooms.add(availaibleRooms.get(i)); //add the rooms to the suggested list
                        dateMatchesBased = true;
                    }
                }
            }
        }
        else{   //suggesting rooms closes to the number of days asked for reservation
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // Parse the strings to LocalDate objects
            LocalDate date1 = LocalDate.parse(this.beginDate, formatter);
            LocalDate date2 = LocalDate.parse(this.endDate, formatter);
    
            // Calculate the difference between the dates - will use this to find the reservation availability
            int daysBetween = (int)ChronoUnit.DAYS.between(date1, date2);
            query = new StringBuilder("select * from(select *, (checkin - dateDelay) as openDay from (select *, COALESCE(prevCheckout,checkin) as dateDelay from (select *,lag(checkout,1) over(partition by room order by checkin) as prevCheckout from rooms join reservations on rooms.roomcode = reservations.room) as datesModi) as bookdays) oday where openDay >=?");
            statement = connection.prepareStatement(query.toString());
            statement.setInt(1, daysBetween);
            resultset = statement.executeQuery();
            while (resultset.next()) {
                DetailReservationInfo rinfo = new DetailReservationInfo();
                rinfo.setRoom(resultset.getString("RoomCode"));
                rinfo.setCheckin(resultset.getString("dateDelay"));
                rinfo.setCheckout(resultset.getString("checkin"));
                rinfo.setRate(resultset.getFloat("Rate"));

                reserVationSuggestions.add(rinfo);
            }

        }

        //suggesting based on the matched data
        if(roomSpecifiedBydate){
            int matchingDisplay = 5; //display only 5 matching results
            if(reserVationSuggestions.size() > 5){
                matchingDisplay = 5;
            }
            else{
                matchingDisplay = reserVationSuggestions.size();
            }
            System.out.println("Suggested reservations based on the data provided: \n");
            for(int i=0;i<matchingDisplay;i++){
                System.out.println("Room: " + reserVationSuggestions.get(i).getRoom() + " Checkin: " + reserVationSuggestions.get(i).getCheckin() + " Checkout: " + reserVationSuggestions.get(i).getCheckout() + " Rate: " + reserVationSuggestions.get(i).getRate());
            }
        }
        else if(dateMatchesBased){
            int matchingDisplay = 5; //display only 5 matching results
            if(suggestedRooms.size() > 5){
                matchingDisplay = 5;
            }
            else{
                matchingDisplay = suggestedRooms.size();
            }
            System.out.println("Suggested rooms based on the data provided: \n");
            for(int i=0;i<matchingDisplay;i++){
                System.out.println("Room: " + suggestedRooms.get(i).getRoomCode() + " Room Name: " + suggestedRooms.get(i).getRoomName() + " Beds: " + suggestedRooms.get(i).getBeds() + " Bed Type: " + suggestedRooms.get(i).getBedType() + " Max Occ: " + suggestedRooms.get(i).getMaxOcc() + " Base Price: " + suggestedRooms.get(i).getBasePrice() + " Decor: " + suggestedRooms.get(i).getDecor());
            }
        }
        else{
            System.out.println("No rooms availaible for the specified date \n");
        }



    }

// function that generates random 6 digit code
    public static String generateCode() {
        String code = "";
        for (int i = 0; i < 6; i++) {
            code += (int) (Math.random() * 10);
        }
        return code;
    }


    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getRoomCode() {
        return roomCode;
    }

    public void setRoomCode(String roomCode) {
        this.roomCode = roomCode;
    }

    public String getBedType() {
        return bedType;
    }

    public void setBedType(String bedType) {
        this.bedType = bedType;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getNumChildren() {
        return numChildren;
    }

    public void setNumChildren(int numChildren) {
        this.numChildren = numChildren;
    }

    public int getNumAdult() {
        return numAdult;
    }

    public void setNumAdult(int numAdult) {
        this.numAdult = numAdult;
    }
}
