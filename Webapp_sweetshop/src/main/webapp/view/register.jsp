<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 9/28/2024
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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

        .login-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px; /* Tăng từ 400px lên 500px */
        }

        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .login-header h2 {
            margin-bottom: 0;
        }

        .login-form .form-label {
            font-weight: 600;
        }

        /* Updated button class from btn-custom to btn-login */
        .btn-login {
            background-color: #ffc107;
            border: none;
            transition: background-color 0.3s;
            color: #fff; /* Ensure text is visible */
        }

        .btn-login:hover {
            background-color: #e0a800;
            color: #fff; /* Maintain text color on hover */
        }

        #username:focus, #password:focus, #repeat__password:focus, #email:focus {
            box-shadow: none;
            border-color: #ffc107;
        }

        .messages {
            min-height: 1.5rem;
        }

        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
        }

        /* Optional: Style for the "Login" link */
        .login-form a {
            font-size: 0.9rem;
            color: #ffc107;
            text-decoration: none;
        }

        .login-form a:hover {
            text-decoration: underline;
            color: #e0a800;
        }

        /* Style cho thông báo lỗi */
        .error-message {
            font-size: 0.875em;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>

<section class="d-flex justify-content-center" style="margin-top: 32px;">
    <div class="login-container">
        <div class="login-header">
            <h2>Register</h2>
        </div>
        <div class="messages text-center text-danger mb-3" id="messages">
            ${message}
        </div>
        <form action="login" method="post" class="login-form" onsubmit="return validateRegister(event)" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" value="${usename == null ? "" : usename}" id="username" name="username"
                           placeholder="Enter your username">
                </div>
                <!-- Thông báo lỗi cho Username -->
                <span class="error-message text-danger" id="usernameError"></span>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" class="form-control" value="${email == null ? "" : email}" id="email" name="email"
                           placeholder="Enter your email">
                </div>
                <!-- Thông báo lỗi cho Email -->
                <span class="error-message text-danger" id="emailError"></span>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" value="${password == null ? "" : password}" id="password" name="password"
                           placeholder="Enter your password">
                    <span class="input-group-text">
                        <i class="fas fa-eye-slash" id="togglePassword" style="cursor: pointer;"></i>
                    </span>
                </div>
                <!-- Thông báo lỗi cho Password -->
                <span class="error-message text-danger" id="passwordError"></span>
            </div>
            <div class="mb-4">
                <label for="repeat__password" class="form-label">Repeat Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" value="${password == null ? "" : password}" id="repeat__password" name="repeat_password"
                           placeholder="Enter your password again">
                    <span class="input-group-text">
                        <i class="fas fa-eye-slash" id="toggleRepeatPassword" style="cursor: pointer;"></i>
                    </span>
                </div>
                <!-- Thông báo lỗi cho Repeat Password -->
                <span class="error-message text-danger" id="repeatPasswordError"></span>
            </div>
            <!-- Updated button class -->
            <button type="submit" name="btnRegister" value="btnRegister"
                    class="btn-login w-100 p-2" style="border-radius: 5px">Register
            </button>
        </form>
        <div class="login-footer">
            <p class="mt-4">Already have an account? <a href="/login">Login</a></p>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" flush="true"/>

<!-- Bootstrap JS and dependencies Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76A28Yd8uWAtIcH4n9t+K37CRvW0OZZ9N4L9M+0KfE11cMFA9hB7UwPbmdLM/5d" crossorigin="anonymous">
</script>
<script>
    // Hàm chuyển đổi hiển thị/ẩn mật khẩu
    function togglePasswordVisibility(passwordFieldId, toggleIconId) {
        const passwordField = document.getElementById(passwordFieldId);
        const toggleIcon = document.getElementById(toggleIconId);

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("fa-eye-slash");
            toggleIcon.classList.add("fa-eye"); // Mắt mở
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("fa-eye");
            toggleIcon.classList.add("fa-eye-slash"); // Mắt nhắm
        }
    }

    // Thêm sự kiện cho các icon mắt
    document.getElementById("togglePassword").addEventListener("click", function () {
        togglePasswordVisibility("password", "togglePassword");
    });

    document.getElementById("toggleRepeatPassword").addEventListener("click", function () {
        togglePasswordVisibility("repeat__password", "toggleRepeatPassword");
    });

    // Hàm kiểm tra hợp lệ dữ liệu đăng ký
    function validateRegister(event) {
        let isValid = true;

        // Lấy các phần tử input và thông báo lỗi
        const username = document.getElementById("username");
        const email = document.getElementById("email");
        const password = document.getElementById("password");
        const repeatPassword = document.getElementById("repeat__password");

        const usernameError = document.getElementById("usernameError");
        const emailError = document.getElementById("emailError");
        const passwordError = document.getElementById("passwordError");
        const repeatPasswordError = document.getElementById("repeatPasswordError");

        clearError(username, usernameError);
        clearError(email, emailError);
        clearError(password, passwordError);
        clearError(repeatPassword, repeatPasswordError);

        if (username.value.trim() === "") {
            showError(username, usernameError, "You must enter the username!");
            isValid = false;
        }

        if (email.value.trim() === "") {
            showError(email, emailError, "You must enter the email!");
            isValid = false;
        } else {
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email.value.trim())) {
                showError(email, emailError, "Invalid email format!");
                isValid = false;
            }
        }

        if (password.value.trim() === "") {
            showError(password, passwordError, "You must enter the password!");
            isValid = false;
        }

        if (repeatPassword.value.trim() === "") {
            showError(repeatPassword, repeatPasswordError, "You must confirm your password!");
            isValid = false;
        } else if (password.value.trim() !== repeatPassword.value.trim()) {
            showError(repeatPassword, repeatPasswordError, "Password and confirm password do not match!");
            isValid = false;
        }
        if (!isValid) {
            event.preventDefault();
            return false;
        }

        return true;
    }

    function showError(inputElement, errorElement, message) {
        inputElement.classList.add("is-invalid");
        errorElement.textContent = message;
    }

    function clearError(inputElement, errorElement) {
        inputElement.classList.remove("is-invalid");
        errorElement.textContent = "";
    }

    document.getElementById("username").addEventListener("input", function () {
        const usernameError = document.getElementById("usernameError");
        if (this.value.trim() !== "") {
            clearError(this, usernameError);
        }
    });

    document.getElementById("email").addEventListener("input", function () {
        const emailError = document.getElementById("emailError");
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (this.value.trim() !== "" && emailPattern.test(this.value.trim())) {
            clearError(this, emailError);
        }
    });

    document.getElementById("password").addEventListener("input", function () {
        const passwordError = document.getElementById("passwordError");
        const password = this.value.trim();

        // Đặt cờ để kiểm tra xem mật khẩu có đủ mạnh hay không
        let isStrongPassword = true;
        let errorMessage = "";

        // Kiểm tra độ dài tối thiểu
        if (password.length < 8) {
            errorMessage = "Password must be at least 8 characters.";
            isStrongPassword = false;
        }
        // Kiểm tra có ít nhất một chữ cái viết hoa
        else if (!/[A-Z]/.test(password)) {
            errorMessage = "Password must contain at least one uppercase letter.";
            isStrongPassword = false;
        }
        // Kiểm tra có ít nhất một chữ cái viết thường
        else if (!/[a-z]/.test(password)) {
            errorMessage = "Password must contain at least one lowercase letter.";
            isStrongPassword = false;
        }
        // Kiểm tra có ít nhất một chữ số
        else if (!/[0-9]/.test(password)) {
            errorMessage = "Password must contain at least one digit.";
            isStrongPassword = false;
        }
        // Kiểm tra có ít nhất một ký tự đặc biệt
        else if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
            errorMessage = "Password must contain at least one special character.";
            isStrongPassword = false;
        }

        if (isStrongPassword) {
            clearError(this, passwordError);
        } else {
            showError(this, passwordError, errorMessage);
        }
    });

    document.getElementById("repeat__password").addEventListener("input", function () {
        const repeatPasswordError = document.getElementById("repeatPasswordError");
        if (this.value.trim() !== "") {
            if (this.value.trim() === document.getElementById("password").value.trim()) {
                clearError(this, repeatPasswordError);
            } else {
                showError(this, repeatPasswordError, "Password and confirm password do not match!");
            }
        }
    });
</script>
</body>
</html>
