<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/4/2024
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <c:set var="search" value="${sessionScope.search}"/>
    <c:set var="sort" value="${sessionScope.sort}"/>

    <div class="bg-warning rounded-3 shadow-sm mb-4 p-3">
        <div>
            <h5 class="text-black mb-3 text-center">Search by category</h5>
            <form action="home" method="get" class="row g-3" id="categoryForm">
                <!-- Category checkboxes with Bootstrap styling -->
                <div class="col-12 ">
                    <h6 class="fw-bold">Category</h6>
                    <div>
                        <c:set var="all" value="" />
                        <c:forEach items="${category.read()}" var="cate">
                            <c:if test="${not empty all}">
                                <c:set var="all" value="${all},${cate.id}" />
                            </c:if>
                            <c:if test="${empty all}">
                                <c:set var="all" value="${cate.id}" />
                            </c:if>
                        </c:forEach>

                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" name="category" value="all" id="all" ${list.contains("all") ? "checked" : ""} onchange="document.getElementById('categoryForm').submit();"/>
                            <label for="all" class="form-check-label">All category</label>
                        </div>
                        <c:forEach items="${category.read()}" var="cate">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="category" value="${cate.id}" id="${cate.id}"
                                    ${(!list.contains("all") && list.contains(String.valueOf(cate.id))) ? "checked" : ""}
                                       onchange="document.getElementById('categoryForm').submit();"/>
                                <label for="${cate.id}" class="form-check-label">${cate.name}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- Hidden fields for sorting and searching -->
                <input type="hidden" value="${sort}" name="sort1">
                <input type="hidden" value="${search}" name="search1">
            </form>

        </div>
    </div>


</body>
</html>
