package model;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Category {
    private int id;
    private String name;
    private int status;
    private Date createdAt;
    private Date updatedAt;
}
