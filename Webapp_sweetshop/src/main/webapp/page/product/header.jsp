<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/style.css">

</head>

<body>

<header>
    <div class="first-header d-flex justify-content-between align-items-center"
         style="background-color: rgb(247, 247, 247);">
        <p class="site-name">
            <a href="/home"><img src="../assets/image/home/logo.png" alt=""/></a>
        </p>
        <div class="d-flex align-items-center">
            <div class="login-or-logout d-flex justify-content-center align-items-center p-3">
                <a class="text-decoration-none" style="margin-right: 16px;" href="#"><i class="fa fa-user"></i> Account</a>
                <a class="text-decoration-none" style="margin-right: 16px;" href="#"><i class="fa fa-star"></i> Wishlist</a>
                <a class="text-decoration-none" style="margin-right: 16px;" href="/cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a>
                <c:choose>
                    <c:when test="${not empty sessionScope and not empty sessionScope.user}">
                        <a class="text-decoration-none" style="margin-right: 16px;" href="/logout">
                            <i class="fa fa-sign-out-alt"></i> Logout
                        </a>
                    </c:when>

                    <c:otherwise>
                        <a class="text-decoration-none" style="margin-right: 16px;" href="/login">
                            <i class="fa fa-sign-in-alt"></i> Login
                        </a>
                        <a class="text-decoration-none" style="margin-right: 16px;" href="/login?action=register">
                            <i class="fa fa-user-plus"></i> Register
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding: 0px 50px;">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="./home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item"></li>
                    <a class="nav-link" href="#">Shop</a>
                    </li>
                    <li class="nav-item"></li>
                    <a class="nav-link" href="#">Blog</a>
                    </li>
                    <li class="nav-item"></li>
                    <a class="nav-link" href="#">Contact</a>
                    </li>
                </ul>
                <c:set var="search" value="${sessionScope.search}" />
                <c:set var="sort" value="${sessionScope.sort}" />
                <form action="view_list_product" method="get" class="d-flex">
                    <input class="form-control me-2" name="search" value="${search}" type="search" placeholder="Search"
                           aria-label="Search">
                    <button class="btn btn-outline-secondary" type="submit">Search</button>
                    <input type="hidden" value="${sort}" name="sort1">
                </form>

                <div class="left-side col-4 me-3">
                    <div class="input-group input-group-navbar">
                        <input type="text" name="search" class="form-control" placeholder="Search…" aria-label="Search"
                               value="${search != null ? search : ''}">
                        <button class="btn" type="submit">
                            <i class="align-middle" data-feather="search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>


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