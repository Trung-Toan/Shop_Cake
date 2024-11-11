<%-- Created by IntelliJ IDEA. User: Admin Date: 10/14/2024 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .otp-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .otp-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .otp-header h2 {
            margin-bottom: 0;
        }

        .otp-form .form-label {
            font-weight: 600;
        }

        .btn-verify {
            background-color: #ffc107;
            border: none;
            transition: background-color 0.3s;
            color: #fff;
        }

        .btn-verify:hover {
            background-color: #e0a800;
            color: #fff;
        }

        #otp:focus {
            box-shadow: none;
            border-color: #ffc107;
        }

        .messages {
            min-height: 1.5rem;
        }

        .otp-footer {
            text-align: center;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

<section class="d-flex justify-content-center" style="margin-top: 32px">
    <div class="otp-container">
        <div class="otp-header">
            <h2>OTP Verification</h2>
            <p class="text-muted">Please enter the OTP sent to your email</p>
        </div>
        <div class="messages text-center ${mess != null ? "text-success" : (message != null ? "text-danger" : "")} mb-3" id="messages">
            ${mess != null ? mess : message}
        </div>

        <form action="check_otp" method="post" class="otp-form" onsubmit="return checkOtp(event)" novalidate>
            <div class="mb-3">
                <label for="otp" class="form-label">OTP Code</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                    <input type="text" class="form-control" id="otp" name="otp"
                           placeholder="Enter your OTP" maxlength="6">
                </div>
                <!-- OTP error message -->
                <span class="error-message text-danger" id="otpError"></span>
            </div>
            <button type="submit" name="btnVerifyOtp" value="btnVerifyOtp"
                    class="btn-verify w-100 p-2" style="border-radius: 5px">Verify OTP
            </button>
        </form>
        <div class="otp-footer">
            <p class="mt-4">Didn't receive the OTP? <a href="/check_otp">Resend OTP</a></p>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" flush="true"/>

<!-- Bootstrap JS and dependencies Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76A28Yd8uWAtIcH4n9t+K37CRvW0OZZ9N4L9M+0KfE11cMFA9hB7UwPbmdLM/5d" crossorigin="anonymous">
</script>
<script>
    function checkOtp(event) {
        let isValid = true;

        const otp = document.getElementById("otp");
        const otpError = document.getElementById("otpError");

        function showError(inputElement, errorElement, message) {
            inputElement.classList.add("is-invalid");
            errorElement.textContent = message;
        }

        function clearError(inputElement, errorElement) {
            inputElement.classList.remove("is-invalid");
            errorElement.textContent = "";
        }

        clearError(otp, otpError);

        if (otp.value.trim() === "") {
            showError(otp, otpError, "You must enter the OTP!");
            isValid = false;
        } else if (otp.value.trim().length !== 6 || isNaN(otp.value.trim())) {
            showError(otp, otpError, "OTP must be a 6-digit number!");
            isValid = false;
        }

        if (!isValid) {
            event.preventDefault();
            return false;
        }

        return true;
    }
</script>
</body>
</html>
