package dal.user;

import dal.DAO;
import model.User;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserProcess extends DAO {
    public static UserProcess Instance = new UserProcess();

    private UserProcess() {
    }

    public final List<User> UserList = new ArrayList<>();

    // lấy cac user có role = 3 or 2
    public List<User> read() {
        String sql = "SELECT * FROM user WHERE role IN (2, 3);";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            UserList.clear();
            while (rs.next()) {
                User User = new User();
                User.setId(rs.getInt("id"));
                User.setUsername(rs.getString("username"));
                User.setPassword(rs.getString("password"));
                User.setFullName(rs.getString("fName"));
                User.setGender(rs.getBoolean("gender"));
                User.setEmail(rs.getString("email"));
                User.setPhone(rs.getString("phone"));
                User.setDob(rs.getDate("dob"));
                User.setAvatar(rs.getString("avatar"));
                User.setAddress(rs.getString("address"));
                User.setStatus(rs.getInt("status"));
                User.setCreatedAt(rs.getDate("createdAt"));
                User.setUpdatedAt(rs.getDate("updatedAt"));
                User.setRole(rs.getInt("role"));
                UserList.add(User);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return UserList;
    }

    // lấy cac user có role = 2 - User

    public void add(User User) {
        String sql = "INSERT INTO User " +
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
            ps.setString(1, User.getUsername());
            ps.setString(2, User.getPassword());
            ps.setString(3, User.getFullName());
            ps.setBoolean(4, User.isGender());
            ps.setString(5, User.getEmail());
            ps.setString(6, User.getPhone());
            ps.setDate(7, User.getDob());
            ps.setString(8, User.getAvatar());
            ps.setString(9, User.getAddress());
            ps.setInt(10, User.getStatus());
            ps.setDate(11, new java.sql.Date(User.getCreatedAt().getTime()));
            ps.setDate(12, new java.sql.Date(User.getUpdatedAt().getTime()));
            ps.setInt(13, User.getRole());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Create new user and return id after add
     *
     * @param User information user
     * @return new id of user after add and null if add not success
     */
    public String addAndReturnId(User User) {
        String sql = "{CALL insertUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        String id = null;
        try {
            CallableStatement cs = this.connection.prepareCall(sql);
            cs.setString(1, User.getUsername());
            cs.setString(2, User.getPassword());
            cs.setString(3, User.getFullName());
            cs.setBoolean(4, User.isGender());
            cs.setString(5, User.getEmail());
            cs.setString(6, User.getPhone());
            cs.setDate(7, User.getDob());
            cs.setString(8, User.getAvatar());
            cs.setString(9, User.getAddress());
            cs.setInt(10, 0);
            cs.setInt(11, 1);
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    id = rs.getString("newUserID");
                }
                rs.close();
            }
            cs.close();
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return id;
    }

    /**
     * Create new user and return id after add
     *
     * @param username
     * @param password
     * @param email
     * @return new id of user after add and null if add not success
     */
    public String addAndReturnId(String username, String password, String email) {
        String sql = "{CALL insertUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        String id = null;
        try {
            CallableStatement cs = this.connection.prepareCall(sql);
            cs.setString(1, username);
            cs.setString(2, password);
            cs.setString(3, null);
            cs.setBoolean(4, true);
            cs.setString(5, email);
            cs.setString(6, null);
            cs.setDate(7, null);
            cs.setString(8, null);
            cs.setString(9, null);
            cs.setInt(10, 0);
            cs.setInt(11, 1);
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    id = rs.getString("newUserID");
                }
                rs.close();
            }
            cs.close();
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return id;
    }

//    /**
//     * find a user by username or password and password
//     *
//     * @param username username or password
//     * @param password password
//     * @return new user if info is correct else null
//     */
//    public User findUser(String username, String password) {
//        User user = null;
//        String sql = "SELECT * FROM shopcake.user WHERE (username = ? OR email = ?) AND password = ?";
//        try {
//            PreparedStatement ps = this.connection.prepareStatement(sql);
//            ps.setString(1, username);
//            ps.setString(2, username);
//            ps.setString(3, password);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                user = new User();
//                user.setId(rs.getInt("id"));
//                user.setUsername(rs.getString("username"));
//                user.setPassword(rs.getString("password"));
//                user.setFullName(rs.getString("fName"));
//                user.setGender(rs.getBoolean("gender"));
//                user.setEmail(rs.getString("email"));
//                user.setPhone(rs.getString("phone"));
//                user.setDob(rs.getDate("dob"));
//                user.setAvatar(rs.getString("avatar"));
//                user.setAddress(rs.getString("address"));
//                user.setStatus(rs.getInt("status"));
//                user.setCreatedAt(rs.getDate("createdAt"));
//                user.setUpdatedAt(rs.getDate("updatedAt"));
//                user.setRole(rs.getInt("role"));
//            }
//        } catch (SQLException e) {
//            status = e.getMessage();
//        }
//        return user;
//    }

    //sửa lại hàm này hoặc viết thêm 1 hàm : lấy ra tài khoản có status = 1
    public User loadUser(String nameOrEmail, String password) {
        User user = null;
        String sql = "SELECT * FROM shopcake.user WHERE (username = ? OR email = ?) AND password = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, nameOrEmail);
            ps.setString(2, nameOrEmail);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("fName"));
                user.setGender(rs.getBoolean("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setDob(rs.getDate("dob"));
                user.setAvatar(rs.getString("avatar"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getInt("status"));
                user.setCreatedAt(rs.getDate("createdAt"));
                user.setUpdatedAt(rs.getDate("updatedAt"));
                user.setRole(rs.getInt("role"));
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return user;
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
        User User = UserProcess.Instance.searchProfile("50");

        // In ra thông tin của từng nhân viên trong danh sách
        System.out.println("ID: " + User.getId());
        System.out.println("Username: " + User.getUsername());
        System.out.println("Full Name: " + User.getFullName());
        System.out.println("Gender: " + (User.isGender() ? "Male" : "Female"));
        System.out.println("Email: " + User.getEmail());
        System.out.println("Phone: " + User.getPhone());
        System.out.println("DOB: " + User.getDob());
        System.out.println("Avatar: " + User.getAvatar());
        System.out.println("Address: " + User.getAddress());
        System.out.println("Status: " + User.getStatus());
        System.out.println("Created At: " + User.getCreatedAt());
        System.out.println("Updated At: " + User.getUpdatedAt());
        System.out.println("Role: " + User.getRole());
        System.out.println("-------------------------");
    }

    public User findByEmail(String email) {
        User user = null;
        String sql = "select * from user where email = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1,email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("fName"));
                user.setGender(rs.getBoolean("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setDob(rs.getDate("dob"));
                user.setAvatar(rs.getString("avatar"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getInt("status"));
                user.setCreatedAt(rs.getDate("createdAt"));
                user.setUpdatedAt(rs.getDate("updatedAt"));
                user.setRole(rs.getInt("role"));
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return user;
    }

    public User updateUser(User user) {
        User u = null;
        String sql = "" +
                "UPDATE shopcake.user " +
                "SET username = ?, password = ?, fName = ?, gender = ?, email = ?, phone = ?, " +
                "dob = ?, avatar = ?, address = ?, status = ?, updatedAt = ?, role = ? " +
                "WHERE id = ?";

        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setBoolean(4, user.isGender());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPhone());
            ps.setDate(7, new java.sql.Date(user.getDob().getTime()));
            ps.setString(8, user.getAvatar());
            ps.setString(9, user.getAddress());
            ps.setInt(10, user.getStatus());
            ps.setTimestamp(11, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(12, user.getRole());
            ps.setInt(13, user.getId());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                u = user;
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }

        return u;
    }

    public User searchProfile(String id) {
        User user = null;
        String sql = "SELECT * FROM shopcake.user WHERE id = ? ;";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("fName"));
                user.setGender(rs.getBoolean("gender"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setDob(rs.getDate("dob"));
                user.setAvatar(rs.getString("avatar"));
                user.setAddress(rs.getString("address"));
                user.setStatus(rs.getInt("status"));
                user.setCreatedAt(rs.getDate("createdAt"));
                user.setUpdatedAt(rs.getDate("updatedAt"));
                user.setRole(rs.getInt("role"));
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return user;
    }

    public User getUserById(String id) {
        List<User> users = getUserByCondition("AND id = ?", id);
        return users.isEmpty() ? null : users.get(0);
    }

    private List<User> getUserByCondition(String condition, Object... params) {
        // Tạo danh sách để lưu trữ các nhân viên thỏa mãn điều kiện
        List<User> userList = new ArrayList<>();

        // Tạo câu lệnh SQL để lấy các nhân viên có vai trò là 2 (role = 2) và điều kiện bổ sung
        String sql = "SELECT * FROM user WHERE " + condition + ";";

        // Sử dụng try-with-resources để tự động đóng PreparedStatement và ResultSet sau khi sử dụng
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            // Gán các giá trị tham số vào câu lệnh SQL, bắt đầu từ vị trí 1
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]); // i + 1 vì vị trí trong PreparedStatement bắt đầu từ 1
            }

            // Thực thi câu lệnh SQL và nhận kết quả dưới dạng ResultSet
            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua từng bản ghi trong ResultSet và tạo đối tượng Staff tương ứng
                while (rs.next()) {
                    // Thêm đối tượng Staff được tạo vào danh sách
                    userList.add(createUserFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra khi làm việc với cơ sở dữ liệu
            e.printStackTrace();
        }

        // Trả về danh sách các nhân viên thỏa mãn điều kiện đã cho
        return userList;
    }

    private User createUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("fName"));
        user.setGender(rs.getBoolean("gender"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setDob(rs.getDate("dob"));
        user.setAvatar(rs.getString("avatar"));
        user.setAddress(rs.getString("address"));
        user.setStatus(rs.getInt("status"));
        user.setCreatedAt(rs.getDate("createdAt"));
        user.setUpdatedAt(rs.getDate("updatedAt"));
        user.setRole(rs.getInt("role"));
        return user;
    }



        public boolean updateProfile(User user) {
        if (searchProfileById(String.valueOf(user.getId()))) {
            String sql = "UPDATE user SET username = ?, password = ?, fName = ?, gender = ?, email = ?, " +
                    "phone = ?, dob = ?, avatar = ?, address = ?, status = ?, updatedAt = ?, role = ? " +
                    "WHERE id = ?";
            try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getFullName());
                ps.setBoolean(4, user.isGender());
                ps.setString(5, user.getEmail());
                ps.setString(6, user.getPhone());
                ps.setDate(7, user.getDob());
                ps.setString(8, user.getAvatar());
                ps.setString(9, user.getAddress());
                ps.setInt(10, user.getStatus());
                ps.setDate(11, new java.sql.Date(System.currentTimeMillis()));
                ps.setInt(12, user.getRole());
                ps.setInt(13, user.getId());

                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    public boolean searchProfileById(String id) {
        return exists(" id = ?", id);
    }
    public boolean isActiveProfile(String id) {
        return exists("id = ? AND status = 1", id);
    }

    public boolean isUsernameTaken(String username) {
        return exists("username = ?", username);
    }

    public boolean isEmailTaken(String email) {
        return exists("email = ?", email);
    }

    public boolean isPhoneTaken(String phone) {
        return exists("phone = ?", phone);
    }
    private boolean exists(String condition, Object... params) {
        // Tạo câu lệnh SQL với điều kiện WHERE được cung cấp
        String sql = "SELECT 1 FROM user WHERE " + condition;
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            // Gán các giá trị tham số vào câu lệnh SQL, bắt đầu từ vị trí 1
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]); // i + 1 vì vị trí trong PreparedStatement bắt đầu từ 1
            }

            // Thực thi câu lệnh SQL và nhận kết quả dưới dạng ResultSet
            try (ResultSet rs = ps.executeQuery()) {
                // Nếu ResultSet có ít nhất một bản ghi, tức là tồn tại bản ghi thỏa mãn điều kiện
                return rs.next();
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra khi làm việc với cơ sở dữ liệu
            e.printStackTrace();
        }
        // Trả về false nếu không có bản ghi nào thỏa mãn hoặc có lỗi xảy ra
        return false;
    }

}















