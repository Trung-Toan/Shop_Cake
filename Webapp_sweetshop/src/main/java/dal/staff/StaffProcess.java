package dal.staff;

import dal.DAO;
import model.Staff;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffProcess extends DAO {

    public StaffProcess() {
        // Initialization can be done if needed
    }

    public boolean add(Staff staff) {
        if (staff == null) {
            throw new IllegalArgumentException("Staff object cannot be null");
        }
        String sql = "INSERT INTO user (username, password, fName, gender, email, phone, dob, avatar, address, status, createdAt, updatedAt, role) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, staff.getUsername());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getFullName());
            ps.setBoolean(4, staff.isGender());
            ps.setString(5, staff.getEmail());
            ps.setString(6, staff.getPhone());
            ps.setDate(7, staff.getDob());
            ps.setString(8, staff.getAvatar());
            ps.setString(9, staff.getAddress());
            ps.setInt(10, staff.getStatus());
            ps.setDate(11, staff.getCreatedAt());
            ps.setDate(12, staff.getUpdatedAt());
            ps.setInt(13, staff.getRole());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Consider throwing a custom exception here
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStaff(Staff staff) {
        if (searchStaffById(String.valueOf(staff.getId()))) {
            String sql = "UPDATE user SET username = ?, password = ?, fName = ?, gender = ?, email = ?, " +
                    "phone = ?, dob = ?, avatar = ?, address = ?, status = ?, updatedAt = ?, role = ? " +
                    "WHERE id = ? AND role = 2";
            try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
                ps.setString(1, staff.getUsername());
                ps.setString(2, staff.getPassword());
                ps.setString(3, staff.getFullName());
                ps.setBoolean(4, staff.isGender());
                ps.setString(5, staff.getEmail());
                ps.setString(6, staff.getPhone());
                ps.setDate(7, staff.getDob());
                ps.setString(8, staff.getAvatar());
                ps.setString(9, staff.getAddress());
                ps.setInt(10, staff.getStatus());
                ps.setDate(11, new java.sql.Date(System.currentTimeMillis()));
                ps.setInt(12, staff.getRole());
                ps.setInt(13, staff.getId());

                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean changeToDisable(String id) {
        String sql = "UPDATE user SET status = 0 WHERE role = 2 AND id = ? AND status = 1";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeToActive(String id) {
        String sql = "UPDATE user SET status = 1 WHERE role = 2 AND id = ? AND status = 0";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy danh sách các nhân viên thỏa mãn điều kiện đã cho.
     *
     * @param condition Điều kiện SQL cho câu lệnh WHERE, ví dụ: "AND status = ?".
     * @param params Các tham số được sử dụng để thay thế cho các dấu ? trong điều kiện.
     * @return Trả về danh sách các đối tượng Staff thỏa mãn điều kiện.
     */
    private List<Staff> getStaffByCondition(String condition, Object... params) {
        // Tạo danh sách để lưu trữ các nhân viên thỏa mãn điều kiện
        List<Staff> staffList = new ArrayList<>();

        // Tạo câu lệnh SQL để lấy các nhân viên có vai trò là 2 (role = 2) và điều kiện bổ sung
        String sql = "SELECT * FROM user WHERE role = 2 " + condition + ";";

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
                    staffList.add(createStaffFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra khi làm việc với cơ sở dữ liệu
            e.printStackTrace();
        }

        // Trả về danh sách các nhân viên thỏa mãn điều kiện đã cho
        return staffList;
    }


    public List<Staff> getAllStaff() {
        return getStaffByCondition("");
    }

    public List<Staff> getStaffActive() {
        return getStaffByCondition("AND status = 1");
    }

    public List<Staff> getStaffDisable() {
        return getStaffByCondition("AND status = 0");
    }

    public List<Staff> searchStaff(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllStaff(); // Hoặc có thể trả về danh sách rỗng
        }
        return getStaffByCondition(
                "AND (fName LIKE ? OR phone LIKE ?) ORDER BY username ASC",
                "%" + keyword.trim() + "%",
                "%" + keyword.trim() + "%"
        );
    }

    public List<Staff> searchAndFilterStaff(String search, String status) {
        // Tạo điều kiện SQL và danh sách tham số
        StringBuilder condition = new StringBuilder();
        List<Object> params = new ArrayList<>();

        // Kiểm tra trạng thái và thêm vào điều kiện
        if ("1".equals(status)) {
            condition.append("AND status = 1 "); // Active
        } else if ("0".equals(status)) {
            condition.append("AND status = 0 "); // Disable
        }

        // Kiểm tra tiêu chí tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            condition.append("AND (fName LIKE ? OR phone LIKE ?) ");
            params.add("%" + search.trim() + "%"); // Tìm kiếm theo fullname
            params.add("%" + search.trim() + "%"); // Tìm kiếm theo phone
        }

        // Gọi lại phương thức đã có với điều kiện mới
        return getStaffByCondition(condition.toString(), params.toArray());
    }


    public Staff getStaffById(String id) {
        List<Staff> staffs = getStaffByCondition("AND id = ?", id);
        return staffs.isEmpty() ? null : staffs.get(0);
    }

    private Staff createStaffFromResultSet(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setId(rs.getInt("id"));
        staff.setUsername(rs.getString("username"));
        staff.setPassword(rs.getString("password"));
        staff.setFullName(rs.getString("fName"));
        staff.setGender(rs.getBoolean("gender"));
        staff.setEmail(rs.getString("email"));
        staff.setPhone(rs.getString("phone"));
        staff.setDob(rs.getDate("dob"));
        staff.setAvatar(rs.getString("avatar"));
        staff.setAddress(rs.getString("address"));
        staff.setStatus(rs.getInt("status"));
        staff.setCreatedAt(rs.getDate("createdAt"));
        staff.setUpdatedAt(rs.getDate("updatedAt"));
        staff.setRole(rs.getInt("role"));
        return staff;
    }

    /**
     * Kiểm tra xem có tồn tại bản ghi nào trong bảng user thỏa mãn điều kiện đã cho hay không.
     *
     * @param condition Điều kiện SQL cho câu lệnh WHERE, ví dụ: "email = ? AND status = ?".
     * @param params Các tham số được sử dụng để thay thế cho các dấu ? trong điều kiện.
     * @return Trả về true nếu có ít nhất một bản ghi thỏa mãn điều kiện, ngược lại trả về false.
     */
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


    public boolean searchStaffById(String id) {
        return exists("role = 2 AND id = ?", id);
    }

    public boolean isActiveStaff(String id) {
        return exists("role = 2 AND id = ? AND status = 1", id);
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

    public static void main(String[] args) {
        StaffProcess staffProcess = new StaffProcess();

        for (Staff staff : staffProcess.searchAndFilterStaff("mai", "0")) {
            System.out.println(staff);
        }
    }
}
