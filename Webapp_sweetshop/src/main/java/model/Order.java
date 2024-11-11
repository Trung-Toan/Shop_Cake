package model;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Order {
    private int id;
    private String consignee;
    private String phone;
    private String email;
    private String shipAddress;
    private Date orderTime;
    private Date deliveryTime;
    private Date receiptTime;
    private int status;
    private String voucherCode;
    private int userId;
}
