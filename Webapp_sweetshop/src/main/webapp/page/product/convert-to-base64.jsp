<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/20/2024
  Time: 10:58 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Upload an Image</h2>
<form action="uploadImage" method="post" enctype="multipart/form-data">
    <label for="imageFile">Choose an image:</label>
    <input type="file" name="imageFile" id="imageFile" accept="image/*" multiple required>
    <input type="submit" value="Upload Image">
</form>

<!-- Hiển thị thông báo lỗi (nếu có) -->
<c:if test="${not empty message}">
    <p style="color:red;">${message}</p>
</c:if>
</body>
</html>

