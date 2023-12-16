import java.util.ArrayList;

// import DataStorage.ReservationsInfo;
import DataStorage.RoomInfo;

public class RoomsData {
    public ArrayList<RoomInfo> suggestedRoom = new ArrayList<RoomInfo>();
    // public ArrayList<ReservationsInfo> reservations = new ArrayList<ReservationsInfo>();

    public void newRoomInfo(RoomInfo info){
        this.suggestedRoom.add(info);
    }

}
