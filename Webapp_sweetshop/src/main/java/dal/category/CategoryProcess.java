package dal.category;

import dal.DAO;
import model.Category;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryProcess extends DAO {
    public static CategoryProcess INSTANCE = new CategoryProcess();

    private CategoryProcess() {}

    /**
     * get category by id category
     *
     * @param id id category
     * @return a category find else null
     */
    public Category getCategoryByID(String id) {
        Category category = null;
        String sql = "SELECT * FROM `category` WHERE id = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getInt("status"));
            }
        }catch (SQLException e) {
            status = e.getMessage();
        }
        return category;
    }

    public static void main(String[] args) {
        for(Category c : CategoryProcess.INSTANCE.getCatagoryActive()) {
            System.out.println(c.toString());
        }
    }

    /**
     * get all category from database
     *
     * @return list category
     */
    public List<Category> read() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM `category`";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getInt("status"));
                categoryList.add(category);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return categoryList;
    }

    /**
     * get all category with status = 1
     *
     * @return list category with status is 1
     */
    public List<Category> getCatagoryActive() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM `category` where status = '1'";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getInt("status"));
                categoryList.add(category);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return categoryList;
    }
}
