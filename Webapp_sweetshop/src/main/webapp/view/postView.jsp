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
    <title>${post.title}</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<h1>${post.title}</h1>
<p><strong>Tác Giả:</strong> ${post.userID}</p> <!-- Có thể hiển thị tên người dùng thay vì ID -->
<p><strong>Ngày Tạo:</strong> ${post.createdAt}</p>
<p><strong>Nội Dung:</strong></p>
<p>${post.content}</p>
<a href="posts">Quay lại danh sách</a>
</body>
</html>
