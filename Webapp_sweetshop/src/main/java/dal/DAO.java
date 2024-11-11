/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author trantoan
 */

public class DAO {

    protected java.sql.Connection connection;
    protected String status = "OK";

    public DAO() {
        try {
            connection = new DBContext().connection;
        } catch (Exception e) {
            status = "Error connect at: " + e.getMessage();
        }
    }
    
}
