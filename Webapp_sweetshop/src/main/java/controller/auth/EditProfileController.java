package controller.auth;

import dal.user.UserProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet(name = "EditProfileController", value = {"/editprofile"})
public class EditProfileController extends HttpServlet {
    private UserProcess userProcess;

//    @Override
//    public void init() {
//        userProcess = new UserProcess();
//    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng từ session
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("loggedInUser");

            if (loggedInUser == null) {
                response.sendRedirect(request.getContextPath() + "view/login.jsp");
                return;
            }

            // Gửi thông tin người dùng đến trang editprofile.jsp
            request.setAttribute("user", loggedInUser);
            request.getRequestDispatcher("page/auth/edit-profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error and display an error message
            e.printStackTrace();
            request.setAttribute("mess", "An error occurred while retrieving your profile. Please try again.");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("/login");
    }

}
