package controller.auth;

import dal.user.UserProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import session.SessionRepo;

import java.io.IOException;

@WebServlet(name = "forget", value = "/forget_password")
public class ForgetPass extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionRepo.removeUserFindByEmail(request,response);
        request.setAttribute("message", request.getParameter("message") == null ? "" : request.getParameter("message"));
        request.getRequestDispatcher("view/forgetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = UserProcess.Instance.findByEmail(email);
        if (user != null) {
            SessionRepo.setUserFindByEmail(request,response,user);
            response.sendRedirect(request.getContextPath() + "/check_otp");
        } else {
            request.setAttribute("email", email);
            request.setAttribute("message", "Email is not found");
            doGet(request, response);
        }
    }
}
