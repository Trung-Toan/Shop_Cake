package controller.staffController;

import dal.staff.StaffProcess;
import model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.format.DateTimeParseException;
import java.util.Base64;
import java.time.LocalDate;
import java.time.Period;
import java.util.logging.Logger;

@WebServlet(name = "UpdateStaffController", value = {"/updatestaff"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateStaffController extends HttpServlet {

    private StaffProcess staffProcess;
    private static final int ROLE_STAFF = 2;
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 10; // 10MB
    private static final Logger logger = Logger.getLogger(UpdateStaffController.class.getName());

    @Override
    public void init() {
        staffProcess = new StaffProcess();
    }
    private static final String UPLOAD_DIRECTORY = "assets/avatar";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/getstaff").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Process normal fields
            String id = request.getParameter("id");
            String username = request.getParameter("uname").trim();
            String fullName = request.getParameter("myname").trim();
            String genderParam = request.getParameter("gender").trim();
            String email = request.getParameter("email").trim();
            String phone = request.getParameter("mobno").trim();
            String dobParam = request.getParameter("dob").trim();
            String address = request.getParameter("address").trim();
            String statusParam = request.getParameter("status").trim();
            Part filePart = request.getPart("profilePic");
            String profilePicOriginal = request.getParameter("profilePicOriginal");

            // Lấy thông tin nhân viên cũ
            Staff oldStaff = staffProcess.getStaffById(id);
            if (oldStaff == null) {
                request.setAttribute("message", "Staff not found.");
                request.getRequestDispatcher("/getstaff").forward(request, response);
                return;
            }
            // Chuyển đổi ảnh sang Base64
            String base64Image = uploadAndConvertImage(filePart, profilePicOriginal);

            // Kiểm tra thông tin
            String validationMessage = validateStaffInfo(username, email, phone, dobParam, genderParam, address, statusParam, filePart, oldStaff);
            if (validationMessage != null) {
                request.setAttribute("message", validationMessage);
                forwardWithStaff(request, response, id, username, fullName, genderParam, email, phone,
                        dobParam, address, statusParam, base64Image != null ? base64Image : oldStaff.getAvatar(),
                        oldStaff.getCreatedAt(), oldStaff.getUpdatedAt());
                return;
            }



            // Chuyển đổi giới tính và trạng thái
            boolean gender = "true".equalsIgnoreCase(genderParam);  // true cho Male, false cho Female
            int status = "1".equals(statusParam) ? 1 : 0;

            // Tạo đối tượng Staff mới với thông tin đã cập nhật
            Staff updatedStaff = new Staff();
            updatedStaff.setId(Integer.parseInt(id));
            updatedStaff.setAvatar(base64Image != null ? base64Image : oldStaff.getAvatar());
            updatedStaff.setUsername(username);
            updatedStaff.setFullName(fullName);
            updatedStaff.setGender(gender);
            updatedStaff.setEmail(email);
            updatedStaff.setPhone(phone);
            updatedStaff.setDob(Date.valueOf(LocalDate.parse(dobParam)));
            updatedStaff.setAddress(address);
            updatedStaff.setStatus(status);
            updatedStaff.setRole(ROLE_STAFF);
            updatedStaff.setCreatedAt(oldStaff.getCreatedAt());
            updatedStaff.setUpdatedAt(new Date(System.currentTimeMillis()));

            // Cập nhật thông tin nhân viên trong cơ sở dữ liệu
            boolean updateSuccess = staffProcess.updateStaff(updatedStaff);
            if (updateSuccess) {
                request.setAttribute("staff", updatedStaff);
                request.setAttribute("message", "Staff updated successfully!");
                request.getRequestDispatcher("/page/admin/edit-staff.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("message", "Failed to update staff.");
                forwardWithStaff(request, response, id, username, fullName, genderParam, email, phone,
                        dobParam, address, statusParam, base64Image != null ? base64Image : oldStaff.getAvatar(),
                        oldStaff.getCreatedAt(), oldStaff.getUpdatedAt());
                return;
            }
        } catch (Exception ex) {
            logger.severe("Error in UpdateStaffController: " + ex.getMessage());
            request.setAttribute("message", "An unexpected error occurred. Please try again.");
        }
        request.getRequestDispatcher("/page/admin/edit-staff.jsp").forward(request, response);
    }


    private String validateStaffInfo(String username, String email, String phone, String dobParam,
                                     String genderParam, String address, String statusParam, Part filePart, Staff oldStaff) {
        // Kiểm tra các thông tin đầu vào
        if (username.isEmpty() || email.isEmpty() || phone.isEmpty() || dobParam.isEmpty() ||
                genderParam.isEmpty() || address.isEmpty()) {
            return "All fields are required."; }
// Kiểm tra tên đăng nhập, email và số điện thoại có bị trùng không nhưng bỏ qua nếu là của nhân viên hiện tại
        if (!username.equals(oldStaff.getUsername()) && staffProcess.isUsernameTaken(username)) {
            return "Username already taken.";
        }
        if (!email.equals(oldStaff.getEmail()) && staffProcess.isEmailTaken(email)) {
            return "Email already in use.";
        }
        if (!phone.equals(oldStaff.getPhone()) && staffProcess.isPhoneTaken(phone)) {
            return "Phone number already in use.";
        }
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return "Invalid email format.";}
        if (!phone.matches("^0\\d{9}$")) {
            return "Invalid phone number format.";}
        LocalDate birthDate;
        try {
            birthDate = LocalDate.parse(dobParam);
            LocalDate today = LocalDate.now();
            if (Period.between(birthDate, today).getYears() < 0) {
                return "Staff must be at least 0 years old.";}
        } catch (DateTimeParseException e) {
            return "Invalid date format.";}

        // Kiểm tra kích thước file
        if (filePart.getSize() > MAX_FILE_SIZE) {
            return "File size exceeds the maximum limit of 10MB.";}
//        // Kiểm tra định dạng tệp
//        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//        String fileExtension = getFileExtension(fileName);
//        if (!fileExtension.equalsIgnoreCase("jpg") && !fileExtension.equalsIgnoreCase("jpeg")) {
//            return "File must be a JPG image.";}
        return null; // Không có lỗi
    }

    private String uploadAndConvertImage(Part filePart, String profilePicOriginal) throws IOException {
        if (filePart.getSize() == 0) {
            return profilePicOriginal; // Nếu không có file mới, giữ nguyên hình cũ
        }

        // Chuyển đổi ảnh sang Base64
        try (InputStream inputStream = filePart.getInputStream();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            return Base64.getEncoder().encodeToString(outputStream.toByteArray());
        }
    }

    private String getFileExtension(String fileName) {
        int lastIndexOfDot = fileName.lastIndexOf('.');
        if (lastIndexOfDot > 0 && lastIndexOfDot < fileName.length() - 1) {
            return fileName.substring(lastIndexOfDot + 1);
        }
        return "";
    }

    private void forwardWithStaff(HttpServletRequest request, HttpServletResponse response, String id, String username,
                                  String fullName, String gender, String email, String phone, String dob,
                                  String address, String status, String profilePic, Date createdAt, Date updatedAt) throws ServletException, IOException {
        Staff staff = new Staff();
        staff.setId(Integer.parseInt(id));
        staff.setUsername(username);
        staff.setFullName(fullName);
        staff.setGender("Male".equalsIgnoreCase(gender));
        staff.setEmail(email);
        staff.setPhone(phone);
        staff.setDob(Date.valueOf(LocalDate.parse(dob)));
        staff.setAddress(address);
        staff.setStatus("Active".equalsIgnoreCase(status) ? 1 : 0);
        staff.setAvatar(profilePic); // Sử dụng ảnh hiện tại nếu có
        staff.setCreatedAt(createdAt);
        staff.setUpdatedAt(updatedAt);


        request.setAttribute("staff", staff);  // Đưa staff vào request attribute
        request.getRequestDispatcher("/page/admin/edit-staff.jsp").forward(request, response);
    }
}
