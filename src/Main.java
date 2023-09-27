import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Scanner;


public class Main {
    private static String followupCommand;
    private static int followUpIntCommand;
//    private static float followUpFloatCommand;
    private static String subCommand;
    private static String optionParameter;


    public static void main(String[] args) {
        ArrayList studentsList = new ArrayList<StudentsInfo>();
        String filePath = "C:\\Users\\tiwar\\Desktop\\dataBaseLabs\\findInformation\\src\\students.txt";
        StudentsInfo tempInfo = new StudentsInfo();
        try {
            String data = new String(Files.readAllBytes(Paths.get(filePath)), Charset.defaultCharset());

            int comCounter = 0;
            int currCounter = 0;
            int StartIndex = 0;
            //access each user's information and store it in the list
            for(int i=0; i<data.length();i++){
                if(data.charAt(i) == ','){
                    currCounter++;
                    comCounter = currCounter;
                }
                if(comCounter == 1){
                    tempInfo.setStudentLastName(data.substring(StartIndex,i));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 2){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setStudentFirstName(data.substring(StartIndex,i));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 3){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setGrade(Integer.parseInt(data.substring(StartIndex,i)));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 4){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setClassRoom(Integer.parseInt(data.substring(StartIndex,i)));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 5){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setBus(Integer.parseInt(data.substring(StartIndex,i)));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 6){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setGpa(Double.parseDouble(data.substring(StartIndex,i)));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(comCounter == 7){
                    // console.log(data.substring(StartIndex,i));
                    tempInfo.setTLastName(data.substring(StartIndex,i));
                    StartIndex = i+1;
                    comCounter = 0;
                }
                if(data.charAt(i) == '\n'){
                    tempInfo.setTFirstName(data.substring(StartIndex,i-1));
                    StartIndex = i+1;
                    comCounter = 0;
                    currCounter = 0;
                    // console.log(userInfo.studentObject);
                    StudentsInfo storeInfo = new StudentsInfo(tempInfo.getStudentFirstName(), tempInfo.getStudentLastName(),tempInfo.getGrade(),tempInfo.getClassRoom(),
                            tempInfo.getBus(),tempInfo.getGPA(),tempInfo.getTLastName(), tempInfo.getTFirstName());
                    studentsList.add(storeInfo);
                }
            }
            //accessing individual instances of the user's info like this:
//            for(int i=0;i<studentsList.size();i++){
//                System.out.println(studentsList.get(i));
//            }
//            while(true) {
//                displayMenu();
//                getUserInput();
//            }
            getUserInput();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void displayMenu(){
        String[] options = {"Student", "Teacher", "Bus", "Grade", "Average", "Info", "Quit"};
        System.out.println("Select the option followed by the search parameter:");
        for(int i=0; i< options.length; i++){
            System.out.println(i+1 + ")" + options[i]);
        }

    }
    public static void getUserInput(){
        Scanner scan = new Scanner(System.in);
        String userInput = scan.nextLine();
        int spaceCounter = 0;
        int spaceHolder = 0;
        int startIndex = 0;
        for(int i=0;i<userInput.length();i++){
            if(userInput.charAt(i) == ' '){
                spaceHolder++;
                spaceCounter = spaceHolder;
            }
            if(spaceCounter == 1){
                optionParameter = userInput.substring(startIndex, i);
                startIndex = i+1;
                spaceCounter = 0;
                System.out.println(optionParameter);
            }
            if(spaceCounter == 2){
                if(optionParameter.equalsIgnoreCase("s") || optionParameter.equalsIgnoreCase("students")){
                    followupCommand = userInput.substring(startIndex, i);
                    System.out.println(followupCommand);
                }
                if(optionParameter.equalsIgnoreCase("g") || optionParameter.equalsIgnoreCase("grade")){
                    followUpIntCommand = Integer.parseInt(userInput.substring(startIndex, i));
                    System.out.println(followUpIntCommand);
                }
                startIndex = i+1;
                
                break;
            }
            if(i == userInput.length() - 1 && (optionParameter.equalsIgnoreCase("s") || optionParameter.equalsIgnoreCase("students")
                    || optionParameter.equalsIgnoreCase("g") || optionParameter.equalsIgnoreCase("grade")) ){
                subCommand = userInput.substring(startIndex,i+1);
                System.out.println(subCommand);
            }

        }

//        System.out.println(userInput);
    }
}
