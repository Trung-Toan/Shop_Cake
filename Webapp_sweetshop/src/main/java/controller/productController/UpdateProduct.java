package controller.productController;

import dal.category.CategoryProcess;
import dal.media.MediaProcess;
import dal.product.ProductProcess;
import dal.productDetail.ProductDetailProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Category;
import model.Media;
import model.Product;
import model.ProductDetail;

import java.io.IOException;
import java.util.Collection;
import java.util.List;

import static until.UploadFile.processFileParts;

@MultipartConfig
@WebServlet(name = "update_product", value = "/update_product")
public class UpdateProduct extends HttpServlet {
    String pid = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (pid == null) {
                pid = request.getParameter("id");
            } else {
                if (!pid.equals(request.getParameter("id")) && request.getParameter("id") != null) {
                    pid = request.getParameter("id");
                }
            }

            if (pid == null) {
                throw new Exception();
            }
            Product product = ProductProcess.INSTANCE.getProductById(pid);
            List<ProductDetail> productDetailList = ProductDetailProcess.INSTANCE.getProductDetailByProductID(pid);
            List<Media> mediaList = MediaProcess.INSTANCE.getAllMediaByProductID(pid);
            request.setAttribute("product", product);
            request.setAttribute("productDetailList", productDetailList);
            request.setAttribute("mediaList", mediaList);
            List<Category> categoryList = CategoryProcess.INSTANCE.getCatagoryActive();
            request.setAttribute("categoryList", categoryList);
            request.getRequestDispatcher("/page/product/update_product.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/view_list_product?mess=Please choose a product&type=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // update product
            if (pid == null) {
                throw new Exception();
            }
            updateProduct(request, response);
            // update product detail
            boolean updateProductDetail = updateProductDetail(request, response);
            if (!updateProductDetail) {
                request.setAttribute("mess", "price must be greater than or equal to 1000");
                request.setAttribute("type", "error");
                doGet(request, response);
                return;
            }
            // delete duct
            deleteProduct(request, response);
            // add more product detail
            boolean addProductDetail = addProductDetail(request, response);
            if (!addProductDetail) {
                request.setAttribute("mess", "Add product detail failed");
                request.setAttribute("type", "error");
                doGet(request, response);
                return;
            }
            // delete media
            String imageDelete = request.getParameter("imageDelete");
            deleteMedia(request, response, imageDelete);
            // createMedia
            Collection<Part> fileParts = request.getParts();
            String base64Images;
            try {
                base64Images = processFileParts(fileParts, "imageFile");
                if (!base64Images.isEmpty()) {
                    MediaProcess.INSTANCE.add(base64Images, null, pid);
                }
            } catch (IOException e) {
                request.setAttribute("mess", e.getMessage());
                request.setAttribute("type", "error");
                doGet(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/view_list_product?mess=Update product is successfully!&type=success");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/view_list_product?mess=Please choose a product&type=error");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productNameUpdate = request.getParameter("productNameUpdate");
        String productCategoryUpdate = request.getParameter("productCategoryUpdate");
        String productIngredientUpdate = request.getParameter("productIngredientUpdate");
        String productDescriptionUpdate = request.getParameter("productDescriptionUpdate");
        String productStatusUpdate = request.getParameter("productStatusUpdate");
        if (productNameUpdate != null && productCategoryUpdate != null && productIngredientUpdate != null && productDescriptionUpdate != null && productStatusUpdate != null &&
                !productNameUpdate.isEmpty() && !productCategoryUpdate.isEmpty() && !productIngredientUpdate.isEmpty() && !productDescriptionUpdate.isEmpty()) {
            ProductProcess.INSTANCE.update(pid, productNameUpdate, productIngredientUpdate, productDescriptionUpdate, productStatusUpdate, productCategoryUpdate);
        }
    }

    private boolean updateProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean check = true;
        String[] productPriceUpdate = request.getParameterValues("productPriceUpdate");
        String[] productSizeUpdate = request.getParameterValues("productSizeUpdate");
        String pdIdUpdate = request.getParameter("pdIdUpdate");
        if (productPriceUpdate != null && productSizeUpdate != null && productPriceUpdate.length > 0
                && productSizeUpdate.length > 0 && pdIdUpdate != null && !pdIdUpdate.isEmpty()) {
            for (String s : productPriceUpdate) {
                if (s.length() < 6 || (s.length() == 6 && s.compareTo("1000.0") < 0)) {
                    check = false;
                    break;
                }
            }
            if (check) {
                ProductDetailProcess.INSTANCE.update(productPriceUpdate, productSizeUpdate, pdIdUpdate);
            }
        }
        return check;
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productDetailDelete = request.getParameter("productDetailDelete");
        if (productDetailDelete != null && !productDetailDelete.isEmpty()) {
            ProductDetailProcess.INSTANCE.remove(productDetailDelete);
        }
    }

    private boolean addProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean check = true;
        try{
            String[] productSize = request.getParameterValues("productSize");
            String[] productPrice = request.getParameterValues("productPrice");
            if (productSize != null && productPrice != null && productSize.length > 0 && productPrice.length > 0) {
                for (String s : productPrice) {
                    if (Integer.parseInt(s) < 1000){
                        check = false;
                        break;
                    }
                }
                if (check) {
                    ProductDetailProcess.INSTANCE.create(productPrice, productSize, pid);
                }
            }
            if ( (productSize!=null && productPrice == null) ||(productSize == null && productPrice != null)) {
                check = false;
            }
        }catch (Exception e){
            check=false;
        }
        return check;
    }

    private void deleteMedia(HttpServletRequest request, HttpServletResponse response, String mid) throws ServletException, IOException {
        if (mid != null && !mid.isEmpty()) {
            MediaProcess.INSTANCE.remove(mid);
        }
    }
}
