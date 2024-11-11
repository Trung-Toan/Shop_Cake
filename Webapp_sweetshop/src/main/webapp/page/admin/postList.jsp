<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/1/2024
  Time: 11:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>List of Posts</title>
</head>
<body>
<h1>Posts</h1>
<a href="posts?action=new">Create New Post</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Content</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="post" items="${posts}">
        <tr>
            <td>${post.id}</td>
            <td>${post.title}</td>
            <td>${post.content}</td>
            <td>
                <a href="posts?action=edit&id=${post.id}">Edit</a>
                <a href="posts?action=delete&id=${post.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
