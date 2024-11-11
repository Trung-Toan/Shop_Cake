<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/15/2024
  Time: 2:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>List product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link class="js-stylesheet" href="../../assets/css/light.css" rel="stylesheet">

    <style>
        #sidebar {
            height: 100% !important;
        }
        .block-filter-sort .filter-sort__list-filter .btn-filter {
            align-items: center;
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            color: #444;
            cursor: pointer;
            display: flex;
            font-size: 12px;
            height: 34px;
            margin: 0 10px 10px 0;
            padding: 5px 10px;
            white-space: nowrap;
        }
    </style>

</head>
<body style="display: flex; flex-direction: column">

<%--<jsp:include page="header.jsp"/>--%>

<div class="flex: 1; row">
    <div class="col-md-3">
        <jsp:include page="../common/sidebar.jsp"/>
    </div>
    <div class="col-md-9">
        <jsp:include page="../common/navbar.jsp"/>
        <%
            String mess = request.getParameter("mess");
            String type = request.getParameter("type");
        %>

        <div class="row mt-3">
            <div class="col-md-9"></div>
            <%
                if (mess != null && !mess.equals("")) {
            %>
            <div class="col-md-3 alert alert-<%= "success".equals(type) ? "success" : "danger" %> alert-dismissible order-md-last">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <strong><%= "success".equals(type) ? "Success" : "Error" %>!</strong> <%= mess %>
            </div>
            <%
                }
            %>
        </div>


        <div class="d-flex justify-content-center mt-3">
            <a href="./add_new_product" class="btn btn-success d-flex justify-content-center align-items-center">
                New Product
            </a>
        </div>
        <c:choose>
            <c:when test="${not empty products}">
                <main class="container">
                    <c:set var="search" value="${sessionScope.search}"/>
                    <c:set var="sort" value="${sessionScope.sort}"/>
                    <div class="d-flex justify-content-between">
                        <div>
                            <form action="view_list_product" method="get" class="d-flex">
                                <input class="form-control me-2" name="search" value="${search}" type="search" placeholder="Search"
                                       aria-label="Search" onchange="this.form.submit()">
                                <button class="btn btn-outline-secondary" type="submit">Search</button>
                                <input type="hidden" value="${sort}" name="sort1">
                            </form>
                        </div>
                        <div class="filter-sort__list-filter d-flex">
                            <a class="btn d-flex justify-content-center align-items-center ${sort.equalsIgnoreCase("DESC") ? "bg-warning " : ""}"
                               href="./view_list_product?sort=DESC&search1=${search}" style="background-color: #f0efef; padding-top: 0; padding-bottom: 0">
                                <div class="icon d-flex justify-content-center align-items-center">
                                    <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                        <path
                                                d="M416 288h-95.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H416c17.67 0 32-14.33 32-32S433.7 288 416 288zM544 32h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 32 544 32zM352 416h-32c-17.67 0-32 14.33-32 32s14.33 32 32 32h32c17.67 0 31.1-14.33 31.1-32S369.7 416 352 416zM480 160h-159.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H480c17.67 0 32-14.33 32-32S497.7 160 480 160zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z">
                                        </path>
                                    </svg>
                                </div>
                                &nbsp;Date add new - old
                            </a>
                            <a class="btn d-flex justify-content-center align-items-center ${sort.equalsIgnoreCase("ASC") ? "bg-warning " : ""}"
                               href="./view_list_product?sort=ASC&search1=${search}"
                               style="background-color: #f0efef; margin-right: 10px;padding-top: 0; padding-bottom: 0">
                                <div class="icon d-flex justify-content-center align-items-center">
                                    <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                        <path
                                                d="M320 224H416c17.67 0 32-14.33 32-32s-14.33-32-32-32h-95.1c-17.67 0-32 14.33-32 32S302.3 224 320 224zM320 352H480c17.67 0 32-14.33 32-32s-14.33-32-32-32h-159.1c-17.67 0-32 14.33-32 32S302.3 352 320 352zM320 96h32c17.67 0 31.1-14.33 31.1-32s-14.33-32-31.1-32h-32c-17.67 0-32 14.33-32 32S302.3 96 320 96zM544 416h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 416 544 416zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z">
                                        </path>
                                    </svg>
                                </div>
                                &nbsp;Date add old-new
                            </a>
                        </div>
                    </div>


                    <div class="row bg-light p-2 mb-2 border-bottom">
                        <span class="col-md-1 text-center"><b>No</b></span>
                        <span class="col-md-2 text-center"><b>Image</b></span>
                        <span class="col-md-2 text-center"><b>Name</b></span>
                        <span class="col-md-2 text-center"><b>Price</b></span>
                        <span class="col-md-2 text-center"><b>Category</b></span>
                        <span class="col-md-1 text-center"><b>Status</b></span>
                        <span class="col-md-2 text-center"><b>Action</b></span>
                    </div>
                    <div class="row">
                        <c:set var="i" value="${(currentPage - 1) * limit + 1}"/>
                        <c:forEach var="product" items="${products}">
                            <div class="row align-items-center mb-2 p-2 border rounded bg-white"
                                 onclick="window.location.href='./update_product?id=${product.id}'"
                                 style="cursor: pointer;">
                                <span class="col-md-1 text-center">${i}</span>
                                <span class="col-md-2 text-center">
                                    <img src="data:image/png;base64,${media.getTop1MediaByProductID(product.id).image}"
                                         alt="${product.name}" class="img-fluid" style="width: 100%; object-fit: contain;"/>
                                </span>
                                <span class="col-md-2 text-center">${product.name}</span>
                                <span class="col-md-2 text-center">
                                    ${productDetail.getMinPriceByProductId(product.id)}vnd -
                                    ${productDetail.getMaxPriceByProductId(product.id)}vnd
                                </span>
                                <span class="col-md-2 text-center">
                                        ${category.getCategoryByID(product.categoryID).getName()}
                                </span>
                                <span class="col-md-1 text-center">
                                    <c:choose>
                                        <c:when test="${product.status == 1}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Disable</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="col-md-2 text-center">
                                    <a href="./view_list_product?id=${product.id}&action=update&status=${product.status == 1 ? "0" : "1"}"
                                       class="btn btn-outline-${ product.status == 1 ? "danger" : "success"} btn-sm">
                                            ${product.status == 1 ? "Diable" : "Active"}
                                    </a>
                                </span>
                            </div>
                            <c:set var="i" value="${i + 1}"/>
                        </c:forEach>
                    </div>
                </main>
            </c:when>
        </c:choose>

        <div class="pagination d-flex justify-content-center">
            <!-- Tính startPage và endPage -->
            <c:set var="startPage" value="${currentPage - 2}"/>
            <c:set var="endPage" value="${currentPage + 2}"/>

            <!-- Điều chỉnh startPage và endPage để không vượt quá giới hạn -->
            <c:if test="${startPage < 1}">
                <c:set var="endPage" value="${endPage + (1 - startPage)}"/>
                <c:set var="startPage" value="1"/>
            </c:if>
            <c:if test="${endPage > totalPages}">
                <c:set var="startPage" value="${startPage - (endPage - totalPages)}"/>
                <c:set var="endPage" value="${totalPages}"/>
            </c:if>
            <c:if test="${startPage < 1}">
                <c:set var="startPage" value="1"/>
            </c:if>

            <!-- Nút "Trước" -->
            <c:if test="${currentPage > 1}">
                <a href="view_list_product?page=${currentPage - 1}&sort1=${sort}&search1=${search}">&laquo; Trước</a>
            </c:if>

            <!-- Hiển thị "1 ..." nếu startPage > 1 -->
            <c:if test="${startPage > 1}">
                <a href="view_list_product?page=1&sort1=${sort}&search1=${search}">1</a>
                <span>...</span>
            </c:if>

            <!-- Các số trang từ startPage đến endPage -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="view_list_product?page=${i}&sort1=${sort}&search1=${search}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- Hiển thị "... totalPages" nếu endPage < totalPages -->
            <c:if test="${endPage < totalPages}">
                <span>...</span>
                <a href="view_list_product?page=${totalPages}&sort1=${sort}&search1=${search}">${totalPages}</a>
            </c:if>

            <!-- Nút "Sau" -->
            <c:if test="${currentPage < totalPages}">
                <a href="view_list_product?page=${currentPage + 1}&sort1=${sort}&search1=${search}">Sau &raquo;</a>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page=""/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
!-- Feather Icons -->
<script src="https://unpkg.com/feather-icons"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Feather Icons
    feather.replace();
</script>
<script src="../../assets/js/user/sidebar.js"></script>
</body>
</html>
</body>
</html>
