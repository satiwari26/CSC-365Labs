import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class App{
    public static void main(String[] args) {
        String url = System.getenv("HP_JDBC_URL");
        String username = System.getenv("HP_JDBC_USER");
        String password = System.getenv("HP_JDBC_PW");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to the database!");

            connection.close(); // Close the connection when done
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}