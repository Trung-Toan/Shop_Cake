/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package until;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * find string unique
 *
 * @author trantoan
 */
public class Unique {

    /**
     * find all String unique
     *
     * @param strings list of String need to find
     * @return return an list unique in list strings
     */
    
    public static List<String> uniqueStrings(List<String> strings) {
        // Tạo một HashSet để lưu trữ các chuỗi duy nhất
        Set<String> uniqueSet = new HashSet<>(strings);
        
        return new ArrayList<>(uniqueSet);
    }

    /**
     * find all String unique and change this to lower case
     *
     * @param strings list of String need to find
     * @return return an list unique in list strings at face is lower case
     */
    public static List<String> uniqueStringsIgnoreCase(List<String> strings) {
        // Tạo một HashSet để lưu trữ các chuỗi duy nhất (không phân biệt chữ hoa thường)
        Set<String> uniqueSet = new HashSet<>();
        // Chuyển đổi tất cả các chuỗi sang chữ thường trước khi thêm vào HashSet
        for (String str : strings) {
            uniqueSet.add(str.toLowerCase());
        }
        // Chuyển từ Set sang List bằng cách truyền uniqueSet vào constructor của ArrayList
        return new ArrayList<>(uniqueSet);
    }
    
     public static void main(String[] args) {
        List<String> strings = Arrays.asList("Apple", "Banana", "apple", "banana", "Orange", "orange");
        List<String> uniqueList = uniqueStringsIgnoreCase(strings);
        System.out.println("Unique strings (case insensitive): " + uniqueList);
    }
}
