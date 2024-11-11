<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login </title>
    <style>
        :root {
            --primary: #605DFF;
            --primary-dark: #4a00e0;
            --primary-light: #5DA8FF;
            --secondary: #1D1D1D;
            --social-background: #E9E9E9;
            --social-background-hover: #dddddd;
            --text: #1F2346;
            --white: #FFFFFF;
            --violet: #8e2de2;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-size: 16px;
            font-family: 'Work Sans', sans-serif;
            height: 100vh;
            padding: 1rem;
            display: flex;
            justify-content: center;
            align-items: center;
            background: var(--violet);
            background: -webkit-linear-gradient(to right, var(--violet), var(--primary-dark));
            background: linear-gradient(to right, var(--violet), var(--primary-dark));
        }
        .logo {
            height: 40px;
            margin: 0 auto;
        }
        .my-form {
            display: flex;
            flex-direction: column;
            justify-content: start;
            position: relative;
            gap: 1rem;
            background-color: var(--white);
            width: 100%;
            max-width: 32rem;
            padding: 3rem 2rem;
            border-radius: 2rem;
            height: fit-content;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        .my-form_button {
            background-color: var(--primary);
            color: white;
            white-space: nowrap;
            border: none;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 16px;
            line-height: 50px;
            outline: none;
            font-size: 18px;
            letter-spacing: 0.025em;
            text-decoration: none;
            cursor: pointer;
            font-weight: 800;
            min-height: 50px;
            width: 100%;
            border-radius: 99px;
            transition: all .3s ease;
            -webkit-transition: all .3s ease;
        }
        .my-form_button:hover {
            background-color: var(--primary-dark);
        }
        .input_wrapper {
            position: relative;
            padding: 15px 0;
            margin-bottom: 0.5rem;
        }
        .input_field {
            font-size: 1.5rem;
            color: var(--text);
            padding: 6px 0px;
            padding-right: 32px;
            padding-bottom: 8px;
            line-height: 2rem;
            height: 2rem;
            outline: 0px;
            border: 0px;
            width: 100%;
            vertical-align: middle;
            padding-bottom: 0.7em;
            border-bottom: 3px solid var(--secondary);
            background: transparent;
            transition: border-color 0.2s;
        }
        .input_field::placeholder {
            color: transparent;
        }
        .input_label {
            position: absolute;
            top: 0;
            left: 0;
            transform-origin: 0% 100%;
            transform: translateY(1.1em);
            font-size: 1.2rem;
            transition: all 0.2s ease;
            user-select: none ;
        }
        .input_field:not(:placeholder-shown) + .input_label, .input_field:focus + .input_label {
            transform: translateY(-50%);
            color: #b6b6b6;
            font-size: 1rem;
        }
        .socials-row {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .socials-row img {
            width: 24px;
            height: 24px;
        }
        .socials-row>a {
            padding: 8px;
            border-radius: 99px;
            width: 100%;
            min-height: 48px;
            display: flex;
            gap: 12px;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            font-size: 1.1rem;
            color: var(--text);
            padding: 8px;
            background-color: var(--social-background);
            font-weight: 700;
        }
        .socials-row>a:hover {
            background-color: var(--social-background-hover);
        }
        .login-welcome -row {
            margin-bottom: 1rem;
            text-align: center;
        }
        .welcome-message {
            max-width: 360px;
        }
        .error-message {
            color: red;
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
<form action="/login" method="post" class="my-form">
    <div class="login-welcome-row">
        <h1>Welcome back &#x1F44F;</h1>
    </div>
    <!-- Hiển thị message nếu tồn tại -->
    <c:if test="${not empty message}">
        <div class="error-message">${message}</div>
    </c:if>
    <div class="input_wrapper">
        <input type="text" id="nameOrEmail" name="nameOrEmail" class="input_field" placeholder="User name or email..." required
               value="${nameOrEmail != null ? nameOrEmail : ''}" >
        <label for="nameOrEmail" class="input_label">User Name Or Email:</label>
    </div>
    <div class="input_wrapper">
        <input id="password" name="password" type="password" class="input_field mb-3"
               placeholder="Your Password"  value="${password != null ? password : ''}"
               title="Minimum 8 characters">
        <label for="password" class="input_label mb-3">Password:</label>
    </div>
    <button type="submit" name="btnLogin" class="my-form_button">Login</button>
    <div class="socials-row">
        <a href="#" title="Use Google">
            <img src="../../assets/img/google.png" alt="Google">Log in with Google
        </a>
    </div>
    <div class="my-form_actions">
        <div class="my-form_row">
            <span>Don't have an account?</span>
            <a href="#" title="Create Account">Sign Up</a>
        </div>
    </div>
</form>
<script src="script.js"></script>
</body>
</html>