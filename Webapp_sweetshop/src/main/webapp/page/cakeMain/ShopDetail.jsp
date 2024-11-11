<%-- Created by IntelliJ IDEA. User: Hưng Date: 9/14/2024 Time: 2:06 PM --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Cake Template">
    <meta name="keywords" content="Cake, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cake | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/flaticon.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/barfiller.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="../../assets/css/style.css" type="text/css">

    <!-- Custom Style -->
    <style>
        * {
            box-sizing: border-box;
        }

        .container {
            position: relative;
        }

        .mySlides {
            display: none;
        }

        .cursor {
            cursor: pointer;
        }

        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 40%;
            padding: 16px;
            color: white;
            font-weight: bold;
            font-size: 20px;
            user-select: none;
        }

        .next {
            right: 0;
        }

        .prev:hover, .next:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }

        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        .thumbnail-row {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
        }

        .column {
            flex: 0 0 auto;
            width: 16.66%;
        }

        .demo {
            opacity: 0.6;
        }

        .active, .demo:hover {
            opacity: 1;
        }
    </style>

    <script>
        let slideIndex = 1;
        window.onload = function () {
            currentSlide(1); // Hiển thị ảnh đầu tiên khi tải trang
        };

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let dots = document.getElementsByClassName("demo");
            let captionText = document.getElementById("caption");
            if (n > slides.length) {
                slideIndex = 1;
            }
            if (n < 1) {
                slideIndex = slides.length;
            }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " active";
            if (captionText) {
                captionText.innerHTML = dots[slideIndex - 1].alt;
            }
        }

        // Cập nhật size và giá sản phẩm khi nhấn vào button size
        function changeSize(price, size, id) {
            document.getElementById("price").innerHTML = price + " vnd";
            document.getElementById("selectId").value = id;
            document.getElementById("selectSize").value = size;
            document.getElementById("selectPrice").value = price;

            // Xử lý active button
            const buttons = document.querySelectorAll("button[name='btnSize']");
            buttons.forEach(btn => {
                btn.classList.remove('btn-info');
                btn.classList.add('btn-outline-info');
            });
            document.querySelector("button[value='" + id + "," + price + "," + size + "']")
                .classList.remove('btn-outline-info');
            document.querySelector("button[value='" + id + "," + price + "," + size + "']")
                .classList.add('btn-info');
        }

        // Xử lý khi trang được tải
        document.addEventListener("DOMContentLoaded", function () {
            const firstButton = document.querySelector("button[name='btnSize']");
            if (firstButton) {
                const value = firstButton.value.split(",");
                changeSize(value[1], value[2], value[0]);
            }
        });
    </script>

</head>
<body>

<!-- Header -->
<header class="header">
    <!-- Nội dung header ở đây -->
</header>

<!-- Breadcrumb -->
<div class="breadcrumb-option">
    <div class="container">
        <!-- Nội dung breadcrumb ở đây -->
    </div>
</div>

<!-- Shop Details Section -->
<section class="product-details spad">
    <div class="container">
        <div class="row">
            <!-- Image gallery -->
            <div class="col-lg-6">
                <div class="container">
                    <c:forEach items="${mediaList}" var="img">
                        <div class="mySlides">
                            <img src="assets/image/product/${img.image}" style="width:100%">
                        </div>
                    </c:forEach>
                    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                    <a class="next" onclick="plusSlides(1)">&#10095;</a>
                    <div class="thumbnail-row">
                        <c:forEach items="${mediaList}" var="img">
                            <div class="column">
                                <img class="demo cursor" src="assets/image/product/${img.image}" style="width:100%" onclick="currentSlide(1)" alt="Thumbnail">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Product details -->
            <div class="col-lg-6">
                <form action="viewdetail" method="post" class="product__details__text">
                    <div class="product__label">${category.name}</div>
                    <h4>${product.name}</h4>
                    <h5 id="price">0 vnd</h5>
                    <h5>Size:</h5>
                    <c:forEach var="pd" items="${productDetailList}">
                        <button type="button"
                                name="btnSize"
                                class="btn btn-outline-info mb-3"
                                value="${pd.id}, ${pd.price}, ${pd.size}"
                                onclick="changeSize(${pd.price}, '${pd.size}', ${pd.id})">
                                ${pd.size}
                        </button>
                    </c:forEach>

                    <input type="hidden" name="idPd" value="" id="selectId">
                    <input type="hidden" name="size" value="" id="selectSize"/>
                    <input type="hidden" name="price" value="" id="selectPrice"/>

                    <div class="product__details__option row">
                        <div class="quantity col-12 mb-3">
                            <h5>Quantity:</h5>
                            <div class="pro-qty">
                                <input type="number" name="quantity" id="myInput" value="1" min="1"/>
                            </div>
                        </div>
                        <div class="col-12">
                            <h5>Description:</h5>
                            <p>${product.description}</p>
                        </div>
                        <button type="submit" name="btnBuy" class="primary-btn col-4">Buy now</button>
                        <c:if test="${user != null}">
                            <button type="submit" name="btnAddToCart" class="primary-btn cart-btn col-4">Add to cart</button>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <!-- Nội dung footer ở đây -->
</footer>

<!-- Js Plugins -->
<script src="../../assets/js/jquery-3.3.1.min.js"></script>
<script src="../../assets/js/bootstrap.min.js"></script>
<script src="../../assets/js/jquery.nice-select.min.js"></script>
<script src="../../assets/js/jquery.barfiller.js"></script>
<script src="../../assets/js/jquery.magnific-popup.min.js"></script>
<script src="../../assets/js/jquery.slicknav.js"></script>
<script src="../../assets/js/owl.carousel.min.js"></script>
<script src="../../assets/js/jquery.nicescroll.min.js"></script>
<script src="../../assets/js/main.js"></script>

</body>
</html>
