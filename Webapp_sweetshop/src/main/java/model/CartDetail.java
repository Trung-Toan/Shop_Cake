package model;

/**
 *
 * @author hoang
 */

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CartDetail {
    private int id;
    private int quantity;
    private int status;
    private int cartID;
    private int productDetailID;
    private Product product;
    private ProductDetail productDetail;
}