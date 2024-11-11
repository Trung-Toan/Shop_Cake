package model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetail {
    private int id;
    private float price;
    private String size;
    private int productID;

    @Override
    public String toString() {
        return "{" +
                "id:" + id +
                ", price:" + price +
                ", size:" + size +
                ", productID:" + productID
                + "}";
    }
}
