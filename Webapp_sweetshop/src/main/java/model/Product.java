package model;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Product {
    private int id;
    private String name;
    private String ingredient;
    private String description;
    private int status;
    private Date createdAt;
    private Date updatedAt;
    private int categoryID;
}
