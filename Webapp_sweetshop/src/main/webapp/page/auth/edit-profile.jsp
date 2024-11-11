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
    <link rel="canonical" href="/edit-profile.jsp" />
    <title>Edit Profile</title>
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
    <jsp:include page="../common/sidebar.jsp"></jsp:include>

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

                                        <form id="staffForm" enctype="multipart/form-data" method="POST" action="/updateprofile">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <!-- Staff ID (Read-only) -->
                                                    <div class="mb-3">
                                                        <label for="id">ID:</label>
                                                        <input type="text" class="form-control" id="id" name="id" value="${loggedInUser.id}" readonly>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="fullname">Full Name:</label>
                                                        <input type="text" class="form-control" id="fullname" name="myname" placeholder="Full Name"
                                                               value="${loggedInUser.fullName != null ? loggedInUser.fullName : ''}" oninput="validateField('fullname')">
                                                        <div id="fullnameError" class="text-danger" style="display: none;"></div>
                                                    </div>

                                                    <!-- Date Of Birth -->
                                                    <div class="mb-3">
                                                        <label for="dob">Date Of Birth:</label>
                                                        <input type="date" class="form-control" id="dob" name="dob" placeholder="Date Of Birth"
                                                               value="${loggedInUser.dob != null ? loggedInUser.dob : ''}" oninput="validateField('dob')">
                                                        <div id="dobError" class="text-danger" style="display: none;"></div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="text-center">
                                                        <!-- Hình ảnh hiện tại -->
                                                        <c:choose>
                                                            <c:when test="${not empty loggedInUser.avatar}">
                                                                <img id="previewImage" alt="Avatar" src="data:image/jpeg;base64,${loggedInUser.avatar}"
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
                                                        <input type="hidden" name="profilePicOriginal" id="profilePicOriginal" value="${loggedInUser.avatar}">
                                                    </div>
                                                </div>

                                                <!-- Gender -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="gender">Gender:</label>
                                                    <select id="gender" name="gender" class="form-control" data-style="py-0" onchange="validateField('gender')">
                                                        <option value="false" ${!loggedInUser.gender ? 'selected' : ''}>Female</option>
                                                        <option value="true" ${loggedInUser.gender ? 'selected' : ''}>Male</option>
                                                    </select>
                                                    <div id="genderError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Status -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="status">Status:</label>
                                                    <select id="status" name="status" class="form-control" data-style="py-0" onchange="validateField('status')">
                                                        <option value="1" ${loggedInUser.status == 1 ? 'selected' : ''}>Active</option>
                                                        <option value="0" ${loggedInUser.status == 0 ? 'selected' : ''}>Disable</option>
                                                    </select>
                                                    <div id="statusError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Mobile Number -->
                                                <div class="mb-3">
                                                    <label class="form-label" for="mobno">Mobile Number:</label>
                                                    <input type="text" class="form-control" id="mobno" name="mobno" placeholder="Mobile Number"
                                                           value="${loggedInUser.phone != null ? loggedInUser.phone : ''}"  oninput="validateField('mobno')">
                                                    <div id="mobnoError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Address -->
                                                <div class="mb-3">
                                                    <label class="form-label" for="address">Address</label>
                                                    <input type="text" class="form-control" id="address" name="address" placeholder="Address"
                                                           value="${loggedInUser.address != null ? loggedInUser.address : ''}" oninput="validateField('address')">
                                                    <div id="addressError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Email -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="email">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                                           value="${loggedInUser.email != null ? loggedInUser.email : ''}" oninput="validateField('email')">
                                                    <div id="emailError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Username -->
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="uname">User Name:</label>
                                                    <input type="text" class="form-control" id="uname" name="uname" placeholder="User Name"
                                                           value="${loggedInUser.username != null ? loggedInUser.username : ''}" oninput="validateField('uname')">
                                                    <div id="unameError" class="text-danger" style="display: none;"></div>
                                                </div>

                                                <!-- Created At (Read-only) -->
                                                <div class="mb-3 col-md-6">
                                                    <label for="createdAt">Created At:</label>
                                                    <input type="text" class="form-control" id="createdAt" name="createdAt"
                                                           value="${loggedInUser.createdAt != null ? loggedInUser.createdAt : ''}" readonly>
                                                </div>

                                                <!-- Updated At (Read-only) -->
                                                <div class="mb-3 col-md-6">
                                                    <label for="updatedAt">Updated At:</label>
                                                    <input type="text" class="form-control" id="updatedAt" name="updatedAt"
                                                           value="${loggedInUser.updatedAt != null ? loggedInUser.updatedAt : ''}" readonly>
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