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
    <title>Create New Post</title>
</head>
<body>
<h1>Create Post</h1>
<form action="posts" method="post">
    <input type="hidden" name="action" value="create">
    <label for="title">Title:</label>
    <input type="text" name="title" id="title" required><br>
    <label for="content">Content:</label>
    <textarea name="content" id="content" required></textarea><br>
    <input type="submit" value="Submit">
</form>
<a href="posts">Back to list</a>
</body>
</html>

