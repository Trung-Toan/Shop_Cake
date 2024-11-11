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
    <title>Cake</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../assets/css/style.css">
    <!-- Custom Style -->
    <style>
        /* General styling */
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }

        /* Product Details Section */
        .product-details {
            padding: 50px 0;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Image Gallery Styling */
        .container {
            position: relative;
            max-width: 100%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .mySlides img {
            width: 100%;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }

        .mySlides img:hover {
            transform: scale(1.05);
        }

        /* Navigation arrows */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            padding: 12px;
            color: #fff;
            font-weight: bold;
            font-size: 24px;
            user-select: none;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            transform: translateY(-50%);
        }

        .next {
            right: 10px;
        }

        .prev {
            left: 10px;
        }

        .prev:hover, .next:hover {
            background-color: rgba(0, 0, 0, 0.8);
        }

        /* Thumbnail row styling */
        .thumbnail-row {
            display: flex;
            overflow-x: auto;
            white-space: nowrap;
            padding-top: 10px;
            margin-top: 15px;
            border-top: 1px solid #ddd;
        }

        .column {
            flex: 0 0 auto;
            width: 18%;
            padding: 5px;
        }

        .demo {
            border-radius: 5px;
            opacity: 0.6;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .demo:hover {
            opacity: 1;
            transform: scale(1.1);
        }

        .thumbnail-row .demo.active {
            opacity: 1;
            border: 2px solid #ffc107;
        }

        /* Product Details Text Styling */
        .product__details__text {
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .product__label {
            font-size: 18px;
            font-weight: 700;
            color: #ffc107;
        }

        .product__details__text h4 {
            font-size: 26px;
            margin-top: 10px;
            margin-bottom: 15px;
            font-weight: 700;
            color: #333;
        }

        .product__details__text h5 {
            font-size: 18px;
            margin-top: 10px;
            color: #666;
        }

        .product__details__text p {
            font-size: 14px;
            line-height: 1.6;
            color: #666;
        }

        /* Buttons Styling */
        .primary-btn {
            background-color: #ffc107;
            color: #fff;
            font-size: 16px;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 30px;
            transition: background-color 0.3s;
            border: none;
        }

        .primary-btn:hover {
            background-color: #ffae00;
            color: #fff;
        }

        .btn-outline-info {
            color: #ffc107;
            border-color: #ffc107;
            transition: background-color 0.3s, color 0.3s;
        }

        .btn-outline-info:hover {
            background-color: #ffc107;
            color: #fff;
        }

        /* Quantity Input Styling */
        .pro-qty input[type="number"] {
            width: 60px;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
            text-align: center;
            font-size: 14px;
        }

        /* Number Text for Slideshow */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<!-- Shop Details Section -->
<section class="product-details spad">
    <div class="container">
        <div class="row">
            <!-- Image gallery -->
            <div class="col-lg-6">
                <div class="container">
                    <c:forEach items="${mediaList}" var="img">
                        <div class="mySlides">
                            <img src="data:image/png;base64,${img.image}" style="width:100%">
                        </div>
                    </c:forEach>
                    <a class="prev text-decoration-none" onclick="plusSlides(-1)">&#10094;</a>
                    <a class="next text-decoration-none" onclick="plusSlides(1)">&#10095;</a>
                    <div class="thumbnail-row">
                        <c:forEach items="${mediaList}" var="img" varStatus="status">
                            <div class="column">
                                <img class="demo cursor" src="data:image/png;base64,${img.image}" style="width:100%"
                                     onclick="currentSlide(${status.index + 1})" alt="Thumbnail">
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
                                class="btn btn-outline-warning"
                                value="${pd.id}, ${pd.price}, ${pd.size}"
                                onclick="changeSize('${pd.price}', '${pd.size}','${pd.id}')">
                                ${pd.size}
                        </button>
                    </c:forEach>

                    <input type="hidden" name="idPd" value="" id="selectId">
                    <input type="hidden" name="size" value="" id="selectSize"/>
                    <input type="hidden" name="price" value="" id="selectPrice"/>

                    <div class="quantity col-12 mb-3">
                        <h5>Quantity:</h5>
                        <div class="pro-qty">
                            <input type="number" name="quantity" id="myInput" value="1" min="1"/>
                        </div>
                    </div>
                    <div class="col-12 d-flex">
                        <button type="submit" name="btnBuy" class="primary-btn col-4" style="margin-right: 20px">Buy
                            now
                        </button>
                        <c:if test="${user != null}">
                            <button type="submit" name="btnAddToCart" class="primary-btn cart-btn col-4">Add to cart
                            </button>
                        </c:if>
                    </div>
                </form>
            </div>
            <div class="mb-3 mt-3">
                <h5>Description:</h5>
                <p>${product.description}</p>
            </div>
        </div>
    </div>
</section>
<!-- Js Plugins -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
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

    function changeSize(price, size, id) {
        document.getElementById("price").innerHTML = price + " vnd";
        document.getElementById("selectId").value = id;
        document.getElementById("selectSize").value = size;
        document.getElementById("selectPrice").value = price;
        let $value = [];
        const buttons = document.querySelectorAll("button[name='btnSize']");

        buttons.forEach(btn => {
            $value = btn.value.split(", ");
            if ($value[0] === id) {
                btn.classList.remove("btn-outline-warning");
                btn.classList.add("btn-warning");
            }
            else {
                btn.classList.remove("btn-warning");
                btn.classList.add("btn-outline-warning");
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        const firstButton = document.querySelector("button[name='btnSize']");
        if (firstButton) {
            const value = firstButton.value.split(",");
            changeSize(value[1], value[2], value[0]);
        }
    });

</script>
</body>
</html>
