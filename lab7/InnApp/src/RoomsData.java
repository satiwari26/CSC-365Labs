import java.util.ArrayList;

import DataStorage.RoomInfo;

public class RoomsData {
    public ArrayList<RoomInfo> suggestedRoom = new ArrayList<RoomInfo>();

    public void newRoomInfo(RoomInfo info){
        this.suggestedRoom.add(info);
    }

}
