package dal.productDetail;

import dal.DAO;
import model.ProductDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDetailProcess extends DAO {
    public static ProductDetailProcess INSTANCE = new ProductDetailProcess();

    private ProductDetailProcess() {};

    /**
     * get max value of price of a product
     *
     * @param productId id product
     * @return max value of price
     */
    public float getMaxPriceByProductId(String productId) {
        float maxPrice = 0;
        String sql = "SELECT MAX(price) FROM `productDetail` WHERE productID = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                maxPrice = rs.getFloat(1);
            }
        }catch (SQLException e) {
            status = e.getMessage();
        }
        return maxPrice;
    }

    /**
     * get min value of price of a product
     *
     * @param productId id product
     * @return min value of price
     */
    public float getMinPriceByProductId(String productId) {
        float minPrice = 0;
        String sql = "SELECT MIN(price) FROM `productDetail` WHERE productID = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                minPrice = rs.getFloat(1);
            }
        }catch (SQLException e) {
            status = e.getMessage();
        }
        return minPrice;
    }

    public static void main(String[] args) {
    }

    /**
     * get all product detail by id product
     *
     * @param idProduct id product
     * @return list product detail
     */
    public List<ProductDetail> getProductDetailByProductID(String idProduct) {
        List<ProductDetail> productDetailList = new ArrayList<>();
        String sql = "SELECT * FROM `productDetail` WHERE productID = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            ps.setString(1, idProduct);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDetail productDetail = new ProductDetail();
                productDetail.setId(rs.getInt("id"));
                productDetail.setSize(rs.getString("size"));
                productDetail.setPrice(rs.getFloat("price"));
                productDetail.setProductID(rs.getInt("productID"));
                productDetailList.add(productDetail);
            }
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
        return productDetailList;
    }

    /**
     * get list product detail by list id product
     *
     * @param listId List id product
     * @return list ProductDetail
     */
    public List<ProductDetail> getPDByListPDId(String[] listId) {
        List<ProductDetail> productDetailList = new ArrayList<>();
        for (String id : listId) {
           String sql = "SELECT * FROM `productDetail` WHERE id = ?";
            try {
                PreparedStatement ps = this.connection.prepareStatement(sql);
                ps.setString(1, id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    ProductDetail productDetail = new ProductDetail();
                    productDetail.setId(rs.getInt("id"));
                    productDetail.setSize(rs.getString("size"));
                    productDetail.setPrice(rs.getFloat("price"));
                    productDetail.setProductID(rs.getInt("productID"));
                    productDetailList.add(productDetail);
                }
            } catch (SQLException e) {
                this.status = e.getMessage();
            }
        }
        return productDetailList;
    }

    /**
     * insert new productDetail
     *
     * @param productPrice list price
     * @param productSize list size
     * @param productID id product
     */
    public void create(String[] productPrice, String[] productSize, String productID) {
        String sql = "INSERT INTO productDetail (price, size, productID) VALUES (?, ?, ?) ; ";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            for (int i = 0; i < productPrice.length; i++) {
                ps.setString(1, productPrice[i]);
                ps.setString(2, productSize[i]);
                ps.setString(3, productID);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    public void remove(String productDetailDelete) {
        String sql = "DELETE FROM `productDetail` WHERE id = ?";
        String[] productPrice = productDetailDelete.split("\\|");
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            for (String id : productPrice) {
                ps.setString(1, id);
                ps.addBatch();
            }
            ps.executeBatch();
            ps.close();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }

    public void update(String[] productPriceUpdate, String[] productSizeUpdate, String pdIdUpdate) {
        String[] pdID = pdIdUpdate.split("\\|");
        String sql = "update productDetail set price = ?, size = ? where id = ?";
        try {
            PreparedStatement ps = this.connection.prepareStatement(sql);
            for (int i = 0; i < productPriceUpdate.length; i++) {
                ps.setString(1, productPriceUpdate[i]);
                ps.setString(2, productSizeUpdate[i]);
                ps.setString(3, pdID[i]);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            this.status = e.getMessage();
        }
    }
}
