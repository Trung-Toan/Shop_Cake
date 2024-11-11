<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/2/2024
  Time: 11:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Post</title>
</head>
<body>
<h1>Update Post</h1>
<form action="posts" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${post.id}">
    <label for="title">Title:</label>
    <input type="text" name="title" id="title" value="${post.title}" required><br>
    <label for="content">Content:</label>
    <textarea name="content" id="content" required>${post.content}</textarea><br>
    <input type="submit" value="Submit">
</form>
<a href="posts">Back to list</a>
</body>
</html>

