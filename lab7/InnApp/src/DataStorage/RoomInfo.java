package DataStorage;

public class RoomInfo {
    private String roomCode;
    private String roomName;
    private int beds;
    private String bedType;
    private int maxOcc;
    private int basePrice;
    private String decor;
    private float roomPopularity;

        //seperate query
    private String nextCheckinDate;
    
    //seperated query data
    private int LengthDays;
    private String checkOutdate;

    public String getNextCheckinDate() {
        return nextCheckinDate;
    }

    public void setNextCheckinDate(String nextCheckinDate) {
        this.nextCheckinDate = nextCheckinDate;
    }

    public String getCheckOutdate() {
        return checkOutdate;
    }

    public void setCheckOutdate(String checkOutdate) {
        this.checkOutdate = checkOutdate;
    }


    public int getLengthDays() {
        return LengthDays;
    }

    public void setLengthDays(int lengthDays) {
        LengthDays = lengthDays;
    }

    public String getRoomCode() {
        return roomCode;
    }

    public void setRoomCode(String roomCode) {
        this.roomCode = roomCode;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getBeds() {
        return beds;
    }

    public void setBeds(int beds) {
        this.beds = beds;
    }

    public String getBedType() {
        return bedType;
    }

    public void setBedType(String bedType) {
        this.bedType = bedType;
    }

    public int getMaxOcc() {
        return maxOcc;
    }

    public void setMaxOcc(int maxOcc) {
        this.maxOcc = maxOcc;
    }

    public int getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(int basePrice) {
        this.basePrice = basePrice;
    }

    public String getDecor() {
        return decor;
    }

    public void setDecor(String decor) {
        this.decor = decor;
    }

    public float getRoomPopularity() {
        return roomPopularity;
    }

    public void setRoomPopularity(float roomPopularity) {
        this.roomPopularity = roomPopularity;
    }
}