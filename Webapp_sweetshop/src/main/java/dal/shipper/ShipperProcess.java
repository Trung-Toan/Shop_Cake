package dal.shipper;

import dal.DAO;
import model.Shipper;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShipperProcess extends DAO {
    public static ShipperProcess Instance = new ShipperProcess();

    private ShipperProcess() {}

    public final List<Shipper> shipperList = new ArrayList<>();

    // lấy cac user có role = 3 - shipper
    public List<Shipper> getAllShipper() {
        String sql = "SELECT * FROM user WHERE role IN (3) ;";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            shipperList.clear();
            while (rs.next()) {
                Shipper shipper = new Shipper();
                shipper.setId(rs.getInt("id"));
                shipper.setUsername(rs.getString("username"));
                shipper.setPassword(rs.getString("password"));
                shipper.setFullName(rs.getString("fName"));
                shipper.setGender(rs.getBoolean("gender"));
                shipper.setEmail(rs.getString("email"));
                shipper.setPhone(rs.getString("phone"));
                shipper.setDob(rs.getDate("dob"));
                shipper.setAvatar(rs.getString("avatar"));
                shipper.setAddress(rs.getString("address"));
                shipper.setStatus(rs.getInt("status"));
                shipper.setCreatedAt(rs.getDate("createdAt"));
                shipper.setUpdatedAt(rs.getDate("updatedAt"));
                shipper.setRole(rs.getInt("role"));
                shipperList.add(shipper);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shipperList;
    }

    public void add(Shipper shipper) {
        String sql = "INSERT INTO shipper " +
                "(username, " +
                "password, " +
                "fName, " +
                "gender, " +
                "email, " +
                "phone, " +
                "dob, " +
                "avatar, " +
                "address, " +
                "status, " +
                "createdAt, " +
                "updatedAt, " +
                "role) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, shipper.getUsername());
            ps.setString(2, shipper.getPassword());
            ps.setString(3, shipper.getFullName());
            ps.setBoolean(4, shipper.isGender());
            ps.setString(5, shipper.getEmail());
            ps.setString(6, shipper.getPhone());
            ps.setDate(7, shipper.getDob());
            ps.setString(8, shipper.getAvatar());
            ps.setString(9, shipper.getAddress());
            ps.setInt(10, shipper.getStatus());
            ps.setDate(11, new Date(shipper.getCreatedAt().getTime()));
            ps.setDate(12, new Date(shipper.getUpdatedAt().getTime()));
            ps.setInt(13, shipper.getRole());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    public void update(User user) {
//        String sql = "UPDATE [post] " +
//                "SET title = ?, " +
//                "content = ?, " +
//                "updatedAt = ? " +
//                "WHERE id = ?";
//        try {
//            PreparedStatement ps = this.connection.prepareStatement(sql);
//            ps.setString(1, user.getUsername());
//            ps.setString(2, user.getPassword());
//            ps.setString(3, user.getFName());
//            ps.setBoolean(4, user.isGender());
//            ps.setString(5, user.getEmail());
//            ps.setString(6, user.getPhone());
//            ps.setDate(7, user.getDob());
//            ps.setString(8, user.getAvatar());
//            ps.setString(9, user.getAddress());
//            ps.setInt(10, user.getStatus());
//            ps.setDate(11, new java.sql.Date(user.getCreatedAt().getTime()));
//            ps.setDate(12, new java.sql.Date(user.getUpdatedAt().getTime()));
//            ps.setInt(13, user.getRole());
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }

    public static void main(String[] args) {
        // Gọi hàm read để lấy danh sách nhân viên
        List<Shipper> shipperList = ShipperProcess.Instance.getAllShipper();

        // In ra thông tin của từng nhân viên trong danh sách
        for (Shipper shipper : shipperList) {
            System.out.println("ID: " + shipper.getId());
            System.out.println("Username: " + shipper.getUsername());
            System.out.println("Full Name: " + shipper.getFullName());
            System.out.println("Gender: " + (shipper.isGender() ? "Male" : "Female"));
            System.out.println("Email: " + shipper.getEmail());
            System.out.println("Phone: " + shipper.getPhone());
            System.out.println("DOB: " + shipper.getDob());
            System.out.println("Avatar: " + shipper.getAvatar());
            System.out.println("Address: " + shipper.getAddress());
            System.out.println("Status: " + shipper.getStatus());
            System.out.println("Created At: " + shipper.getCreatedAt());
            System.out.println("Updated At: " + shipper.getUpdatedAt());
            System.out.println("-------------------------");
        }
    }

    

}















