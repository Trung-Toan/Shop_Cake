package model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetail {
    private int id;
    private float price;
    private int quantity;
    private int orderID;
    private int productDetailID;

    @Override
    public String toString() {
        return "{" +
                "id:" + id +
                ", price:" + price +
                ", quantity:" + quantity +
                ", orderID:" + orderID +
                ", productDetailID:" + productDetailID
                + "}";
    }

}
