<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Image Base64 Result</title>
</head>
<body>
<h2>Base64 Encoded Images</h2>

<!-- Hiển thị danh sách các chuỗi Base64 của ảnh -->
<c:forEach var="base64Image" items="${fn:split(base64Images, ';')}">
    <!-- Chỉ hiển thị nếu base64Image không trống -->
    <c:if test="${not empty base64Image}">
        <textarea rows="10" cols="100">${base64Image}</textarea>
        <br><br>
        <!-- Hiển thị ảnh dưới dạng Base64 -->
        <img src="data:image/png;base64,${base64Image}" alt="Uploaded Image">
        <br><br>
    </c:if>
</c:forEach>

<a href="/uploadImage">Upload More Images</a>
</body>
</html>
