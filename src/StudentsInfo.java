public class StudentsInfo {
    private String studentLastName;
    private String studentFirstName;
    private int Grade;
    private int classRoom;
    private int Bus;
    private double GPA;
    private String tLastName;
    private String tFirstName;

    StudentsInfo(String studentFirstName, String studentLastName, int Grade,
                 int classRoom, int Bus, double GPA, String tLastName, String tFirstName){

        this.studentFirstName = studentFirstName;
        this.studentLastName = studentLastName;
        this.Grade = Grade;
        this.classRoom = classRoom;
        this.Bus = Bus;
        this.tLastName = tLastName;
        this.tFirstName = tFirstName;
        this.GPA = GPA;

    }

    StudentsInfo(){};   //constructor if not providing any parameter

    public String getStudentLastName() {
        return studentLastName;
    }

    public String getStudentFirstName() {
        return studentFirstName;
    }

    public int getGrade() {
        return Grade;
    }

    public int getClassRoom() {
        return classRoom;
    }

    public int getBus() {
        return Bus;
    }

    public double getGPA() {
        return GPA;
    }

    public String getTLastName() {
        return tLastName;
    }

    public String getTFirstName() {
        return tFirstName;
    }

    // Setter methods for studentLastName
    public void setStudentLastName(String studentLastName) {
        this.studentLastName = studentLastName;
    }

    // Setter methods for studentFirstName
    public void setStudentFirstName(String studentFirstName) {
        this.studentFirstName = studentFirstName;
    }

    // Setter methods for Grade
    public void setGrade(int grade) {
        this.Grade = grade;
    }

    // Setter methods for classRoom
    public void setClassRoom(int classRoom) {
        this.classRoom = classRoom;
    }

    // Setter methods for Bus
    public void setBus(int bus) {
        this.Bus = bus;
    }

    // Setter methods for GPA
    public void setGpa(double gpa) {
        this.GPA = gpa;
    }

    // Setter methods for tLastName
    public void setTLastName(String tLastName) {
        this.tLastName = tLastName;
    }

    // Setter methods for tFirstName
    public void setTFirstName(String tFirstName) {
        this.tFirstName = tFirstName;
    }

    @Override
    public String toString() {
        return "Student{" +
                "firstName='" + this.studentFirstName + '\'' +
                ", lastName='" + this.studentLastName + '\'' +
                ", grade=" + this.Grade +
                ", classRoom=" + this.classRoom +
                ", bus=" + this.Bus +
                ", gpa=" + this.GPA +
                ", teacherLastName='" + this.tLastName + '\'' +
                ", teacherFirstName='" + this.tFirstName + '\'' +
                '}';
    }
}