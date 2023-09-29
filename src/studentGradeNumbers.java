public class studentGradeNumbers {
    private int numberStudents;
    private int gradeNumber;

    studentGradeNumbers(int numberStudents, int gradeNumber){
        this.numberStudents = numberStudents;
        this.gradeNumber = gradeNumber;
    }

    public int getNumberStudents(){
        return(this.numberStudents);
    }
    public int getGradeNumber(){
        return(this.gradeNumber);
    }
}
