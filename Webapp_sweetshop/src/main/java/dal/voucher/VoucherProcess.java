package dal.voucher;

import dal.DAO;
import model.Voucher;

import java.lang.reflect.Type;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherProcess extends DAO {
    public static VoucherProcess INSTANCE = new VoucherProcess();

    private VoucherProcess() {}

    public List<Voucher> read() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "select * from shopcake.voucher where `status` = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "1");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setCode(rs.getString("code"));
                voucher.setValue(rs.getInt("value"));
                voucher.setQuantity(rs.getInt("quantity"));
                voucher.setRemaining(rs.getInt("remaining"));
                voucher.setStatus(rs.getInt("status"));
                voucher.setCreatedAt(rs.getDate("createdAt"));
                voucher.setUpdatedAt(rs.getDate("updatedAt"));
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            status = e.getMessage();
        }
        return vouchers;
    }

    /**
     * use voucher
     *
     * @param code code voucher
     * @return 0 if voucher not exist or remaining is 0 or status is 0 else return 1
     */
    public String useVoucher (String code) {
        String exist;
        String sql = "{CALL use_voucher(?, ?)}";
        try {
            CallableStatement ps = connection.prepareCall(sql);
            ps.setString(1, code);
            ps.registerOutParameter(2, Types.INTEGER);
            ps.execute();
            exist = ps.getString(2);
        } catch (SQLException e) {
            status = e.getMessage();
            exist = "0";
        }
        return exist;
    }

    public static void main(String[] args) {
        String exist = VoucherProcess.INSTANCE.useVoucher("123asd");
        System.out.println(exist);
    }
}
