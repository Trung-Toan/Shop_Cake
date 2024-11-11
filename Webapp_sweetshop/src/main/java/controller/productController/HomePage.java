package controller.productController;

import dal.category.CategoryProcess;
import dal.media.MediaProcess;
import dal.product.ProductProcess;
import dal.productDetail.ProductDetailProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import session.SessionRepo;
import validation.CheckInput;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

/**
 * Servlet xử lý yêu cầu hiển thị trang chủ với danh sách sản phẩm.
 */
public class HomePage extends HttpServlet {

    /** Số sản phẩm hiển thị trên mỗi trang. */
    private static final int LIMIT = 12;

    /**
     * Xử lý yêu cầu GET cho trang chủ.
     *
     * @param request  đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @param response đối tượng HttpServletResponse chứa thông tin phản hồi
     * @throws ServletException nếu có lỗi về phía Servlet
     * @throws IOException      nếu có lỗi về đầu vào/đầu ra
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = getCurrentPage(request);
        String findByName = getSearchKeyword(request, response);
        String sort = getSortOrder(request, response);
        String category = getCategory(request);
        int totalProducts = ProductProcess.INSTANCE.getTotalProducts(findByName, category);
        int totalPages = calculateTotalPages(totalProducts);
        page = validateCurrentPage(page, totalPages);

        int offset = (page - 1) * LIMIT;
        List<Product> products = ProductProcess.INSTANCE.getProductsByPage(findByName, LIMIT, offset, sort, category);

        setRequestAttributes(request, response, products, page, totalPages);
        request.getRequestDispatcher("view/index.jsp").forward(request, response);
    }

    /**
     * get category from request or session
     *
     * @param request đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @return category
     */
    private String getCategory(HttpServletRequest request) {
        String[] categoryArray = request.getParameterValues("category");
        if (categoryArray != null && categoryArray.length > 0) {
            Vector<String> list = new Vector<>();
            for (String category : categoryArray) {
                list.add(category);
            }
            String categories = String.join(",", list);
            request.setAttribute("list", list);
            request.getSession().setAttribute("category", categories);
            return categories;
        }
        return null;
    }



    /**
     * Lấy số trang hiện tại từ tham số request và kiểm tra tính hợp lệ.
     *
     * @param request đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @return số trang hiện tại, mặc định là 1 nếu không hợp lệ
     */
    private int getCurrentPage(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        return page;
    }

    /**
     * Lấy từ khóa tìm kiếm từ request hoặc session và cập nhật session nếu cần.
     *
     * @param request  đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @param response đối tượng HttpServletResponse chứa thông tin phản hồi
     * @return từ khóa tìm kiếm
     */
    private String getSearchKeyword(HttpServletRequest request, HttpServletResponse response) {
        String search1 = request.getParameter("search1") == null ? "" : request.getParameter("search1");
        String findByName = SessionRepo.getSearch(request, response);
        if (findByName == null) {
            findByName = CheckInput.checkInputString(request.getParameter("search") == null ? "" : request.getParameter("search"));
            if (findByName != null) {
                SessionRepo.setSearch(request, response, findByName);
            }
        } else {
            String checkSearch = request.getParameter("search") == null ? search1 : request.getParameter("search");
            if (!findByName.equals(checkSearch)) {
                findByName = CheckInput.checkInputString(request.getParameter("search") == null ? "" : request.getParameter("search"));
                findByName = findByName == null ? "" : findByName;
                SessionRepo.setSearch(request, response, findByName);
            }
        }
        return findByName;
    }

    /**
     * Lấy thứ tự sắp xếp từ request hoặc session và cập nhật session nếu cần.
     *
     * @param request  đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @param response đối tượng HttpServletResponse chứa thông tin phản hồi
     * @return thứ tự sắp xếp ("asc" hoặc "desc")
     */
    private String getSortOrder(HttpServletRequest request, HttpServletResponse response) {
        String sort1 = request.getParameter("sort1") == null ? "asc" : request.getParameter("sort1");
        String sort = SessionRepo.getSort(request, response);
        if (sort == null) {
            sort = CheckInput.checkInputString(request.getParameter("sort")) == null
                    ? "asc"
                    : CheckInput.checkInputString(request.getParameter("sort"));
            SessionRepo.setSort(request, response, sort);
        } else {
            String checkSort = request.getParameter("sort") == null ? sort1 : request.getParameter("sort");
            if (!sort.equals(checkSort)) {
                sort = CheckInput.checkInputString(request.getParameter("sort")) == null
                        ? "asc"
                        : CheckInput.checkInputString(request.getParameter("sort"));
                SessionRepo.setSort(request, response, sort);
            }
        }
        return sort;
    }

    /**
     * Tính tổng số trang dựa trên tổng số sản phẩm.
     *
     * @param totalProducts tổng số sản phẩm
     * @return tổng số trang
     */
    private int calculateTotalPages(int totalProducts) {
        return (int) Math.ceil((double) totalProducts / LIMIT);
    }

    /**
     * Đảm bảo trang hiện tại không vượt quá tổng số trang.
     *
     * @param page       số trang hiện tại
     * @param totalPages tổng số trang
     * @return trang hợp lệ sau khi kiểm tra
     */
    private int validateCurrentPage(int page, int totalPages) {
        return page > totalPages ? totalPages : page;
    }

    /**
     * Thiết lập các thuộc tính cần thiết cho request trước khi chuyển tiếp đến JSP.
     *
     * @param request    đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @param response   đối tượng HttpServletResponse chứa thông tin phản hồi
     * @param products   danh sách sản phẩm cho trang hiện tại
     * @param page       số trang hiện tại
     * @param totalPages tổng số trang
     */
    private void setRequestAttributes(HttpServletRequest request, HttpServletResponse response,
                                      List<Product> products, int page, int totalPages) {
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("user", SessionRepo.getUser(request, response));
        request.setAttribute("productDetail", ProductDetailProcess.INSTANCE);
        request.setAttribute("category", CategoryProcess.INSTANCE);
        request.setAttribute("media", MediaProcess.INSTANCE);
        request.setAttribute("productList", new ArrayList<Product>());
    }

    /**
     * Xử lý yêu cầu POST cho trang chủ (chưa được triển khai).
     *
     * @param request  đối tượng HttpServletRequest chứa thông tin yêu cầu
     * @param response đối tượng HttpServletResponse chứa thông tin phản hồi
     * @throws ServletException nếu có lỗi về phía Servlet
     * @throws IOException      nếu có lỗi về đầu vào/đầu ra
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chưa triển khai
    }
}
