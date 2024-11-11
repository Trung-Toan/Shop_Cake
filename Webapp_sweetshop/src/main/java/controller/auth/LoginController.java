package controller.auth;

import dal.user.UserProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import session.SessionRepo;
import until.DataEncryptionSHA256;

import java.io.IOException;

@WebServlet(name = "login", value = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (req.getParameter("action") == null) {
                if (req.getParameter("mess") != null) {
                    req.setAttribute("mess", req.getParameter("mess"));
                }
                req.getRequestDispatcher("view/login.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("view/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("message", "Error system!");
            req.getRequestDispatcher("view/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (req.getParameter("btnLogin") != null) {
                login(req, resp);
            } else if (req.getParameter("btnRegister") != null) {
                register(req, resp);
            } else {
                req.setAttribute("message", "Error system!");
                doGet(req, resp);
            }
        } catch (Exception ex) {
            req.setAttribute("message", "Error system!");
            doGet(req, resp);
        }
    }

    /**
     * login to system
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        User user = UserProcess.Instance.loadUser(username, DataEncryptionSHA256.hashPassword(password));

        if (user != null) {
            // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            SessionRepo.setUser(request, response, user);
            switch (user.getRole()) {
                case (2): // role staff
                    response.sendRedirect(request.getContextPath() + "/getcustomer");
                    break;
                case (3): // role shipper
                    response.sendRedirect(request.getContextPath() + "/getcustomer");
                    break;
                case (4): // role admin
                    response.sendRedirect(request.getContextPath() + "/getstaff");
                    break;
                default: // role customer
                    response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("message", "Username or password is incorrect!");
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    /**
     * register to login system
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String email = request.getParameter("email").trim();

        User user = UserProcess.Instance.findByEmail(email);
        if (user == null) {
            String uID = UserProcess.Instance.addAndReturnId(username, DataEncryptionSHA256.hashPassword(password), email);
            if (uID == null) {
                request.setAttribute("message", "Create new account not success!");
                request.setAttribute("username", username);
                request.setAttribute("password", password);
                request.setAttribute("email", email);
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
            } else {
                request.setAttribute("mess", "Create new account successful!");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("message", "Email is exist!");
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
        }
    }
}