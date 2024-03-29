import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.Collections;
import java.util.Comparator;


public class schoolSearch {
    private static String followupCommand;
    private static int followUpIntCommand;
    private static String subCommand;
    private static String optionParameter;
    private static boolean quit = false;


    public static void main(String[] args) {

        ArrayList<StudentsInfo> studentsList = new ArrayList<StudentsInfo>();
//        String currentDirectory = System.getProperty("user.dir");
        String filePath = ".\\students.txt";
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
            int counter = 0;
            while(!quit) {
                displayMenu();
                if(args.length == 0){   //running the command line
                    getUserInput("");
                }else{
                    getUserInput(args[counter]);  //running the test script
                    counter++;
                }
                fetchData(studentsList);
            }

            //not to put session ended when loop ends

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
        System.out.println("Enter the Searchable parameters seperated by `spaces`. \n");
        System.out.println("EX: `student: woolery bus` \n `s:` woolery bus");

    }
    public static void getUserInput(String args){
        String userInput = "";
        if(args == "") {    //input provided from the console
            Scanner scan = new Scanner(System.in);
            userInput = scan.nextLine();
            // scan.close();
        }else{  //input provided from the Test script
            userInput = args;
        }
        int spaceCounter = 0;
        int spaceHolder = 0;
        int startIndex = 0;
        for(int i=0;i<userInput.length();i++){
            if(userInput.toLowerCase().charAt(0) == 'i'){
                optionParameter = "info";
                break;
            }
            if(userInput.toLowerCase().charAt(0) == 'q'){
                optionParameter = "quit";
                break;
            }
            if(userInput.charAt(i) == ' '){
                spaceHolder++;
                spaceCounter = spaceHolder;
            }
            if(spaceCounter == 1){
                optionParameter = userInput.substring(startIndex, i-1);
                startIndex = i+1;
                spaceCounter = 0;
            }
            if(spaceCounter == 2){
                if(optionParameter == null){
                    System.out.println("Option parameter is not provided");
                    break;
                }
                if(optionParameter.equalsIgnoreCase("s") || optionParameter.equalsIgnoreCase("student")){
                    followupCommand = userInput.substring(startIndex, i);
                }
                if(optionParameter.equalsIgnoreCase("g") || optionParameter.equalsIgnoreCase("grade")){
                    try {
                        followUpIntCommand = Integer.parseInt(userInput.substring(startIndex, i));
                    }
                    catch (Exception e){
                        System.out.println(e);
                    }
                }
                startIndex = i+1;
                subCommand = userInput.substring(startIndex, userInput.length());
                break;
            }
            if(i == userInput.length() - 1){
                if(optionParameter == null){
                    System.out.println("Option parameter is not provided");
                    break;
                }
                if(optionParameter.equalsIgnoreCase("t") || optionParameter.equalsIgnoreCase("teacher")
                || optionParameter.equalsIgnoreCase("s") || optionParameter.equalsIgnoreCase("student")){
                    followupCommand = userInput.substring(startIndex, i+1);
                    subCommand = "";
                }
                if(optionParameter.equalsIgnoreCase("b") || optionParameter.equalsIgnoreCase("bus")
                || optionParameter.equalsIgnoreCase("g") || optionParameter.equalsIgnoreCase("grade")
                || optionParameter.equalsIgnoreCase("a") || optionParameter.equalsIgnoreCase("average")){
                    try {
                        followUpIntCommand = Integer.parseInt(userInput.substring(startIndex, i + 1));
                    }
                    catch (Exception e){
                        System.out.println(e);
                    }
                    subCommand = "";
                }
            }

        }
    }
    public static void fetchData(ArrayList<StudentsInfo> studentList){
        if(optionParameter == null){
            return;
        }
        //student without bus param
        if((optionParameter.equalsIgnoreCase("student") || optionParameter.equalsIgnoreCase("s")) &&
                !(subCommand.equalsIgnoreCase("bus") || subCommand.equalsIgnoreCase("b"))){
            if(followupCommand == null){
                return;
            }
            for(int i=0;i<studentList.size();i++){
                if(followupCommand.equalsIgnoreCase(studentList.get(i).getStudentLastName())){
                    System.out.println("LastName: " + studentList.get(i).getStudentLastName() + " firstName: " +
                            studentList.get(i).getStudentFirstName() + " Grade: " + studentList.get(i).getGrade() +
                            " ClassRoom Assignment: " + studentList.get(i).getClassRoom() + " T_FirstName: " +
                            studentList.get(i).getTFirstName() + " T_LastName: " +
                            studentList.get(i).getTLastName());
                    System.out.println("\n");
                }
            }

        }
        //student with bus param
        if((optionParameter.equalsIgnoreCase("student") || optionParameter.equalsIgnoreCase("s")) &&
                (subCommand.equalsIgnoreCase("bus") || subCommand.equalsIgnoreCase("b"))){
            if(followupCommand == null){
                return;
            }
            for(int i=0;i<studentList.size();i++){
                if(followupCommand.equalsIgnoreCase(studentList.get(i).getStudentLastName())){
                    System.out.println("LastName: " + studentList.get(i).getStudentLastName() + " firstName: " +
                            studentList.get(i).getStudentFirstName() + " Bus Route: " + studentList.get(i).getBus());
                    System.out.println("\n");
                }
            }

        }
        //option parameter  = teacher
        if(optionParameter.equalsIgnoreCase("teacher") || optionParameter.equalsIgnoreCase("t")){
            if(followupCommand == null){
                return;
            }
            for(int i=0;i<studentList.size();i++){
                if(followupCommand.equalsIgnoreCase(studentList.get(i).getTLastName())){
                    System.out.println(" LastName: " + studentList.get(i).getStudentLastName() + " first name: " +
                            studentList.get(i).getStudentFirstName());
                    System.out.println("\n");
                }
            }

        }
        //option parameter  = Bus
        if(optionParameter.equalsIgnoreCase("bus") || optionParameter.equalsIgnoreCase("b")){
            for(int i=0;i<studentList.size();i++){
                if(followUpIntCommand == studentList.get(i).getBus()){
                    System.out.println(" LastName: " + studentList.get(i).getStudentLastName() + " first name: " +
                            studentList.get(i).getStudentFirstName() + " Grade: " + studentList.get(i).getGrade() +
                            " ClassRoom: " + studentList.get(i).getClassRoom());
                    System.out.println("\n");
                }
            }

        }
        //option parameter  = Average
        if(optionParameter.equalsIgnoreCase("Average") || optionParameter.equalsIgnoreCase("a")){
            double averageGPA = 0.00;
            int count = 0;
            for(int i=0;i<studentList.size();i++){
                if(followUpIntCommand == studentList.get(i).getGrade()){
                    count++;
                    averageGPA += studentList.get(i).getGPA();
                }
            }
            averageGPA = averageGPA/count;
            System.out.println(" GradeLevel: " + followUpIntCommand + " Average Gpa computed: " + averageGPA);
            System.out.println("\n");
        }
        //option parameter  = Info
        if(optionParameter.equalsIgnoreCase("info") || optionParameter.equalsIgnoreCase("i")) {
            infoFunc(studentList);
        }
        //option parameter = quit
        if(optionParameter.equalsIgnoreCase("quit") || optionParameter.equalsIgnoreCase("q")) {
            quit = true;
        }

        //option parameter = Grade without sub param
        if((optionParameter.equalsIgnoreCase("grade") || optionParameter.equalsIgnoreCase("g")) &&
                !(subCommand.equalsIgnoreCase("high") || subCommand.equalsIgnoreCase("h") ||
                        subCommand.equalsIgnoreCase("low") || subCommand.equalsIgnoreCase("l"))){
            for(int i=0;i<studentList.size();i++){
                if(followUpIntCommand == studentList.get(i).getGrade()){
                    System.out.println("LastName: " + studentList.get(i).getStudentLastName() + " first name: " +
                            studentList.get(i).getStudentFirstName());
                    System.out.println("\n");
                }
            }
        }
        //option parameter = grade with high sub param
        if((optionParameter.equalsIgnoreCase("grade") || optionParameter.equalsIgnoreCase("g")) &&
                (subCommand.equalsIgnoreCase("high") || subCommand.equalsIgnoreCase("h"))){
            StudentsInfo highVal = null;
            double maxGPA = 0.00;
            for(int i=0;i<studentList.size();i++){
                if(followUpIntCommand == studentList.get(i).getGrade()){
                    if(studentList.get(i).getGPA() > maxGPA){
                        maxGPA = studentList.get(i).getGPA();
                        highVal = studentList.get(i);
                    }
                }
            }
            //have the access to the instance that have the max GPA and provided grade
            if(highVal != null) {
                System.out.println("LastName: " + highVal.getStudentLastName() + " firstName: " +
                        highVal.getStudentFirstName() + " Grade: " + highVal.getGrade() +
                        " GPA: " + highVal.getGPA() + " T_FirstName: " +
                        highVal.getTFirstName() + " T_LastName: " +
                        highVal.getTLastName() + " Bus Route: " + highVal.getBus());
                System.out.println("\n");
            }
            else {
                System.out.println("No relevant data found.");
            }
        }

        //option parameter = grade with low sub param
        if((optionParameter.equalsIgnoreCase("grade") || optionParameter.equalsIgnoreCase("g")) &&
                (subCommand.equalsIgnoreCase("low") || subCommand.equalsIgnoreCase("l"))){
            StudentsInfo lowVal = null;
            double minGPA = Double.MAX_VALUE;
            for(int i=0;i<studentList.size();i++){
                if(followUpIntCommand == studentList.get(i).getGrade()){
                    if(studentList.get(i).getGPA() < minGPA){
                        minGPA = studentList.get(i).getGPA();
                        lowVal = studentList.get(i);
                    }
                }
            }
            //have the access to the instance that have the min GPA and provided grade
            if(lowVal != null) {
                System.out.println("LastName: " + lowVal.getStudentLastName() + " firstName: " +
                        lowVal.getStudentFirstName() + " Grade: " + lowVal.getGrade() +
                        " GPA: " + lowVal.getGPA() + " T_FirstName: " +
                        lowVal.getTFirstName() + " T_LastName: " +
                        lowVal.getTLastName() + " Bus Route: " + lowVal.getBus());
                System.out.println("\n");
            }
            else {
                System.out.println("No relevant data found.");
            }
        }

    }

