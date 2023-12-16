import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;

import DataStorage.RevenueData;



public class RevenueInfo {
    public float totalJanPrice;
    public float totalFebPrice;
    public float totalMarPrice;
    public float totalAprPrice;
    public float totalMayPrice;
    public float totalJunPrice;
    public float totalJulPrice;
    public float totalAugPrice;
    public float totalSepPrice;
    public float totalOctPrice;
    public float totalNovPrice;
    public float totalDecPrice;
    public float totalSumRoomPrice;

    public void calcRev(Connection connection) throws SQLException {
        ArrayList<RevenueData> revData = new ArrayList<RevenueData>();

        Statement statement = connection.createStatement();
        // getting the first half of the data
        String query = "select *,sum(secondMonthPrice) as setPrice from (select room as checkoutRoom,checkoutMonth, (checkoutDays * rate) as secondMonthPrice from (select *, case When DATEDIFF(maxCheckinDate,checkin) = 0 then 1 ELSE DATEDIFF(maxCheckinDate,checkin) END as checkinDays, case WHEN DATEDIFF(checkout,minCheckoutDate) = 0 then 1 ELSE DATEDIFF(checkout,minCheckoutDate) END as checkoutDays from (select *,LAST_DAY(checkin) as maxCheckinDate, LAST_DAY(checkout) - INTERVAL (DAY(LAST_DAY(checkout)) - 1) DAY AS minCheckoutDate from (select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth != checkoutMonth) as minMaxDays) as daysofMonth) as checkoutData group by checkoutRoom,checkoutMonth;";
        ResultSet resultset = statement.executeQuery(query);

        while (resultset.next()) {
            RevenueData data = new RevenueData();
            String checkoutRoom = resultset.getString("checkoutRoom");
            data.setRoom(checkoutRoom);
            float price = resultset.getFloat("setPrice");
            String checkoutMonth = resultset.getString("checkoutMonth");

            if (checkoutMonth.equals("January")) {
                data.setJanPrice(price);
            } else if (checkoutMonth.equals("February")) {
                data.setFebPrice(price);
            } else if (checkoutMonth.equals("March")) {
                data.setMarPrice(price);
            } else if (checkoutMonth.equals("April")) {
                data.setAprPrice(price);
            } else if (checkoutMonth.equals("May")) {
                data.setMayPrice(price);
            } else if (checkoutMonth.equals("June")) {
                data.setJunPrice(price);
            } else if (checkoutMonth.equals("July")) {
                data.setJulPrice(price);
            } else if (checkoutMonth.equals("August")) {
                data.setAugPrice(price);
            } else if (checkoutMonth.equals("September")) {
                data.setSepPrice(price);
            } else if (checkoutMonth.equals("October")) {
                data.setOctPrice(price);
            } else if (checkoutMonth.equals("November")) {
                data.setNovPrice(price);
            } else if (checkoutMonth.equals("December")) {
                data.setDecPrice(price);
            }

            Boolean addedVal = false;

            for (RevenueData d : revData) {
                if(data.getRoom().equals(d.getRoom())){
                    d.setJanPrice(d.getJanPrice() + data.getJanPrice());
                    d.setFebPrice(d.getFebPrice() + data.getFebPrice());
                    d.setMarPrice(d.getMarPrice() + data.getMarPrice());
                    d.setAprPrice(d.getAprPrice() + data.getAprPrice());
                    d.setMayPrice(d.getMayPrice() + data.getMayPrice());
                    d.setJunPrice(d.getJunPrice() + data.getJunPrice());
                    d.setJulPrice(d.getJulPrice() + data.getJulPrice());
                    d.setAugPrice(d.getAugPrice() + data.getAugPrice());
                    d.setSepPrice(d.getSepPrice() + data.getSepPrice());
                    d.setOctPrice(d.getOctPrice() + data.getOctPrice());
                    d.setNovPrice(d.getNovPrice() + data.getNovPrice());
                    d.setDecPrice(d.getDecPrice() + data.getDecPrice());
                    
                    addedVal = true;
                }
            }

            if(addedVal == false){
                revData.add(data);
            }

        }
        
        //getting the second half of the data
        query = "select *,sum(firstMonthPrice) as checkinMonthPrice from (select room as checkinRoom,checkinMonth,(checkinDays * rate) as firstMonthPrice from (select *, case When DATEDIFF(maxCheckinDate,checkin) = 0 then 1 ELSE DATEDIFF(maxCheckinDate,checkin) END as checkinDays, case WHEN DATEDIFF(checkout,minCheckoutDate) = 0 then 1 ELSE DATEDIFF(checkout,minCheckoutDate) END as checkoutDays from (select *,LAST_DAY(checkin) as maxCheckinDate, LAST_DAY(checkout) - INTERVAL (DAY(LAST_DAY(checkout)) - 1) DAY AS minCheckoutDate from (select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth != checkoutMonth) as minMaxDays) as daysofMonth) as checkinData group by checkinRoom, checkinMonth";

        resultset = statement.executeQuery(query);

        while (resultset.next()) {
            RevenueData data = new RevenueData();
            String checkinRoom = resultset.getString("checkinRoom");
            data.setRoom(checkinRoom);
            float price = resultset.getFloat("checkinMonthPrice");
            String checkinMonth = resultset.getString("checkinMonth");

            if (checkinMonth.equals("January")) {
                data.setJanPrice(price);
            } else if (checkinMonth.equals("February")) {
                data.setFebPrice(price);
            } else if (checkinMonth.equals("March")) {
                data.setMarPrice(price);
            } else if (checkinMonth.equals("April")) {
                data.setAprPrice(price);
            } else if (checkinMonth.equals("May")) {
                data.setMayPrice(price);
            } else if (checkinMonth.equals("June")) {
                data.setJunPrice(price);
            } else if (checkinMonth.equals("July")) {
                data.setJulPrice(price);
            } else if (checkinMonth.equals("August")) {
                data.setAugPrice(price);
            } else if (checkinMonth.equals("September")) {
                data.setSepPrice(price);
            } else if (checkinMonth.equals("October")) {
                data.setOctPrice(price);
            } else if (checkinMonth.equals("November")) {
                data.setNovPrice(price);
            } else if (checkinMonth.equals("December")) {
                data.setDecPrice(price);
            }

            Boolean addedVal = false;

            for (RevenueData d : revData) {
                if(data.getRoom().equals(d.getRoom())){
                    d.setJanPrice(d.getJanPrice() + data.getJanPrice());
                    d.setFebPrice(d.getFebPrice() + data.getFebPrice());
                    d.setMarPrice(d.getMarPrice() + data.getMarPrice());
                    d.setAprPrice(d.getAprPrice() + data.getAprPrice());
                    d.setMayPrice(d.getMayPrice() + data.getMayPrice());
                    d.setJunPrice(d.getJunPrice() + data.getJunPrice());
                    d.setJulPrice(d.getJulPrice() + data.getJulPrice());
                    d.setAugPrice(d.getAugPrice() + data.getAugPrice());
                    d.setSepPrice(d.getSepPrice() + data.getSepPrice());
                    d.setOctPrice(d.getOctPrice() + data.getOctPrice());
                    d.setNovPrice(d.getNovPrice() + data.getNovPrice());
                    d.setDecPrice(d.getDecPrice() + data.getDecPrice());
                    
                    addedVal = true;
                }
            }

            if(addedVal == false){
                revData.add(data);
            }

        }

        //getting the same month data
        query = "select *,sum(spentMoney) as expectedMoney from(select room,checkinMonth,daysSpent*rate as spentMoney from(select *,DATEDIFF(checkout,checkin) as daysSpent from(select *,monthName(checkin) as checkinMonth,monthName(checkout) as checkoutMonth from rooms join reservations on rooms.roomcode = reservations.room) as monthsName where checkinMonth = checkoutMonth) as daysCounted) as priceMoney group by room, checkinMonth";
        resultset = statement.executeQuery(query);

        while (resultset.next()) {
            RevenueData data = new RevenueData();
            String Room = resultset.getString("Room");
            data.setRoom(Room);
            float price = resultset.getFloat("expectedMoney");
            String checkinMonth = resultset.getString("checkinMonth");

            if (checkinMonth.equals("January")) {
                data.setJanPrice(price);
            } else if (checkinMonth.equals("February")) {
                data.setFebPrice(price);
            } else if (checkinMonth.equals("March")) {
                data.setMarPrice(price);
            } else if (checkinMonth.equals("April")) {
                data.setAprPrice(price);
            } else if (checkinMonth.equals("May")) {
                data.setMayPrice(price);
            } else if (checkinMonth.equals("June")) {
                data.setJunPrice(price);
            } else if (checkinMonth.equals("July")) {
                data.setJulPrice(price);
            } else if (checkinMonth.equals("August")) {
                data.setAugPrice(price);
            } else if (checkinMonth.equals("September")) {
                data.setSepPrice(price);
            } else if (checkinMonth.equals("October")) {
                data.setOctPrice(price);
            } else if (checkinMonth.equals("November")) {
                data.setNovPrice(price);
            } else if (checkinMonth.equals("December")) {
                data.setDecPrice(price);
            }

            Boolean addedVal = false;

            for (RevenueData d : revData) {
                if(data.getRoom().equals(d.getRoom())){
                    d.setJanPrice(d.getJanPrice() + data.getJanPrice());
                    d.setFebPrice(d.getFebPrice() + data.getFebPrice());
                    d.setMarPrice(d.getMarPrice() + data.getMarPrice());
                    d.setAprPrice(d.getAprPrice() + data.getAprPrice());
                    d.setMayPrice(d.getMayPrice() + data.getMayPrice());
                    d.setJunPrice(d.getJunPrice() + data.getJunPrice());
                    d.setJulPrice(d.getJulPrice() + data.getJulPrice());
                    d.setAugPrice(d.getAugPrice() + data.getAugPrice());
                    d.setSepPrice(d.getSepPrice() + data.getSepPrice());
                    d.setOctPrice(d.getOctPrice() + data.getOctPrice());
                    d.setNovPrice(d.getNovPrice() + data.getNovPrice());
                    d.setDecPrice(d.getDecPrice() + data.getDecPrice());
                    
                    addedVal = true;
                }
            }

            if(addedVal == false){
                revData.add(data);
            }

        }

        //totalField for each room
        query = "select room,sum(amountPaid) as totalRoomPrice from(select *,days*rate as amountPaid from(select *,DATEDIFF(checkout,checkin) as days from reservations) as daysSpend) as amountTaken group by room";
        resultset = statement.executeQuery(query);

        while(resultset.next()){
            String Room = resultset.getString("Room");
            float Price = resultset.getFloat("totalRoomPrice");

            for(RevenueData d : revData){
                if(d.getRoom().equals(Room)){
                    d.setTotalRoomPrice(Price);
                }
            }
        }
        for(RevenueData d : revData){
            this.totalJanPrice += d.getJanPrice();
            this.totalFebPrice += d.getFebPrice();
            this.totalMarPrice += d.getMarPrice();
            this.totalAprPrice += d.getAprPrice();
            this.totalMayPrice += d.getMayPrice();
            this.totalJunPrice += d.getJunPrice();
            this.totalJulPrice += d.getJulPrice();
            this.totalAugPrice += d.getAugPrice();
            this.totalSepPrice += d.getSepPrice();
            this.totalOctPrice += d.getOctPrice();
            this.totalNovPrice += d.getNovPrice();
            this.totalDecPrice += d.getDecPrice();
            this.totalSumRoomPrice += d.getTotalRoomPrice();
        }


        System.out.println("Revenue data split by month:");
        System.out.println("ROOM    |    JAN    |    FEB    |    MAR    |    APR    |    MAY    |    JUN    |    JUL    |    AUG    |    SEP    |    OCT    |    NOV    |    DEC    |   TOTALYEARLYREVENUE");
        for(int i=0;i<revData.size();i++){
            System.out.print(revData.get(i).getRoom() + "   |   " + revData.get(i).getJanPrice() + "   |   " + revData.get(i).getFebPrice() + "   |   " + revData.get(i).getMarPrice() + "   |   " + revData.get(i).getAprPrice() + "   |   " + revData.get(i).getMayPrice() + "   |   " + revData.get(i).getJunPrice() + "   |   " + revData.get(i).getJulPrice() + "   |   " + revData.get(i).getAugPrice() + "   |   " + revData.get(i).getSepPrice() + "   |   " + revData.get(i).getOctPrice() + "   |   " + revData.get(i).getNovPrice() + "   |   " + revData.get(i).getDecPrice() + "   |   " + revData.get(i).getTotalRoomPrice());
        }
        System.out.println("Total Monthly Rev: " + this.totalJanPrice + "   |   " + this.totalFebPrice + "   |   " + this.totalMarPrice + "   |   " + this.totalAprPrice + "   |   " + this.totalMayPrice + "   |   " + this.totalJunPrice + "   |   " + this.totalJulPrice + "   |   " + this.totalAugPrice + "   |   " + this.totalSepPrice + "   |   " + this.totalOctPrice + "   |   " + this.totalNovPrice + "   |   " + this.totalDecPrice + "   |   " + this.totalSumRoomPrice);
        

    }
}
