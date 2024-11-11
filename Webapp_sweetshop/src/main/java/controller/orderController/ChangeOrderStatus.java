package controller.orderController;

import dal.order.OrderProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ChangeOrderStatus", value = {"/changeorderstatus"})
public class ChangeOrderStatus extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/getorder").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID của đơn hàng và trạng thái mới từ các tham số yêu cầu
        String orderId = request.getParameter("id");
        String status = request.getParameter("status");

        // Kiểm tra nếu ID không hợp lệ (null hoặc rỗng)
        if (orderId == null || orderId.trim().isEmpty()) {
            // Nếu ID rỗng, chuyển hướng đến trang danh sách đơn hàng với thông báo lỗi
            response.sendRedirect("getorder?error=Invalid order ID");
            return;
        }
        try {
            // Tìm đơn hàng với ID đã cho
            Order order = OrderProcess.INSTANCE.getOrderById(orderId);

            // Kiểm tra sự tồn tại của đơn hàng
            if (order == null) {
                // Nếu không tìm thấy đơn hàng, chuyển hướng đến trang danh sách với thông báo lỗi
                response.sendRedirect("getorder?error=Order not found");
            } else {
                boolean result = false;
                if ("0".equals(status)) {
                    // Xử lý yêu cầu hủy đơn hàng
                    result = OrderProcess.INSTANCE.cancelOrder(orderId);
                } else {
                    // Xử lý yêu cầu cập nhật trạng thái kế tiếp của đơn hàng
                    int nextStatus = Integer.parseInt(status);
                    int orderIdValue = Integer.parseInt(orderId);
                    result = OrderProcess.INSTANCE.updateOrderStatus(orderIdValue, nextStatus);
                }
                // Kiểm tra kết quả cập nhật trạng thái đơn hàng
                if (result) {
                    // Nếu cập nhật thành công, chuyển hướng đến trang danh sách đơn hàng với thông báo thành công
                    response.sendRedirect("getorder?message=Order status updated successfully");
                } else {
                    // Nếu cập nhật thất bại, chuyển hướng đến trang danh sách với thông báo lỗi
                    response.sendRedirect("getorder?error=Failed to update order status");
                }
            }
        } catch (Exception e) {
            // Bắt bất kỳ lỗi nào xảy ra và chuyển hướng đến trang danh sách với thông báo lỗi
            e.printStackTrace();
            response.sendRedirect("getorder?error=An unexpected error occurred while updating the order status");
        }
    }


}
