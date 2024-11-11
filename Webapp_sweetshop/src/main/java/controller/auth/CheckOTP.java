package controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import session.SessionRepo;
import until.RandomCode;
import until.SendEmail;

import java.io.IOException;

@WebServlet(name = "check_otp", value = "/check_otp")
public class CheckOTP extends HttpServlet {

    int otp = 0;
    User user = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        user = SessionRepo.getUserFindByEmail(request, response);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/forget_password?message=Enter again your email!");
        } else {
            otp = RandomCode.randomCode(6);
            String content = "<div>" +
                    "<p style=\"font-size:14px;\">Your confirmation code:</p>" +
                    "<h1 style=\"background-color:#e6f7ff;padding:16px 0;font-size:40px;line-height:140%;text-align:center;letter-spacing:0.04em\">" + otp + "</h1>" +
                    "<p style=\"font-size:14px;\">If you received this email by mistake, just ignore it.</p>" +
                    "</div>";
            SendEmail.sendMail(user.getEmail(), "Your verification code", content);
            request.getRequestDispatcher("view/check_otp.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/forget_password?message=Enter again your email!");
        } else {
            String otpInput = request.getParameter("otp");
            if (otpInput != null && otpInput.length() == 6 && otpInput.matches("^[0-9]{6}$") && otpInput.equals(otp + "")) {
                response.sendRedirect(request.getContextPath() + "/change_password");
            } else {
                request.setAttribute("message", "Invalid otp.Enter again!");
                request.getRequestDispatcher("view/check_otp.jsp").forward(request, response);
            }
        }
    }
}
