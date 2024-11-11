<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../assets/css/style.css">
    <style>
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
<body>

<jsp:include page="header.jsp"/>
<div class="row">
    <div class="col-2 ">
        <jsp:include page="category.jsp"/>
    </div>
    <div class="col">
        <c:choose>
            <c:when test="${not empty products}">
                <main class="container">
                    <h5 style="padding-bottom: 0; margin-bottom: 0">
                        <b>Sort by</b>
                    </h5>
                    <div class="filter-sort__list-filter d-flex p-2">
                        <c:set var="search" value="${sessionScope.search}"/>
                        <c:set var="sort" value="${sessionScope.sort}"/>
                        <a class="btn d-flex ${sort.equalsIgnoreCase("ASC") ? "bg-warning " : ""}"
                           href="./home?sort=ASC&search1=${search}"
                           style="background-color: #f0efef; margin-right: 10px;">
                            <div class="icon d-flex justify-content-center align-items-center">
                                <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                    <path
                                            d="M320 224H416c17.67 0 32-14.33 32-32s-14.33-32-32-32h-95.1c-17.67 0-32 14.33-32 32S302.3 224 320 224zM320 352H480c17.67 0 32-14.33 32-32s-14.33-32-32-32h-159.1c-17.67 0-32 14.33-32 32S302.3 352 320 352zM320 96h32c17.67 0 31.1-14.33 31.1-32s-14.33-32-31.1-32h-32c-17.67 0-32 14.33-32 32S302.3 96 320 96zM544 416h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 416 544 416zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z">
                                    </path>
                                </svg>
                            </div>
                            &nbsp;Price low - height
                        </a>
                        <a class="btn d-flex ${sort.equalsIgnoreCase("DESC") ? "bg-warning " : ""}"
                           href="./home?sort=DESC&search1=${search}" style="background-color: #f0efef;">
                            <div class="icon d-flex justify-content-center align-items-center">
                                <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                    <path
                                            d="M416 288h-95.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H416c17.67 0 32-14.33 32-32S433.7 288 416 288zM544 32h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 32 544 32zM352 416h-32c-17.67 0-32 14.33-32 32s14.33 32 32 32h32c17.67 0 31.1-14.33 31.1-32S369.7 416 352 416zM480 160h-159.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H480c17.67 0 32-14.33 32-32S497.7 160 480 160zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z">
                                    </path>
                                </svg>
                            </div>
                            &nbsp;Price height - low
                        </a>
                    </div>
                    <div class="row">
                        <c:forEach var="product" items="${products}">
                            <div class="col-sm-6 col-xs-12 col-md-6 col-lg-3 p-2">
                                <div class="card p-1">
                                    <img src="data:image/png;base64,${media.getTop1MediaByProductID(product.id).image}"
                                         class="card-img-top" alt="..."
                                         style="height: 250px; object-fit: contain;"/>
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                    </div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span class="text-start"><b>Price:</b></span>
                                            <span class="text-end">${productDetail.getMinPriceByProductId(product.id)}vnd - ${productDetail.getMaxPriceByProductId(product.id)}vnd</span>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between">
                                            <span class="text-start"><b>Category:</b></span>
                                            <span class="text-end">${category.getCategoryByID(product.categoryID).getName()}</span>
                                        </li>
                                    </ul>

                                    <div class="card-body d-flex justify-content-center">
                                        <a href="./viewdetail?id=${product.id}" class="btn btn-outline-warning ">View
                                            detail</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </main>
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
                        <a href="home?page=${currentPage - 1}&sort1=${sort}&search1=${search}">&laquo; Trước</a>
                    </c:if>

                    <!-- Hiển thị "1 ..." nếu startPage > 1 -->
                    <c:if test="${startPage > 1}">
                        <a href="home?page=1&sort1=${sort}&search1=${search}">1</a>
                        <span>...</span>
                    </c:if>

                    <!-- Các số trang từ startPage đến endPage -->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="home?page=${i}&sort1=${sort}&search1=${search}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- Hiển thị "... totalPages" nếu endPage < totalPages -->
                    <c:if test="${endPage < totalPages}">
                        <span>...</span>
                        <a href="home?page=${totalPages}&sort1=${sort}&search1=${search}">${totalPages}</a>
                    </c:if>

                    <!-- Nút "Sau" -->
                    <c:if test="${currentPage < totalPages}">
                        <a href="home?page=${currentPage + 1}&sort1=${sort}&search1=${search}">Sau &raquo;</a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container text-center mt-5">
                    <div class="alert alert-warning" role="alert">
                        <h4 class="alert-heading">No products found</h4>
                        <p>It looks like there are no items matching your criteria. Try adjusting your search or filter options.</p>
                        <hr>
                        <a href="./home" class="btn btn-primary mt-3">Back to Home</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
</body>
</html>