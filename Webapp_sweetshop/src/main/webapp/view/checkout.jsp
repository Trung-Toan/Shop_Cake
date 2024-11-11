<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-w4T06fD0C2yO5e4J3An0kSkZ7AzAp5eWz5nJAzVkmDNFNg4EN4z8nGqDhOXDheTi"
          crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .checkout {
            padding: 60px 0;
        }

        .checkout__title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .billing-details {
            border: 1px solid #e3e3e3;
            padding: 30px;
            border-radius: 10px;
            background-color: white;
        }

        .order-summary {
            background-color: #ffe4b5; /* Light orange background color */
            border-radius: 10px;
            padding: 20px;
            margin-left: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .order-summary h4 {
            margin-bottom: 20px;
        }

        .order-summary .total {
            font-weight: bold;
        }

        .btn-primary {
            background-color: #343a40;
            border-color: #343a40;
        }

        .btn-primary:hover {
            background-color: #23272b;
            border-color: #1d2124;
        }

    </style>
</head>

<body>

<jsp:include page="header.jsp" flush="true"/>

<section class="checkout">
    <div class="container">
        <form action="/checkout" method="post" class="row" onsubmit="return checkform(event)">
            <div class="col-lg-8">
                <div class="billing-details">
                    <h4>BILLING DETAILS</h4>
                    <%-- first name and last name--%>
                    <div class="row mb-3">
                        <div class="col-md-6" style="padding-left: 0px;">
                            <label for="firstName" class="form-label">First Name<span
                                    style="color: red;"><b>*</b></span></label>
                            <input type="text" name="firstName" class="form-control" id="firstName"
                                   placeholder="Enter first name" fdprocessedid="y9luur">
                        </div>
                        <div class="col-md-6" style="padding-right: 0px;">
                            <label for="lastName" class="form-label">Last Name<span style="color: red;"><b>*</b></span></label>
                            <input type="text" name="lastName" class="form-control" id="lastName"
                                   placeholder="Enter last name" fdprocessedid="4dqzv7">
                        </div>
                    </div>
                    <%-- phone number and email --%>
                    <div class="row mb-3">
                        <div class="col-md-6" style="padding-left: 0;">
                            <label for="phoneNumber" class="form-label">Phone number<span
                                    style="color: red;"><b>*</b></span></label>
                            <input type="text" name="phoneNumber" class="form-control" id="phoneNumber"
                                   placeholder="Enter phone number">
                        </div>
                        <div class="col-md-6" style="padding-right: 0;">
                            <label for="email" class="form-label">Email<span style="color: red;"><b>*</b></span></label>
                            <input type="email" name="email" class="form-control" id="email"
                                   placeholder="Enter email">
                        </div>
                    </div>
                    <%-- location get product --%>
                    <div class="row mb-3">
                        <div class="col-md-3 col-sm-12" style="padding-left: 0">
                            <label for="village" class="form-label">
                                Village<span style="color: red;"><b>*</b></span>
                            </label>
                            <input type="text" name="village" class="form-control" id="village"
                                   placeholder="Enter village ...">
                        </div>
                        <div class="col-sm-12 col-md-3">
                            <label for="location" class="form-label">
                                Commune<span style="color: red;"><b>*</b></span>
                            </label>
                            <select class="form-select" id="location" name="location">
                                <c:forEach var="l" items="${location}">
                                    <option value="${l}">${l}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-sm-12 col-md-3">
                            <label for="district" class="form-label">
                                District<span style="color: red;"><b>*</b></span>
                            </label>
                            <select class="form-select" id="district" name="district">
                                <option value="Thạch Thất" style="width: 100%">Thạch Thất</option>
                            </select>
                        </div>
                        <div class="col-sm-12 col-md-3" style="padding-right: 0">
                            <label for="country" class="form-label">
                                Country<span style="color: red;"><b>*</b></span>
                            </label>
                            <select class="form-select" id="country" name="country">
                                <option value="Hà Nội">Hà Nội</option>
                            </select>
                        </div>
                    </div>
                    <%-- note --%>
                    <div class="mb-3">
                        <label for="orderNotes" class="form-label">Order notes<span style="color: red;"><b>*</b></span></label>
                        <textarea name="orderNotes" class="form-control" id="orderNotes" rows="3"
                                  placeholder="Notes about your order, e.g. special notes for delivery."
                        ></textarea>
                    </div>
                    <%-- voucher --%>
                    <div class="mb-3">
                        <p></p>
                        <label for="voucher" class="form-label">Voucher</label>
                        <input type="text" name="voucher" class="form-control" id="voucher"
                               placeholder="Add code voucher"/>
                    </div>
                    <input type="hidden" id="voucherList" name="voucherList" value="${codeVoucher}"/>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="order-summary">
                    <h4>YOUR ORDER</h4>
                    <ol type="1">
                        <%-- Initialize the total variable --%>
                        <c:set var="total" value="0.0" scope="page"/>
                        <c:forEach var="pd" items="${listPD}" varStatus="status">
                            <li class="d-flex justify-content-between">
                <span>
                    <samp>${status.index + 1}. </samp>${product.getProductById(pd.productID).name}
                </span>
                                <span>${pd.price} vnd</span>

                                    <%-- Update the total for each item --%>
                                <c:set var="total" value="${total + pd.price}" scope="page"/>
                            </li>
                        </c:forEach>
                    </ol>
                    <hr/>
                    <div class="total d-flex justify-content-between">
                        <span>Total</span>
                        <%-- Format the total to two decimal places --%>
                        <span>
                            <fmt:formatNumber value="${total}" type="number"
                                              minFractionDigits="2" maxFractionDigits="2"/> vnd
                        </span>
                        <input type="hidden" name="pice" value="<fmt:formatNumber value="${total}" type="number"
                                              minFractionDigits="2" maxFractionDigits="2"/>">
                    </div>
                    <hr/>
                    <button type="submit" name="btnPlaceOrder" value="btnPlaceOrder" class="btn btn-warning">PLACE ORDER</button>
                </div>
            </div>
        </form>
    </div>
</section>

<jsp:include page="footer.jsp" flush="true"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-VoE7VGFccr6nlwRvAQHnaRAZ6c27w5iTYsOgXiAiknEF4NEeF1NSiReMPlEO+6eD"
        crossorigin="anonymous"></script>
<script>
    function checkform(event) {
        let valid = true; // Khởi tạo valid là true
        // Kiểm tra tên
        valid &= checkField("firstName", "Name cannot be blank!");
        // Kiểm tra họ
        valid &= checkField("lastName", "They cannot be left blank!");
        // Kiểm tra số điện thoại
        valid &= checkPhoneField("phoneNumber");
        // Kiểm tra email
        valid &= checkField("email", "Email cannot be empty!");
        // Kiểm tra làng/xã
        valid &= checkField("village", "The village cannot be left empty!");
        // Kiểm tra ghi chú
        valid &= checkField("orderNotes", "Notes cannot be left blank!");
        // Kiểm tra voucher (nếu cần)
        let voucher = validateInput(document.getElementById("voucher").value);
        if (voucher != "") {
            valid &= checkValid(document.getElementById("voucher"), checkVoucher(voucher), "Voucher does not exist!");
        }
        if (!valid) {
            event.preventDefault();
            return false;
        }
        return true;
    }

    function checkVoucher(voucher) {
        let check = false;
        let voucherList = document.getElementById("voucherList").value.split("|");
        console.log(document.getElementById("voucherList").value);
        for (let v of voucherList) {
            if (v == voucher) check = true;
        }
        return check;
    }

    function checkField(fieldId, errorMessage) {
        const field = document.getElementById(fieldId);
        const value = validateInput(field.value);
        return checkValid(field, value, errorMessage);
    }

    function checkPhoneField(fieldId) {
        const field = document.getElementById(fieldId);
        const value = field.value.trim();
        let valid = true;
        // Check if the field is empty
        if (validateInput(value) === false) {
            valid = checkValid(field, false, "The phone number is not null!");
        } else if (validatePhoneNumber(value) === false) {
            valid = checkValid(field, false, "The phone number format is incorrect!");
        } else {
            // If valid, remove any existing error message
            field.classList.remove("is-invalid");
            removeExistingError(field);
        }
        return valid;
    }

    function checkValid(field, input, message) {
        let valid = true;
        // Remove existing error messages
        removeExistingError(field);
        if (input == null || input === "" || input == false) {
            field.classList.add("is-invalid");
            let error = document.createElement("span");
            error.className = "text-danger";
            error.innerText = message;
            field.parentNode.appendChild(error);
            valid = false;
        } else {
            field.classList.remove("is-invalid");
        }
        return valid;
    }

    function removeExistingError(field) {
        const existingErrors = field.parentNode.querySelectorAll(".text-danger");
        existingErrors.forEach(error => error.remove());
    }

    function validatePhoneNumber(phoneNumber) {
        const phoneRegex = /^(?:\+84|0)\d{9}$/;
        return phoneRegex.test(phoneNumber);
    }

    function validateInput(input) {
        return input.trim() !== "" ? input.trim() : ""; // Return empty string if input is invalid
    }
</script>
</body>
</html>
