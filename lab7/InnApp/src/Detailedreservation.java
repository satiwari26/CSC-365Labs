import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DataStorage.DetailReservationInfo;

public class Detailedreservation {
    private String firstName;
    private String lastName;
    private String checkin;
    private String checkout;
    private String RoomCode;
    private String ReservationCode;

    public void DetailedReserv (Connection connection) throws SQLException{

        this.setFirstName("RHEA");
        this.setLastName("");
        this.setcheckin("");
        this.setcheckout("");
        this.setRoomCode("");
        this.setReservationCode("");


        ArrayList<DetailReservationInfo> reservinfo = new ArrayList<DetailReservationInfo>();

        StringBuilder query = new StringBuilder("select code,room,checkin,checkout,rate,lastname,firstname,adults,kids,roomname,decor from rooms join reservations on reservations.room = rooms.roomcode where 1=1");

        if (!this.firstName.isEmpty()) {
            query.append(" AND firstname LIKE ?");
        }

        if (!this.lastName.isEmpty()) {
            query.append(" AND lastname LIKE ?");
        }

        if (!this.checkin.isEmpty()) {
            query.append(" AND checkin >= ?");
        }

        if (!this.checkout.isEmpty()) {
            query.append(" AND checkout <= ?");
        }

        if (!this.RoomCode.isEmpty()) {
            query.append(" AND roomcode LIKE ?");
        }

        if (!this.ReservationCode.isEmpty()) {
            query.append(" AND code LIKE ?");
        }

        PreparedStatement stmt = connection.prepareStatement(query.toString());

        int index = 1;
        if (!this.firstName.isEmpty()) {
            stmt.setString(index++, "%" + firstName + "%");
        }

        if (!this.lastName.isEmpty()) {
            stmt.setString(index++, "%" + lastName + "%");
        }

        if (!this.checkin.isEmpty() && !this.checkout.isEmpty()) {
            stmt.setString(index++, this.checkin);
            stmt.setString(index++, this.checkout);
        }

        if (!this.RoomCode.isEmpty()) {
            stmt.setString(index++, "%" + this.RoomCode + "%");
        }

        if (!this.ReservationCode.isEmpty()) {
            stmt.setString(index++, "%" + this.ReservationCode + "%");
        }

        ResultSet result = stmt.executeQuery();
        boolean hasRows = false;

        while(result.next()){
            hasRows = true;
            DetailReservationInfo detailInfo = new DetailReservationInfo();
            detailInfo.setCode(result.getInt("code"));
            detailInfo.setRoom(result.getString("room"));
            detailInfo.setCheckin(result.getString("checkin"));
            detailInfo.setCheckout(result.getString("checkout"));
            detailInfo.setRate(result.getFloat("rate"));
            detailInfo.setLastname(result.getString("lastname"));
            detailInfo.setFirstname(result.getString("firstname"));
            detailInfo.setAdults(result.getInt("adults"));
            detailInfo.setKids(result.getInt("kids"));
            detailInfo.setRoomname(result.getString("roomname"));
            detailInfo.setDecor(result.getString("decor"));

            reservinfo.add(detailInfo);
        }

        System.out.println(reservinfo);

        if(!hasRows){
            System.out.println("No such data set is found in the database");
        }
    }


    //getter and setter function for all the fields
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

    public String getcheckin() {
        return checkin;
    }

    public void setcheckin(String checkin) {
        this.checkin = checkin;
    }

    public String getcheckout() {
        return checkout;
    }

    public void setcheckout(String checkout) {
        this.checkout = checkout;
    }

    public String getRoomCode() {
        return RoomCode;
    }

    public void setRoomCode(String roomCode) {
        RoomCode = roomCode;
    }

    public String getReservationCode() {
        return ReservationCode;
    }

    public void setReservationCode(String reservationCode) {
        ReservationCode = reservationCode;
    }
}
