package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author FPT University - PRJ30X
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "root"; // Your MySQL username
            String pass = "07082003"; // Your MySQL password
            String url = "jdbc:mysql://localhost:3306/shopcake"; // MySQL connection URL
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC driver
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        System.out.println(new DBContext().connection);
    }
}
