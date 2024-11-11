package controller.productController;

import dal.category.CategoryProcess;
import dal.media.MediaProcess;
import dal.product.ProductProcess;
import dal.productDetail.ProductDetailProcess;
import dal.user.UserProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import session.SessionRepo;
import until.Unique;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "viewDetail", value = "/viewdetail")
public class ProductDetailController extends HttpServlet {
    String idProduct = null;
    Product product = null;
    Category category = null;
    List<ProductDetail> productDetailList = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        idProduct = request.getParameter("id");
        if (idProduct == null) {
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            product = ProductProcess.INSTANCE.getProductById(idProduct);
            category = CategoryProcess.INSTANCE.getCategoryByID(product.getCategoryID() + "");
            productDetailList = ProductDetailProcess.INSTANCE.getProductDetailByProductID(idProduct);
            List<Media> mediaList = MediaProcess.INSTANCE.getAllMediaByProductID(idProduct);

            request.setAttribute("size", uniqueSize(productDetailList));
            request.setAttribute("category", category);
            request.setAttribute("product", product);
            request.setAttribute("mediaList", mediaList);
            request.setAttribute("productDetail", ProductDetailProcess.INSTANCE);
            request.setAttribute("productDetailList", productDetailList);
            request.getRequestDispatcher("view/product-detail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPd = request.getParameter("idPd");
        String size = request.getParameter("size");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        if (request.getParameter("btnBuy") != null) {
            response.sendRedirect(request.getContextPath() + "/checkout?idPd=" + idPd + "&quantity=" + quantity);
        }
    }

    private List<String> uniqueSize(List<ProductDetail> list) {
        List<String> stringList = new ArrayList<>();
        for (ProductDetail productDetail : list) {
            stringList.add(productDetail.getSize() + "");
        }
        return Unique.uniqueStringsIgnoreCase(stringList);
    }
}
