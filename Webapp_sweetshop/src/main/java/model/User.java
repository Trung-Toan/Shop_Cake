package model;
import lombok.*;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private boolean gender;
    private String email;
    private String phone;
    private Date dob;
    private String avatar;
    private String address;
    private int status;
    private Date createdAt;
    private Date updatedAt;
    private int role;

}
