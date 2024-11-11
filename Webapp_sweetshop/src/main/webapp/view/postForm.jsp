<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/1/2024
  Time: 11:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${not empty post}">Chỉnh Sửa Bài Đăng</c:when><c:otherwise>Tạo Bài Đăng Mới</c:otherwise></c:choose></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1><c:choose><c:when test="${not empty post}">Chỉnh Sửa Bài Đăng</c:when><c:otherwise>Tạo Bài Đăng Mới</c:otherwise></c:choose></h1>
<form action="posts?action=<c:choose><c:when test="${not empty post}">update</c:when><c:otherwise>insert</c:otherwise></c:choose>" method="post">
    <c:if test="${not empty post}">
        <input type="hidden" name="id" value="${post.id}">
    </c:if>
    <label for="title">Tiêu Đề:</label><br>
    <input type="text" id="title" name="title" value="${post.title}" required><br><br>

    <label for="content">Nội Dung:</label><br>
    <textarea id="content" name="content" rows="10" cols="50" required>${post.content}</textarea><br><br>

    <label for="status">Trạng Thái:</label><br>
    <select id="status" name="status">
        <option value="1" <c:if test="${post.status == 1}">selected</c:if>>Công khai</option>
        <option value="0" <c:if test="${post.status == 0}">selected</c:if>>Nháp</option>
    </select><br><br>

    <!-- Giả sử bạn lấy userID từ session hoặc chọn từ dropdown -->
    <label for="userID">Tác Giả:</label><br>
    <input type="number" id="userID" name="userID" value="${post.userID}" required><br><br>

    <input type="submit" value="Lưu">
    <a href="posts">Hủy</a>
</form>
</body>
</html>

