package session;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

public class SessionRepo {
    public static SessionRepo INSTANCE = new SessionRepo();

    private SessionRepo() {}


    // user
    public static User getUser(HttpServletRequest request, HttpServletResponse response) {
        return (User) request.getSession().getAttribute("user");
    }

    public static void setUser(HttpServletRequest request, HttpServletResponse response, User user) {
        request.getSession().setAttribute("user", user);
    }

    public static void removeUser(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("user");
    }

    //user find by email
    public static User getUserFindByEmail(HttpServletRequest request, HttpServletResponse response) {
        return (User) request.getSession().getAttribute("userFindByEmail");
    }

    public static void setUserFindByEmail(HttpServletRequest request, HttpServletResponse response, User user) {
        request.getSession().setAttribute("userFindByEmail", user);
    }


    public static void removeUserFindByEmail(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("userFindByEmail");
    }

    // search
    public static String getSearch(HttpServletRequest request, HttpServletResponse response) {
        return (String) request.getSession().getAttribute("search");
    }

    public static void setSearch(HttpServletRequest request, HttpServletResponse response, String search) {
        request.getSession().setAttribute("search", search);
    }

    // sort
    public static String getSort(HttpServletRequest request, HttpServletResponse response) {
        return (String) request.getSession().getAttribute("sort");
    }

    public static void setSort(HttpServletRequest request, HttpServletResponse response, String sort) {
        request.getSession().setAttribute("sort", sort);
    }
}
