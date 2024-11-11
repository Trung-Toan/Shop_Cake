package model;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Media {
    private int id;
    private String image;
    private int postID;
    private int productID;
}