    public static void infoFunc(ArrayList<StudentsInfo> studentList){
        int[] gradeStudents = new int[7];
        ArrayList<studentGradeNumbers> studentGradeList = new ArrayList<>();
        for(int i=0;i<gradeStudents.length;i++){    //set all the initial grade value to 0
            gradeStudents[i] = 0;
        }

        for(int i=0;i<studentList.size();i++){  //for each grade update the count value
            gradeStudents[studentList.get(i).getGrade()]++;
        }

        //store the value of students and grade in collection list
        for(int i=0;i<gradeStudents.length;i++){
            studentGradeNumbers studentGradeInfo = new studentGradeNumbers(gradeStudents[i], i);
            studentGradeList.add(studentGradeInfo);
        }

        //sort this array in ascending order
        Collections.sort(studentGradeList, new Comparator<studentGradeNumbers>() {
            @Override
            public int compare(studentGradeNumbers student1, studentGradeNumbers student2) {
                return Integer.compare(student1.getNumberStudents(), student2.getNumberStudents());
            }
        });

        for(int i=1;i<studentGradeList.size();i++){
            System.out.println("Grade: " + studentGradeList.get(i).getGradeNumber() + " Number of Students: " +
                    studentGradeList.get(i).getNumberStudents());
        }

    }
}
