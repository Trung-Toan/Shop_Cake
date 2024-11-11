package controller.auth;

import dal.user.UserProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import session.SessionRepo;
import until.DataEncryptionSHA256;

import java.io.IOException;

@WebServlet(name = "change_password", value = "/change_password")
public class ChangePassword extends HttpServlet {

    User user = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        user = SessionRepo.getUserFindByEmail(request, response);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/forget_password?message=Enter again your email!");
        } else {
            request.getRequestDispatcher("view/change_password.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        user = SessionRepo.getUserFindByEmail(request, response);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/forget_password?message=Enter again your email!");
        } else {
            String password = request.getParameter("password");
            String repeatPassword = request.getParameter("repeat_password");
            if (password.equals(repeatPassword)) {
                user.setPassword(DataEncryptionSHA256.hashPassword(password));
                user = UserProcess.Instance.updateUser(user);
                if (user != null) {
                    response.sendRedirect(request.getContextPath() + "/login?mess=You have successfully changed your password!");
                } else {
                    request.setAttribute("message", "Cannot change your password!");
                    request.getRequestDispatcher("view/change_password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Passwords do not match!");
                request.getRequestDispatcher("view/change_password.jsp").forward(request, response);
            }
        }
    }
}
