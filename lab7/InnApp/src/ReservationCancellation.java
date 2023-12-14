import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ReservationCancellation {
    private Integer reservationCode;

    public void CancelReservation(Connection connection, Integer reservCode) throws SQLException{
        this.reservationCode = -1;   //initialize the field

        //set the reservCode value here
        this.reservationCode = reservCode;

        StringBuilder query = new StringBuilder("select * from reservations where 1=1");

        if(reservationCode != -1){
            query.append(" AND CODE = ?");
        }

        PreparedStatement stmt = connection.prepareStatement(query.toString());
        if(reservationCode !=-1){
            stmt.setString(1, reservationCode.toString());
        }

        ResultSet result = stmt.executeQuery();
        boolean hasRows = false;

        Integer reservVal = -1;  //initialize to -1, if code is not found in DB

        while(result.next()){
            hasRows = true;
            //reservation code has to be unique
            reservVal = result.getInt("CODE");
        }

        if(!hasRows){
            System.out.println("No such Tuple is found in the database");
            return;
        }

        //deleting the correspoding data from the Database
        if(reservVal != -1){
            query = new StringBuilder("DELETE from reservations where CODE = ?");
            stmt = connection.prepareStatement(query.toString());
            stmt.setString(1, reservVal.toString());
            //delete the data from the DB
            int rowsDeleted = stmt.executeUpdate();
            System.out.println(rowsDeleted);
        }
    }

    public int getReservationCode() {
        return reservationCode;
    }

    public void setReservationCode(int reservationCode) {
        this.reservationCode = reservationCode;
    }
}
