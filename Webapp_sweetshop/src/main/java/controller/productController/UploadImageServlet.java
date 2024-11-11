package controller.productController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.Collection;
import static until.UploadFile.processFileParts;

@WebServlet("/uploadImage")
@MultipartConfig
public class UploadImageServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/page/product/convert-to-base64.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Collection<Part> fileParts = request.getParts();
        try {
            String base64Images = processFileParts(fileParts, "imageFile");
            request.setAttribute("base64Images", base64Images);
            request.getRequestDispatcher("/page/product/result.jsp").forward(request, response);
        } catch (IOException e) {
            request.setAttribute("mess", e.getMessage());
            doGet(request, response);
        }
    }





}
