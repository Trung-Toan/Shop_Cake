package dal.product;

import dal.DAO;
import model.Product;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ProductProcess extends DAO {
    public static ProductProcess INSTANCE = new ProductProcess();

    private ProductProcess() {
    }

    /**
     * get all product from database
     *
     * @return list product
     */
    public List<Product> read() {
        String sql = "select * from `product`";
        List<Product> productList = new ArrayList<>();
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setIngredient(rs.getString("ingredient"));
                product.setDescription(rs.getString("description"));
                product.setStatus(rs.getInt("status"));
                product.setCreatedAt(rs.getDate("createdAt"));
                product.setUpdatedAt(rs.getDate("updatedAt"));
                product.setCategoryID(rs.getInt("categoryID"));
                productList.add(product);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return productList;
    }

    /**
     * Lấy tổng số sản phẩm từ bảng product theo điều kiện tìm kiếm
     */
    public int getTotalProducts(String searchName, String category) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT p.id) AS total FROM product p " +
                        "JOIN productDetail pd ON p.id = pd.productID WHERE p.status = ?");
        if (searchName != null && !searchName.isEmpty()) {
            sql.append(" AND (p.name LIKE ? OR p.id = ? OR p.description LIKE ? OR pd.price LIKE ? )");
        }
        if (category != null && !category.isEmpty() && !category.contains("all")) {
            String[] categoryArray = category.split(",");
            sql.append(" AND p.categoryID IN (");
            for (int i = 0; i < categoryArray.length; i++) {
                sql.append("?");
                if (i < categoryArray.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        try (PreparedStatement ps = this.connection.prepareStatement(sql.toString())) {
            ps.setString(1, "1");
            int paramIndex = 2;
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, searchName);
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, "%" + searchName + "%");
            }
            if (category != null && !category.isEmpty() && !category.contains("all")) {
                String[] categoryArray = category.split(",");
                for (String s : categoryArray) {
                    ps.setString(paramIndex++, s);
                }
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return 0;
    }

    /**
     * Lấy danh sách sản phẩm cho một trang cụ thể, sắp xếp theo giá trị min của giá và tìm kiếm theo tên
     */
    public List<Product> getProductsByPage(String searchName, int limit, int offset, String sortByMinPriceAsc, String category) {
        List<Product> productList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT p.*, MIN(pd.price) AS minPrice FROM product p " +
                        "JOIN productDetail pd ON p.id = pd.productID WHERE p.status = ? ");

        // Thêm điều kiện tìm kiếm theo tên
        if (searchName != null && !searchName.isEmpty()) {
            query.append(" AND (p.name LIKE ? OR p.id = ? OR p.description LIKE ? OR pd.price LIKE ?)");
        }

        // Thêm điều kiện tìm kiếm theo danh mục
        if (category != null && !category.isEmpty() && !category.contains("all")) {
            String[] categoryArray = category.split(",");
            query.append(" AND p.categoryID IN (");
            for (int i = 0; i < categoryArray.length; i++) {
                query.append("?");
                if (i < categoryArray.length - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }

        // Nhóm theo productID và sắp xếp theo giá trị min của giá
        query.append(" GROUP BY p.id ORDER BY minPrice ");
        query.append(sortByMinPriceAsc).append(" LIMIT ? OFFSET ?");

        try (PreparedStatement ps = this.connection.prepareStatement(query.toString())) {
            ps.setString(1, "1");
            int paramIndex = 2;

            // Thiết lập các tham số tìm kiếm tên
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, searchName);
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, "%" + searchName + "%");
            }

            // Thiết lập các tham số tìm kiếm danh mục
            if (category != null && !category.isEmpty() && !category.contains("all")) {
                String[] categoryArray = category.split(",");
                for (String s : categoryArray) {
                    ps.setString(paramIndex++, s);
                }
            }

            // Thiết lập tham số limit và offset
            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex, offset);

            // Thực thi truy vấn và xử lý kết quả
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setIngredient(rs.getString("ingredient"));
                    product.setDescription(rs.getString("description"));
                    product.setStatus(rs.getInt("status"));
                    product.setCreatedAt(rs.getDate("createdAt"));
                    product.setUpdatedAt(rs.getDate("updatedAt"));
                    product.setCategoryID(rs.getInt("categoryID"));
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return productList;
    }

    /**
     *
     * @param searchName
     * @return
     */
    public int getFullTotalProducts(String searchName) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT p.id) AS total " +
                        "FROM product p " +
                        "LEFT JOIN productDetail pd ON p.id = pd.productID "
        );
        // Nếu có điều kiện tìm kiếm
        if (searchName != null && !searchName.isEmpty()) {
            sql.append("WHERE p.name LIKE ? or p.id = ? or p.description like ? OR pd.price LIKE ?");
        }
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql.toString());
            // Thiết lập tham số tìm kiếm
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(1, "%" + searchName + "%");
                ps.setString(2, searchName);
                ps.setString(3, "%" + searchName + "%");
                ps.setString(4, "%" + searchName + "%");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return 0;
    }

    /**
     * get full product by page
     *
     * @param searchName
     * @param limit
     * @param offset
     * @param sortByMinPriceAsc
     * @return
     */
    public List<Product> getFullProductsByPage(String searchName, int limit, int offset, String sortByMinPriceAsc) {
        List<Product> productList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
                "SELECT p.*, COALESCE(MIN(pd.price), 0) AS minPrice " +
                        "FROM product p " +
                        "LEFT JOIN productDetail pd ON p.id = pd.productID "
        );
        // Nếu có tìm kiếm theo tên
        if (searchName != null && !searchName.isEmpty()) {
            query.append("WHERE p.name LIKE ? or p.id = ? or p.description like ? OR pd.price LIKE ? ");
        }
        // Nhóm theo productID để lấy giá trị min
        query.append("GROUP BY p.id ");
        // Thêm điều kiện sắp xếp theo giá trị min
        query.append("ORDER BY p.createdAt ");
        query.append(sortByMinPriceAsc.equalsIgnoreCase("asc") ? "ASC " : "DESC ");
        // Thêm điều kiện phân trang
        query.append("LIMIT ? OFFSET ?");
        try {
            PreparedStatement ps = this.connection.prepareStatement(query.toString());
            int paramIndex = 1;
            // Thiết lập tham số tìm kiếm tên
            if (searchName != null && !searchName.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, searchName );
                ps.setString(paramIndex++, "%" + searchName + "%");
                ps.setString(paramIndex++, "%" + searchName + "%");
            }
            // Thiết lập limit và offset
            ps.setInt(paramIndex++, limit);
            ps.setInt(paramIndex, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setIngredient(rs.getString("ingredient"));
                product.setDescription(rs.getString("description"));
                product.setStatus(rs.getInt("status"));
                product.setCreatedAt(rs.getDate("createdAt"));
                product.setUpdatedAt(rs.getDate("updatedAt"));
                product.setCategoryID(rs.getInt("categoryID"));
                productList.add(product);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }

        return productList;
    }

    /**
     * get product by id product
     *
     * @param id id product
     * @return object product or null if not found
     */
    public Product getProductById(String id) {
        String sql = "select * from `product` where id = ?";
        Product product = null;
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setId(Integer.parseInt(rs.getString("id")));
                product.setName(rs.getString("name"));
                product.setIngredient(rs.getString("ingredient"));
                product.setDescription(rs.getString("description"));
                product.setStatus(rs.getInt("status"));
                product.setCreatedAt(rs.getDate("createdAt"));
                product.setUpdatedAt(rs.getDate("updatedAt"));
                product.setCategoryID(rs.getInt("categoryID"));
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return product;
    }

    public static void main(String[] args) {
        System.out.println(ProductProcess.INSTANCE.getProductById("1"));
    }

    /**
     * update status product
     *
     * @param idUpdate id product need to update
     * @param status status need to change
     */
    public void updateStatusProduct(String idUpdate, String status) {
        String sql = "update `product` set status = ? where id = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(idUpdate));
            ps.executeUpdate();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    /**
     * get product by name product
     *
     * @param productName name product
     * @return product found else null
     */
    public Product getProductByName(String productName) {
        String sql = "select * from `product` where name = ?";
        Product product = null;
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setIngredient(rs.getString("ingredient"));
                product.setDescription(rs.getString("description"));
                product.setStatus(rs.getInt("status"));
                product.setCreatedAt(rs.getDate("createdAt"));
                product.setUpdatedAt(rs.getDate("updatedAt"));
                product.setCategoryID(rs.getInt("categoryID"));
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return product;
    }

    /**
     * create new product
     *
     * @param productName name product
     * @param productIngredient ingredient product
     * @param productDescription description product
     * @param productStatus status product
     * @param productCategory id category
     * @return id product if create is success else null
     */
    public String create(String productName, String productIngredient, String productDescription, String productStatus, String productCategory) {
        String id = null;
        String sql = "{CALL insertProduct(?, ?, ?, ?, ?)}";
        try {
            CallableStatement cs = this.connection.prepareCall(sql);
            cs.setString(1, productName);
            cs.setString(2, productIngredient);
            cs.setString(3, productDescription);
            cs.setString(4, productStatus);
            cs.setString(5, productCategory);
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    id = rs.getString("newProductID");
                }
                rs.close();
            }
            cs.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return id;
    }

    public void update(String pid, String productNameUpdate, String productIngredientUpdate, String productDescriptionUpdate, String productStatusUpdate, String productCategoryUpdate) {
        String sql = "{CALL updateProduct(?, ?, ?, ?, ?, ?)}";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, pid);
            ps.setString(2, productNameUpdate);
            ps.setString(3, productIngredientUpdate);
            ps.setString(4, productDescriptionUpdate);
            ps.setString(5, productStatusUpdate);
            ps.setString(6, productCategoryUpdate);
            ps.executeUpdate();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }
}
