package controller.staffController;

import dal.staff.StaffProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Staff;
import model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetStaffController", value = {"/getstaff"})
public class GetStaffController extends HttpServlet {
    private StaffProcess staffProcess;
    private static final int ROLE_ADMIN = 4;

    @Override
    public void init() {
        staffProcess = new StaffProcess();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng từ session
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            if (loggedInUser == null || loggedInUser.getRole() != ROLE_ADMIN) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            // Lấy message và error từ tham số yêu cầu
            String message = request.getParameter("message");
            String error = request.getParameter("error");

            // Đặt message và error vào request scope
            if (message != null && !message.trim().isEmpty()) {
                request.setAttribute("message", message);
            }

            if (error != null && !error.trim().isEmpty()) {
                request.setAttribute("error", error);
            }

            List<Staff> staffList = staffProcess.getAllStaff();
            request.setAttribute("staffs", staffList);

            request.setAttribute("status", "all");
            request.getRequestDispatcher("page/admin/staff-list.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error and display an error message
            e.printStackTrace();
            request.setAttribute("mess", "An error. Please try again.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ form
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        // Khởi tạo StaffProcess để thao tác với database
        StaffProcess staffProcess = new StaffProcess();

        // Danh sách nhân viên để trả về
        List<Staff> staffList;

        // Xử lý tìm kiếm và lọc theo trạng thái
        if (status == null || status.equals("all")) {
            // Nếu trạng thái là "all", tìm theo từ khóa search
            staffList = staffProcess.searchStaff(search);
        } else {
            // Nếu có trạng thái cụ thể, lọc theo trạng thái và từ khóa search
            String statusValue = status.equals("active") ? "1" : "0";
            staffList = staffProcess.searchAndFilterStaff(search, statusValue);
        }

        // Đặt danh sách nhân viên vào request scope
        request.setAttribute("staffs", staffList);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        // Chuyển hướng tới trang JSP để hiển thị kết quả
        request.getRequestDispatcher("page/admin/staff-list.jsp").forward(request, response); // Chuyển hướng về trang danh sách staff
    }
}
