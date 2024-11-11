package controller.staffController;

import dal.staff.StaffProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Staff;

import java.io.IOException;

@WebServlet(name = "EditStaffController", value = {"/editstaff"})
public class EditStaffController extends HttpServlet {
    private StaffProcess staffProcess;

    @Override
    public void init() {
        staffProcess = new StaffProcess();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("/getstaff");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ form
        String staffId = request.getParameter("id");

        // Kiểm tra giá trị staffId có hợp lệ không
        if (staffId == null || staffId.isEmpty()) {
            request.setAttribute("error", "Invalid staff ID.");
            request.getRequestDispatcher("/getstaff").forward(request, response);
            return;  // Dừng lại nếu staffId không hợp lệ
        }

        try {
            // Lấy thông tin nhân viên từ lớp DAO
            Staff staff = staffProcess.getStaffById(staffId);

            if (staff != null) {
                // Nếu tìm thấy nhân viên, hiển thị trang chỉnh sửa
                request.setAttribute("staff", staff);
                request.getRequestDispatcher("page/admin/edit-staff.jsp").forward(request, response);
            } else {
                // Không tìm thấy nhân viên
                request.setAttribute("error", "No staff found with ID: " + staffId);
                request.getRequestDispatcher("/getstaff").forward(request, response);
            }

        } catch (Exception e) {
            // Xử lý lỗi từ cơ sở dữ liệu hoặc các ngoại lệ không mong muốn khác
            request.setAttribute("error", "An error occurred during processing: " + e.getMessage());
            request.getRequestDispatcher("/getstaff").forward(request, response);
        }
    }

}
