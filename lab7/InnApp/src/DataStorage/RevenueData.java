package DataStorage;

public class RevenueData {
    private String Room;
    private float JanPrice;
    private float FebPrice;
    private float MarPrice;
    private float AprPrice;
    private float MayPrice;
    private float JunPrice;
    private float JulPrice;
    private float AugPrice;
    private float SepPrice;
    private float OctPrice;
    private float NovPrice;
    private float DecPrice;
    private float totalRoomPrice;

    public RevenueData(){
        this.JanPrice = 0;
        this.FebPrice = 0;
        this.MarPrice = 0;
        this.AprPrice = 0;
        this.MayPrice = 0;
        this.JunPrice = 0;
        this.JulPrice = 0;
        this.AugPrice = 0;
        this.SepPrice = 0;
        this.OctPrice = 0;
        this.NovPrice = 0;
        this.DecPrice = 0;
        this.totalRoomPrice = 0;
    }

    public String getRoom() {
        return Room;
    }

    public void setRoom(String room) {
        Room = room;
    }

    public float getJanPrice() {
        return JanPrice;
    }

    public void setJanPrice(float janPrice) {
        JanPrice = janPrice;
    }

    public float getFebPrice() {
        return FebPrice;
    }

    public void setFebPrice(float febPrice) {
        FebPrice = febPrice;
    }

    public float getMarPrice() {
        return MarPrice;
    }

    public void setMarPrice(float marPrice) {
        MarPrice = marPrice;
    }

    public float getAprPrice() {
        return AprPrice;
    }

    public void setAprPrice(float aprPrice) {
        AprPrice = aprPrice;
    }

    public float getMayPrice() {
        return MayPrice;
    }

    public void setMayPrice(float mayPrice) {
        MayPrice = mayPrice;
    }

    public float getJunPrice() {
        return JunPrice;
    }

    public void setJunPrice(float junPrice) {
        JunPrice = junPrice;
    }

    public float getJulPrice() {
        return JulPrice;
    }

    public void setJulPrice(float julPrice) {
        JulPrice = julPrice;
    }

    public float getAugPrice() {
        return AugPrice;
    }

    public void setAugPrice(float augPrice) {
        AugPrice = augPrice;
    }

    public float getSepPrice() {
        return SepPrice;
    }

    public void setSepPrice(float sepPrice) {
        SepPrice = sepPrice;
    }

    public float getOctPrice() {
        return OctPrice;
    }

    public void setOctPrice(float octPrice) {
        OctPrice = octPrice;
    }

    public float getNovPrice() {
        return NovPrice;
    }

    public void setNovPrice(float novPrice) {
        NovPrice = novPrice;
    }

    public float getDecPrice() {
        return DecPrice;
    }

    public void setDecPrice(float decPrice) {
        DecPrice = decPrice;
    }

    public float getTotalRoomPrice() {
        return totalRoomPrice;
    }

    public void setTotalRoomPrice(float totalRoomPrice) {
        this.totalRoomPrice = totalRoomPrice;
    }
}
