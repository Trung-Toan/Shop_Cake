package controller.auth;

import dal.user.UserProcess;
import jakarta.servlet.http.*;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import until.DataEncryptionSHA256;

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

@WebServlet(name = "UpdateProfileController", value = {"/updateprofile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateProfileController extends HttpServlet {

    private static final int MAX_FILE_SIZE = 1024 * 1024 * 10; // 10MB
    private static final Logger logger = Logger.getLogger(UpdateProfileController.class.getName());

//    @Override
//    public void init() {
//        staffProcess = new UserProcess();
//    }
//    private static final String UPLOAD_DIRECTORY = "assets/avatar";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/page/auth/edit-profile.jsp").forward(request, response);
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

            // Lấy thông tin cũ của ng dùng
            User oldUser = UserProcess.Instance.searchProfile(id);
            if (oldUser == null) {
                request.setAttribute("message", "Profile not found.");
                request.getRequestDispatcher("/page/auth/edit-profile.jsp").forward(request, response);
                return;
            }
            // Chuyển đổi ảnh sang Base64
            String base64Image = uploadAndConvertImage(filePart, profilePicOriginal);

            // Kiểm tra thông tin
            String validationMessage = validateStaffInfo(username, email, phone, dobParam, genderParam, address, statusParam, filePart, oldUser);
            if (validationMessage != null) {
                request.setAttribute("message", validationMessage);
                forwardWithUser(request, response, id, username, fullName, genderParam, email, phone,
                        dobParam, address, statusParam, base64Image != null ? base64Image : oldUser.getAvatar(),
                        oldUser.getCreatedAt(), oldUser.getUpdatedAt());
                return;
            }



            // Chuyển đổi giới tính và trạng thái
            boolean gender = "true".equalsIgnoreCase(genderParam);  // true cho Male, false cho Female
            int status = "1".equals(statusParam) ? 1 : 0;

            // Tạo đối tượng Staff mới với thông tin đã cập nhật
            User updatedUser = new User();
            updatedUser.setId(Integer.parseInt(id));
            updatedUser.setAvatar(base64Image != null ? base64Image : oldUser.getAvatar());
            updatedUser.setUsername(username);
            updatedUser.setFullName(fullName);
            updatedUser.setGender(gender);
            updatedUser.setEmail(email);
            updatedUser.setPhone(phone);
            updatedUser.setDob(Date.valueOf(LocalDate.parse(dobParam)));
            updatedUser.setAddress(address);
            updatedUser.setStatus(status);
            updatedUser.setRole(oldUser.getRole());
            updatedUser.setCreatedAt(oldUser.getCreatedAt());
            updatedUser.setUpdatedAt(new Date(System.currentTimeMillis()));

            // Cập nhật thông tin nhân viên trong cơ sở dữ liệu
            boolean updateSuccess = UserProcess.Instance.updateProfile(updatedUser);
            if (updateSuccess) {
                // Xóa session cũ
                HttpSession session = request.getSession();
                session.invalidate();

                // Tạo session mới
                session = request.getSession(true); // Khởi tạo session mới
                session.setAttribute("loggedInUser", updatedUser); // Lưu đối tượng User đã cập nhật vào session mới

                // Cập nhật thông báo và điều hướng đến trang edit-profile
                request.setAttribute("message", "Profile updated successfully!");
                request.getRequestDispatcher("/page/auth/edit-profile.jsp").forward(request, response);
                return;
            } else {
                request.setAttribute("message", "Failed to update profile.");
                forwardWithUser(request, response, id, username, fullName, genderParam, email, phone,
                        dobParam, address, statusParam, base64Image != null ? base64Image : oldUser.getAvatar(),
                        oldUser.getCreatedAt(), oldUser.getUpdatedAt());
                return;
            }
        } catch (Exception ex) {
            logger.severe("Error in UpdateProfileController: " + ex.getMessage());
            request.setAttribute("message", "An unexpected error occurred. Please try again.");
        }
        request.getRequestDispatcher("/page/auth/edit-profile.jsp").forward(request, response);
    }


    private String validateStaffInfo(String username, String email, String phone, String dobParam,
                                     String genderParam, String address, String statusParam, Part filePart, User oldUser) {
        // Kiểm tra các thông tin đầu vào
        if (username.isEmpty() || email.isEmpty() || phone.isEmpty() || dobParam.isEmpty() ||
                genderParam.isEmpty() || address.isEmpty()) {
            return "All fields are required."; }
// Kiểm tra tên đăng nhập, email và số điện thoại có bị trùng không nhưng bỏ qua nếu là của nhân viên hiện tại
        if (!username.equals(oldUser.getUsername()) && UserProcess.Instance.isUsernameTaken(username)) {
            return "Username already taken.";
        }
        if (!email.equals(oldUser.getEmail()) && UserProcess.Instance.isEmailTaken(email)) {
            return "Email already in use.";
        }
        if (!phone.equals(oldUser.getPhone()) && UserProcess.Instance.isPhoneTaken(phone)) {
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
                return "User must be at least 0 years old.";}
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

    private void forwardWithUser(HttpServletRequest request, HttpServletResponse response, String id, String username,
                                  String fullName, String gender, String email, String phone, String dob,
                                  String address, String status, String profilePic, Date createdAt, Date updatedAt) throws ServletException, IOException {
        User User = new User();
        User.setId(Integer.parseInt(id));
        User.setUsername(username);
        User.setFullName(fullName);
        User.setGender("Male".equalsIgnoreCase(gender));
        User.setEmail(email);
        User.setPhone(phone);
        User.setDob(Date.valueOf(LocalDate.parse(dob)));
        User.setAddress(address);
        User.setStatus("Active".equalsIgnoreCase(status) ? 1 : 0);
        User.setAvatar(profilePic); // Sử dụng ảnh hiện tại nếu có
        User.setCreatedAt(createdAt);
        User.setUpdatedAt(updatedAt);


        request.setAttribute("loggedInUser", User);  // Đưa staff vào request attribute
        request.getRequestDispatcher("/page/auth/edit-profile.jsp").forward(request, response);
    }
}
