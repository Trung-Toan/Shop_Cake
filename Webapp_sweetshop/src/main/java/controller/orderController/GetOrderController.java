package controller.orderController;

import dal.order.OrderProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Order;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetOrderController", value = {"/getorder"})
public class GetOrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng từ session
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            if (loggedInUser == null || loggedInUser.getRole() == 1 || loggedInUser.getRole() == 4) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            } else {
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

                List<Order> orderList =OrderProcess.INSTANCE.getAllOrders();
                request.setAttribute("orders", orderList);
                request.setAttribute("status", "all");

                request.getRequestDispatcher("page/order/order-list.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Log the error and display an error message
            e.printStackTrace();
            request.setAttribute("mess", "An error occurred while accessing. Please try again.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy giá trị từ form
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        // Danh sách đơn hàng để trả về
        List<Order> orderList;

        // Xử lý tìm kiếm và lọc theo trạng thái
        if ((status == null || status.equals("all")) && (search == null || search.trim().isEmpty())) {
            // Nếu cả status và search đều không có, lấy tất cả các đơn hàng
            orderList = OrderProcess.INSTANCE.getAllOrders();
        } else if (status == null || status.equals("all")) {
            // Nếu chỉ có search, tìm theo từ khóa search
            orderList = OrderProcess.INSTANCE.searchOrders(search);
        } else if (search == null || search.trim().isEmpty()) {
            // Nếu chỉ có status, lọc theo trạng thái
            int statusValue = Integer.parseInt(status); // Chuyển status sang kiểu int
            orderList = OrderProcess.INSTANCE.getOrdersByStatus(statusValue);
        } else {
            // Nếu có cả search và status, lọc theo cả hai điều kiện
            int statusValue = Integer.parseInt(status); // Chuyển status sang kiểu int
            orderList = OrderProcess.INSTANCE.searchAndFilterOrders(search, statusValue);
        }

        // Đặt danh sách đơn hàng vào request scope
        request.setAttribute("orders", orderList);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        // Chuyển hướng tới trang JSP để hiển thị kết quả
        request.getRequestDispatcher("page/order/order-list.jsp").forward(request, response);
    }

}
