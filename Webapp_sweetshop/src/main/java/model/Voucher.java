package model;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Voucher {
    private String code;
    private int value;
    private int quantity;
    private int remaining;
    private int status;
    private Date createdAt;
    private Date updatedAt;
}
