package dal.Customer;

import dal.DAO;
import model.Customer;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerProcess extends DAO {

    public CustomerProcess() {
        // Initialization can be done if needed
    }

    public boolean add(Customer customer) {
        if (customer == null) {
            throw new IllegalArgumentException("Customer object cannot be null");
        }
        String sql = "INSERT INTO user (username, password, fName, gender, email, phone, dob, avatar, address, status, createdAt, updatedAt, role) " +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getPassword());
            ps.setString(3, customer.getFullName());
            ps.setBoolean(4, customer.isGender());
            ps.setString(5, customer.getEmail());
            ps.setString(6, customer.getPhone());
            ps.setDate(7, customer.getDob());
            ps.setString(8, customer.getAvatar());
            ps.setString(9, customer.getAddress());
            ps.setInt(10, customer.getStatus());
            ps.setDate(11, customer.getCreatedAt());
            ps.setDate(12, customer.getUpdatedAt());
            ps.setInt(13, customer.getRole());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Consider throwing a custom exception here
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCustomer(Customer customer) {
        if (searchCustomerById(String.valueOf(customer.getId()))) {
            String sql = "UPDATE user SET username = ?, password = ?, fName = ?, gender = ?, email = ?, " +
                    "phone = ?, dob = ?, avatar = ?, address = ?, status = ?, updatedAt = ?, role = ? " +
                    "WHERE id = ? AND role = 1";
            try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
                ps.setString(1, customer.getUsername());
                ps.setString(2, customer.getPassword());
                ps.setString(3, customer.getFullName());
                ps.setBoolean(4, customer.isGender());
                ps.setString(5, customer.getEmail());
                ps.setString(6, customer.getPhone());
                ps.setDate(7, customer.getDob());
                ps.setString(8, customer.getAvatar());
                ps.setString(9, customer.getAddress());
                ps.setInt(10, customer.getStatus());
                ps.setDate(11, new Date(System.currentTimeMillis()));
                ps.setInt(12, customer.getRole());
                ps.setInt(13, customer.getId());

                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean changeToDisable(String id) {
        String sql = "UPDATE user SET status = 0 WHERE role = 1 AND id = ? AND status = 1";
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeToActive(String id) {
        String sql = "UPDATE user SET status = 1 WHERE role = 1 AND id = ? AND status = 0";
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
     * @return Trả về danh sách các đối tượng Customer thỏa mãn điều kiện.
     */
    private List<Customer> getCustomerByCondition(String condition, Object... params) {
        // Tạo danh sách để lưu trữ các nhân viên thỏa mãn điều kiện
        List<Customer> customerList = new ArrayList<>();

        // Tạo câu lệnh SQL để lấy các nhân viên có vai trò là 1 (role = 1) và điều kiện bổ sung
        String sql = "SELECT * FROM user WHERE role = 1 " + condition + ";";

        // Sử dụng try-with-resources để tự động đóng PreparedStatement và ResultSet sau khi sử dụng
        try (PreparedStatement ps = this.connection.prepareStatement(sql)) {
            // Gán các giá trị tham số vào câu lệnh SQL, bắt đầu từ vị trí 1
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]); // i + 1 vì vị trí trong PreparedStatement bắt đầu từ 1
            }

            // Thực thi câu lệnh SQL và nhận kết quả dưới dạng ResultSet
            try (ResultSet rs = ps.executeQuery()) {
                // Duyệt qua từng bản ghi trong ResultSet và tạo đối tượng Customer tương ứng
                while (rs.next()) {
                    // Thêm đối tượng Customer được tạo vào danh sách
                    customerList.add(createCustomerFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra khi làm việc với cơ sở dữ liệu
            e.printStackTrace();
        }

        // Trả về danh sách các nhân viên thỏa mãn điều kiện đã cho
        return customerList;
    }


    public List<Customer> getAllCustomer() {
        return getCustomerByCondition("");
    }

    public List<Customer> getCustomerActive() {
        return getCustomerByCondition("AND status = 1");
    }

    public List<Customer> getCustomerDisable() {
        return getCustomerByCondition("AND status = 0");
    }

    public List<Customer> searchCustomer(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllCustomer(); // Hoặc có thể trả về danh sách rỗng
        }
        return getCustomerByCondition(
                "AND (fName LIKE ? OR phone LIKE ?) ORDER BY username ASC",
                "%" + keyword.trim() + "%",
                "%" + keyword.trim() + "%"
        );
    }

    public List<Customer> searchAndFilterCustomer(String search, String status) {
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
        return getCustomerByCondition(condition.toString(), params.toArray());
    }


    public Customer getCustomerById(String id) {
        List<Customer> customers = getCustomerByCondition("AND id = ?", id);
        return customers.isEmpty() ? null : customers.get(0);
    }

    private Customer createCustomerFromResultSet(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setUsername(rs.getString("username"));
        customer.setPassword(rs.getString("password"));
        customer.setFullName(rs.getString("fName"));
        customer.setGender(rs.getBoolean("gender"));
        customer.setEmail(rs.getString("email"));
        customer.setPhone(rs.getString("phone"));
        customer.setDob(rs.getDate("dob"));
        customer.setAvatar(rs.getString("avatar"));
        customer.setAddress(rs.getString("address"));
        customer.setStatus(rs.getInt("status"));
        customer.setCreatedAt(rs.getDate("createdAt"));
        customer.setUpdatedAt(rs.getDate("updatedAt"));
        customer.setRole(rs.getInt("role"));
        return customer;
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


    public boolean searchCustomerById(String id) {
        return exists("role = 1 AND id = ?", id);
    }

    public boolean isActiveCustomer(String id) {
        return exists("role = 1 AND id = ? AND status = 1", id);
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
        CustomerProcess customerProcess = new CustomerProcess();

        for (Customer customer : customerProcess.getAllCustomer()) {
            System.out.println(customer);
        }
    }
}
