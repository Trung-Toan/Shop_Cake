package controller.cartController;

import dal.Customer.CustomerProcess;
import dal.staff.StaffProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewCartController", value = {"/viewcart"})
public class ViewCartController extends HttpServlet {
    private CustomerProcess customerProcess;

    @Override
    public void init() {
        customerProcess = new CustomerProcess();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        List<Customer> customerList = customerProcess.getAllCustomer();
        request.setAttribute("customers", customerList);
        request.setAttribute("status", "all");

        request.getRequestDispatcher("page/staff/customer-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ form
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        // Khởi tạo CustomerProcess để thao tác với database
        CustomerProcess customerProcess = new CustomerProcess();

        // Danh sách khách hàng để trả về
        List<Customer> customerList;

        // Xử lý tìm kiếm và lọc theo trạng thái
        if (status == null || status.equals("all")) {
            // Nếu trạng thái là "all", tìm theo từ khóa search
            customerList = customerProcess.searchCustomer(search);
        } else {
            // Nếu có trạng thái cụ thể, lọc theo trạng thái và từ khóa search
            String statusValue = status.equals("active") ? "1" : "0";
            customerList = customerProcess.searchAndFilterCustomer(search, statusValue);
        }

        // Đặt danh sách khách hàng vào request scope
        request.setAttribute("customers", customerList);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        // Chuyển hướng tới trang JSP để hiển thị kết quả
        request.getRequestDispatcher("page/staff/customer-list.jsp").forward(request, response); // Chuyển hướng về trang danh sách staff
    }
}
