<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin &amp; Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="../../assets/image/icons/icon-48x48.png" />
    <link rel="canonical" href="/edit-customer.jsp" />
    <title>Edit Customer</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link class="js-stylesheet" href="../../assets/css/light.css" rel="stylesheet">

    <!-- Choose your prefered color scheme -->
    <!-- <link href="css/light.css" rel="stylesheet"> -->
    <!-- <link href="css/dark.css" rel="stylesheet"> -->

    <!-- BEGIN SETTINGS -->
    <!-- Remove this after purchasing -->
    <link class="js-stylesheet" href="../../assets/css/light.css" rel="stylesheet">
    <!-- <script src="../../assets/js/settings.js"></script>  -->

    <style>
        body {
            opacity: 0;
        }
        .content {
            padding: 0px;
        }

    </style>
    <!-- END SETTINGS -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-120946860-10"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-120946860-10', { 'anonymize_ip': true });
    </script>
</head>
<!--
  HOW TO USE:
  data-theme: default (default), dark, light, colored
  data-layout: fluid (default), boxed
  data-sidebar-position: left (default), right
  data-sidebar-layout: default (default), compact
-->

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
<div class="wrapper">

    <!--begin of sidebar-->
    <nav id="sidebar" class="sidebar js-sidebar">
        <div class="sidebar-content js-simplebar">
            <a class="sidebar-brand" href="index.html">
					<span class="sidebar-brand-text align-middle">
						Sweet Shop
                    </span>
                <svg class="sidebar-brand-icon align-middle" width="32px" height="32px" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="1.5"
                     stroke-linecap="square" stroke-linejoin="miter" color="#FFFFFF" style="margin-left: -3px">
                    <path d="M12 4L20 8.00004L12 12L4 8.00004L12 4Z"></path>
                    <path d="M20 12L12 16L4 12"></path>
                    <path d="M20 16L12 20L4 16"></path>
                </svg>
            </a>

            <div class="sidebar-user">
                <div class="d-flex justify-content-center">
                    <div class="flex-shrink-0">
                        <img src="data:image/jpeg;base64,${loggedInUser.avatar}" class="avatar img-fluid rounded me-1" alt="avatar" />
                    </div>
                    <div class="flex-grow-1 ps-2">
                        <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            ${loggedInUser.fullName != null ? loggedInUser.fullName : ''}
                        </a>
                        <div class="dropdown-menu dropdown-menu-start">
                            <a class="dropdown-item" href="/editprofile"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="settings"></i> Change Password</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/logout">Log out</a>
                        </div>
                        <!-- Hiển thị role dựa trên giá trị -->
                        <div class="sidebar-user-subtitle">
                            <c:choose>
                                <c:when test="${loggedInUser.role == 2}">
                                    Staff
                                </c:when>
                                <c:when test="${loggedInUser.role == 3}">
                                    Shipper
                                </c:when>
                                <c:when test="${loggedInUser.role == 4}">
                                    Admin
                                </c:when>
                                <c:otherwise>
                                    :>>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="sidebar-nav">
                <li class="sidebar-item pa">
                    <a class="sidebar-link" href="#">
                        <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboards</span>
                    </a>
                </li>

                <li class="sidebar-item pa">
                    <a data-bs-target="#icons" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="layout"></i> <span class="align-middle">Manager Products</span>
                    </a>
                    <ul id="icons" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item"><a class="sidebar-link" href="#">List Products</a></li>
                        <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Products</a></li>
                    </ul>
                </li>

                <li class="sidebar-item pa">
                    <a data-bs-target="#order" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="list"></i> <span class="align-middle">Manager Orders</span>
                    </a>
                    <ul id="order" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                        <li class="sidebar-item"><a class="sidebar-link" href="#">List Orders</a></li>
                        <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Orders</a></li>
                    </ul>
                </li>

                <li class="sidebar-item active">
                    <a data-bs-target="#form-plugins" data-bs-toggle="collapse" class="sidebar-link ">
                        <i class="align-middle" data-feather="check-square"></i> <span class="align-middle">Manager Customers</span>
                    </a>
                    <ul id="form-plugins" class="sidebar-dropdown list-unstyled collapse show " data-bs-parent="#sidebar">
                        <li class="sidebar-item active "><a class="sidebar-link" href="/getcustomer">List Customers</a></li>
                        <li class="sidebar-item"><a class="sidebar-link" href="/addcustomer">Add New Customer</a></li>
                    </ul>
                </li>

                <li class="sidebar-item pa">
                    <a data-bs-target="#pages" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="users"></i> <span class="align-middle">Manager Staffs</span>
                    </a>
                    <ul id="pages" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                        <li class="sidebar-item "><a class="sidebar-link" href="/getstaff">List Staffs</a></li>
                        <li class="sidebar-item"><a class="sidebar-link" href="/addstaff">Add New Staff</a></li>
                    </ul>
                </li>
                <li class="sidebar-item pa">
                    <a data-bs-target="#shipper" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="user"></i> <span class="align-middle">Manager Shippers</span>
                    </a>
                    <ul id="shipper" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                        <li class="sidebar-item"><a class="sidebar-link" href="#">List Shippers</a></li>
                        <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Shipper</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>


    <div class="main">

        <jsp:include page = "../common/navbar.jsp" ></jsp:include>

        <main class="content">
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-md-12 col-xl-12">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="account" role="tabpanel">
                                <div class="card">
                                    <div class="card-body">
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-info">${message}</div>
                                        </c:if>
                                        <form id="staffForm" enctype="multipart/form-data" method="POST" action="/updatecustomer">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <!-- cus ID (Read-only) -->
                                                    <div class="mb-3">
                                                        <label for="id">ID:</label>
                                                        <input type="text" class="form-control" id="id" name="id" value="${customer.id}" readonly>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="fullname">Full Name:</label>
                                                        <input type="text" class="form-control" id="fullname" name="myname" placeholder="Full Name"
                                                               value="${customer.fullName != null ? customer.fullName : ''}" oninput="validateField('fullname')">
                                                        <div id="fullnameError" class="text-danger" style="display: none;"></div>
                                                    </div>

                                                    <!-- Date Of Birth -->
                                                    <div class="mb-3">
                                                        <label for="dob">Date Of Birth:</label>
                                                        <input type="date" class="form-control" id="dob" name="dob" placeholder="Date Of Birth"
                                                               value="${customer.dob != null ? customer.dob : ''}" oninput="validateField('dob')">
                                                        <div id="dobError" class="text-danger" style="display: none;"></div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="text-center">
                                                        <!-- Hình ảnh hiện tại -->
                                                        <c:choose>
                                                            <c:when test="${not empty customer.avatar}">
                                                                <img id="previewImage" alt="Avatar" src="data:image/jpeg;base64,${customer.avatar}"
                                                                     class="rounded-circle img-responsive mt-2" width="128" height="128" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img id="previewImage" alt="Avatar" src="../../assets/image/avatars/avatar.jpg"
                                                                     class="rounded-circle img-responsive mt-2" width="128" height="128" />
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <!-- Upload Button -->
                                                        <div class="mt-2">
                                                            <!-- Nút bấm Upload để kích hoạt input file -->
                                                            <span class="btn btn-primary" onclick="document.getElementById('file-upload').click();">
                                                                <i class="fas fa-upload"></i> Upload
                                                            </span>
                                                        </div>

                                                        <!-- Input file ẩn -->
                                                        <input type="file" id="file-upload" name="profilePic" accept=".jpg"
                                                               style="display: none;" onchange="handleImageUpload(event)">

                                                        <!-- Thông báo lỗi nếu có -->
                                                        <small>For best results, use an image at least 128px by 128px in .jpg format</small>
                                                        <div id="fileError" class="text-danger" style="display: none;"></div>

                                                        <!-- Trường ẩn để chứa hình ảnh gốc (chuỗi base64) -->
                                                        <input type="hidden" name="profilePicOriginal" id="profilePicOriginal" value="${customer.avatar}">
                                                    </div>
                                                </div>

                                                <!-- Gender -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="gender">Gender:</label>
                                                    <select id="gender" name="gender" class="form-control" data-style="py-0" onchange="validateField('gender')">
                                                        <option value="false" ${!customer.gender ? 'selected' : ''}>Female</option>
                                                        <option value="true" ${customer.gender ? 'selected' : ''}>Male</option>
                                                    </select>
                                                    <div id="genderError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Status -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="status">Status:</label>
                                                    <select id="status" name="status" class="form-control" data-style="py-0" onchange="validateField('status')">
                                                        <option value="1" ${customer.status == 1 ? 'selected' : ''}>Active</option>
                                                        <option value="0" ${customer.status == 0 ? 'selected' : ''}>Disable</option>
                                                    </select>
                                                    <div id="statusError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Mobile Number -->
                                                <div class="mb-3">
                                                    <label class="form-label" for="mobno">Mobile Number:</label>
                                                    <input type="text" class="form-control" id="mobno" name="mobno" placeholder="Mobile Number"
                                                           value="${customer.phone != null ? customer.phone : ''}"  oninput="validateField('mobno')">
                                                    <div id="mobnoError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Address -->
                                                <div class="mb-3">
                                                    <label class="form-label" for="address">Address</label>
                                                    <input type="text" class="form-control" id="address" name="address" placeholder="Address"
                                                           value="${customer.address != null ? customer.address : ''}" oninput="validateField('address')">
                                                    <div id="addressError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Email -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="email">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                                           value="${customer.email != null ? customer.email : ''}" oninput="validateField('email')">
                                                    <div id="emailError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Username -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="uname">User Name:</label>
                                                    <input type="text" class="form-control" id="uname" name="uname" placeholder="User Name"
                                                           value="${customer.username != null ? customer.username : ''}" oninput="validateField('uname')">
                                                    <div id="unameError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Created At (Read-only) -->
                                                <div class="mb-3 col-md-6">
                                                    <label for="createdAt">Created At:</label>
                                                    <input type="text" class="form-control" id="createdAt" name="createdAt"
                                                           value="${customer.createdAt != null ? customer.createdAt : ''}" readonly>
                                                </div>

                                                <!-- Updated At (Read-only) -->
                                                <div class="mb-3 col-md-6">
                                                    <label for="updatedAt">Updated At:</label>
                                                    <input type="text" class="form-control" id="updatedAt" name="updatedAt"
                                                           value="${customer.updatedAt != null ? customer.updatedAt : ''}" readonly>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary" onclick="return validateForm(event);">Save</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>

        <jsp:include page = "../common/footer.jsp" ></jsp:include>

    </div>
</div>

<!-- Feather Icons -->
<script src="https://unpkg.com/feather-icons"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Feather Icons
    feather.replace();
</script>
<script src="../../assets/js/user/validate.js"></script>
<script src="../../assets/js/app.js"></script>
</body>
</html>