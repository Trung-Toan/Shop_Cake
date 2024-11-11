package controller.customerController;

import dal.Customer.CustomerProcess;
import dal.Customer.CustomerProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "EditCustomerController", value = {"/editcustomer"})
public class EditCustomerController extends HttpServlet {
    private CustomerProcess customerProcess;

    @Override
    public void init() {
        customerProcess = new CustomerProcess();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("/getcustomer");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ form
        String customerId = request.getParameter("id");

        // Kiểm tra giá trị customerId có hợp lệ không
        if (customerId == null || customerId.isEmpty()) {
            request.setAttribute("error", "Invalid customer ID.");
            request.getRequestDispatcher("/getcustomer").forward(request, response);
            return;  // Dừng lại nếu customerId không hợp lệ
        }

        try {
            // Lấy thông tin nhân viên từ lớp DAO
            Customer customer = customerProcess.getCustomerById(customerId);

            if (customer != null) {
                // Nếu tìm thấy nhân viên, hiển thị trang chỉnh sửa
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("page/staff/edit-customer.jsp").forward(request, response);
            } else {
                // Không tìm thấy nhân viên
                request.setAttribute("error", "No customer found with ID: " + customerId);
                request.getRequestDispatcher("/getcustomer").forward(request, response);
            }

        } catch (Exception e) {
            // Xử lý lỗi từ cơ sở dữ liệu hoặc các ngoại lệ không mong muốn khác
            request.setAttribute("error", "An error occurred during processing: " + e.getMessage());
            request.getRequestDispatcher("/getcustomer").forward(request, response);
        }
    }

}
