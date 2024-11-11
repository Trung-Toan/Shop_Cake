package dal.orderDetail;

import dal.DAO;
import model.OrderDetail;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailProcess extends DAO {
    public static OrderDetailProcess INSTANCE = new OrderDetailProcess();

    private OrderDetailProcess() {}

    /**
     * create new order detail
     *
     * @param orderDetail object orderDetail
     * @return id after insert and null if not success
     */
    public String create(OrderDetail orderDetail) {
        String id = null;
        String sql = "{Call insertOrderDetail(?,?,?,?,?)}";
        try {
            CallableStatement cs = this.connection.prepareCall(sql);
            cs.setFloat(1, orderDetail.getPrice());
            cs.setInt(2, orderDetail.getQuantity());
            cs.setInt(3, orderDetail.getOrderID());
            cs.setInt(4, orderDetail.getProductDetailID());
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    id = rs.getString("newOrderDetailID");
                }
                rs.close();
            }
            cs.close();

        } catch (SQLException e) {
            status = e.getMessage();
        }
        return id;
    }

    public String createReturnID(float totalPrice, String quantity, String idOrder, String idPd) {
        String id = null;
        String sql = "{Call insertOrderDetail(?,?,?,?)}";
        try {
            CallableStatement cs = this.connection.prepareCall(sql);
            cs.setFloat(1, totalPrice);
            cs.setInt(2, Integer.parseInt(quantity));
            cs.setInt(3, Integer.parseInt(idOrder));
            cs.setInt(4, Integer.parseInt(idPd));
            cs.executeQuery();
            ResultSet rs = cs.getResultSet();
            if (rs.next()) {
                id = rs.getString("newOrderDetailID");
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return id;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM orderDetail WHERE orderID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setId(rs.getInt("id"));
                    orderDetail.setPrice(rs.getFloat("price"));
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setOrderID(rs.getInt("orderID"));
                    orderDetail.setProductDetailID(rs.getInt("productDetailID"));
                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }


    public static void main(String[] args) {
        System.out.println(OrderDetailProcess.INSTANCE.createReturnID(12.2f, "1", "12", "4"));
    }
}
