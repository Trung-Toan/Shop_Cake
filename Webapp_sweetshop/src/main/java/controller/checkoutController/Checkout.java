package controller.checkoutController;

import dal.order.OrderProcess;
import dal.orderDetail.OrderDetailProcess;
import dal.product.ProductProcess;
import dal.productDetail.ProductDetailProcess;
import dal.user.UserProcess;
import dal.voucher.VoucherProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.ProductDetail;
import model.User;
import model.Voucher;
import session.SessionRepo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "checkout", value = "/checkout")
public class Checkout extends HttpServlet {
    String errorMessage = "";
    String idPd = null;
    String quantity = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        idPd = request.getParameter("idPd");
        quantity = request.getParameter("quantity");
        String[] idProductDetails = idPd.split(",");
        String[] locations = {
                "Bình Phú", "Bình Yên", "Cẩm Yên", "Cần Kiệm", "Canh Nậu",
                "Chàng Sơn", "Đại Đồng", "Dị Nậu", "Đồng Trúc", "Hạ Bằng",
                "Hương Ngải", "Hữu Bằng", "Kim Quan", "Lại Thượng", "Phú Kim",
                "Phùng Xá", "Tân Xã", "Thạch Hòa", "Thạch Xá"
        };
        List<ProductDetail> listProductDetails = ProductDetailProcess.INSTANCE.getPDByListPDId(idProductDetails);
        List<Voucher> voucherList = VoucherProcess.INSTANCE.read();
        String codeVoucher = "|";
        for (Voucher voucher : voucherList) {
            codeVoucher += voucher.getCode() + "|";
        }
        request.setAttribute("codeVoucher", codeVoucher);
        request.setAttribute("product", ProductProcess.INSTANCE);
        request.setAttribute("listPD", listProductDetails);
        request.setAttribute("location", locations);
        request.getRequestDispatcher("/view/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            User user = SessionRepo.getUser(request, response);
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String fullName = firstName + " " + lastName;
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String village = request.getParameter("village");
            String location = request.getParameter("location");
            String district = request.getParameter("district");
            String country = request.getParameter("country");
            String shipAddress = village + ", " + location + "," + district + "," + country;
            String voucher = request.getParameter("voucher").isEmpty() ? null : VoucherProcess.INSTANCE.useVoucher(request.getParameter("voucher"));
            String price = request.getParameter("pice");
            float p;
            if (price == null || price.equals("")) {
                p = (float) 0.0;
            } else {
                price = price.replace(",", ".");
                p = Float.parseFloat(price);
            }
            float totalPrice = p - (p * Float.parseFloat(voucher == null ? "0" : voucher) / 100);
            if (request.getParameter("btnPlaceOrder") != null) {
                if (user == null) {
                    String idUser = UserProcess.Instance.addAndReturnId(new User());
                    if (idUser != null) {
                        String idOrder = OrderProcess.INSTANCE.create(fullName, phone, email, shipAddress, voucher, idUser);
                        if (idOrder != null) {
                            String idOD = OrderDetailProcess.INSTANCE.createReturnID(totalPrice, quantity, idOrder, idPd);
                            if (idOD == null) {
                                errorMessage = "Cannot buy product!";
                                request.setAttribute("errorMessage", errorMessage);
                                doGet(request, response);
                            } else {
                                response.sendRedirect(request.getContextPath() + "/home?message=Buy product successfully!");
                            }
                        } else {
                            errorMessage = "Cannot buy product!";
                            request.setAttribute("errorMessage", errorMessage);
                            doGet(request, response);
                        }
                    } else {
                        errorMessage = "Cannot buy product!";
                        request.setAttribute("errorMessage", errorMessage);
                        doGet(request, response);
                    }
                }
            }
        } catch (Exception e) {
            errorMessage = "The system error!";
            request.setAttribute("errorMessage", errorMessage);
            doGet(request, response);
        }
    }
}
