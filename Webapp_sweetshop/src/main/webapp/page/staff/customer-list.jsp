<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <link rel="canonical" href="/customer-list.jsp" />
    <title>Customer List</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&amp;display=swap" rel="stylesheet">
    <link class="js-stylesheet" href="../../assets/css/light.css" rel="stylesheet">

    <style>
        body {
            opacity: 0;
        }

        .content {
            padding: 0px;
        }

        .pagination {
            margin-top: 20px; /* Space above pagination */
        }

        .pagination .btn {
            background-color: #007bff; /* Primary button color */
            border: none;
            color: white;
            transition: background-color 0.2s;
        }

        .pagination .btn:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }

        .pagination .page-info {
            font-weight: bold;
            font-size: 1rem; /* Adjust font size */
            color: #333; /* Text color for better visibility */
        }

        .pagination .page-link {
            border: 1px solid #007bff;
            border-radius: 5px; /* Rounded corners for page numbers */
            width: 36px; /* Fixed width for buttons */
            height: 36px; /* Fixed height for buttons */
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 4px; /* Space between page number buttons */
            color: #007bff; /* Color for page numbers */
            background-color: white; /* Background color for buttons */
            transition: background-color 0.2s, color 0.2s;
        }

        .pagination .page-link:hover {
            background-color: #007bff; /* Background color on hover */
            color: white; /* Text color on hover */
        }

        .pagination .page-link.active {
            background-color: #007bff; /* Active page button color */
            color: white; /* Active text color */
        }

        .pagination .page-link.disabled {
            background-color: #e9ecef; /* Disabled button background */
            color: #6c757d; /* Disabled text color */
            cursor: not-allowed; /* Change cursor for disabled */
        }

        .btn btn-primary {
            background-color: #007bff; /* Màu xanh nước biển */
            border-color: #007bff; /* Màu viền xanh nước biển */
            color: #ffffff; /* Màu chữ trắng */
        }

        .btn btn-primary:hover {
            background-color: #0056b3; /* Màu xanh đậm hơn khi hover */
            border-color: #0056b3; /* Màu viền đậm hơn khi hover */
        }

    </style>
</head>

<body data-theme="default" data-layout="fluid" data-sidebar-position="left" data-sidebar-layout="default">
<div class="wrapper">
    <jsp:include page="../common/sidebar.jsp"></jsp:include>

    <div class="main">
        <jsp:include page="../common/navbar.jsp"></jsp:include>

        <main class="content">
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card">
                            <!-- Phần hiển thị thông báo -->
                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger text-center">
                                        ${param.error}
                                </div>
                            </c:if>
                            <c:if test="${not empty param.message}">
                                <div class="alert alert-success text-center">
                                        ${param.message}
                                </div>
                            </c:if>
                            <div class="card-header pb-0 d-flex align-items-center justify-content-between">
                                <!-- Combined form for search and status -->
                                <form class="d-flex align-items-center w-100" action="/getcustomer" method="post">
                                    <!-- Left side: Search input -->

                                    <div class="left-side col-4 me-3">
                                        <div class="input-group input-group-navbar">
                                            <input type="text" name="search" class="form-control" placeholder="Search…" aria-label="Search"
                                                   value="${search != null ? search : ''}">
                                            <button class="btn" type="submit">
                                                <i class="align-middle" data-feather="search"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Hidden field for maintaining the current status value -->
                                    <input type="hidden" id="currentStatus" name="status" value="${status != null ? status : 'all'}">
                                    <!-- Right side: Status buttons -->
                                    <div class="right-side d-flex align-items-center ms-auto">
                                        <div class="btn-group me-3" role="group" aria-label="Status buttons">
                                            <button type="button" onclick="setStatus('all')"
                                                    class="btn ${status == null || status == 'all' ? 'btn-primary' : 'btn-outline-primary'}">All</button>
                                            <button type="button" onclick="setStatus('active')"
                                                    class="btn ${status == 'active' ? 'btn-primary' : 'btn-outline-primary'}">Active</button>
                                            <button type="button" onclick="setStatus('disabled')"
                                                    class="btn ${status == 'disabled' ? 'btn-primary' : 'btn-outline-primary'}">Disabled</button>
                                        </div>

                                        <div class="dropdown me-3">
                                            <button class="btn btn-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                                Sort
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                                                <li><a class="dropdown-item" href="#">Name Ascending</a></li>
                                                <li><a class="dropdown-item" href="#">Name Descending</a></li>
                                                <li><a class="dropdown-item" href="#">Phone Ascending</a></li>
                                                <li><a class="dropdown-item" href="#">Phone Descending</a></li>
                                                <li><a class="dropdown-item" href="#">Date of Birth (Oldest First)</a></li>
                                                <li><a class="dropdown-item" href="#">Date of Birth (Youngest First)</a></li>
                                            </ul>
                                        </div>

                                        <!-- Add New Staff Button -->
                                        <a class="btn btn-success me-3" href="/addcustomer">Add New Customer</a>
                                    </div>
                                </form>
                            </div>

                            <div class="card-body">
                                <!-- Check if staffs is empty -->
                                <c:choose>
                                    <c:when test="${not empty requestScope.customers}">
                                        <table id="userTable" class="table table-striped" style="width:100%">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Date Of Birth</th>
                                                <th>Phone</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                            </thead>
                                            <tbody id="customerBody">
                                            <c:forEach var="customer" items="${requestScope.customers}" varStatus="loopStatus">
                                                <tr class="staffRow">
                                                    <td><img src="data:image/png;base64,${customer.avatar}" width="32" height="32" class="rounded-circle my-n1" alt="Avatar"></td>
                                                    <td>${customer.fullName}</td>
                                                    <td>${customer.dob}</td>
                                                    <td>${customer.phone}</td>
                                                    <td>
                                                <span class="badge ${customer.status == 1 ? 'bg-primary' : 'bg-danger'}">
                                                        ${customer.status == 1 ? 'Active' : 'Disabled'}
                                                </span>
                                                    </td>
                                                    <td>
                                                        <!-- Update Customer Form -->
                                                        <form action="/editcustomer" method="post" style="display: inline-block; margin-right: 8px;">
                                                            <input type="hidden" name="id" value="${customer.id}" />
                                                            <button type="submit" class="btn btn-link text-primary p-0" title="Edit" style="border: none;">
                                                                <i class="align-middle" data-feather="edit"></i>
                                                            </button>
                                                        </form>

                                                        <!-- Change Status Form -->
                                                        <c:if test="${customer.status == 1}">
                                                            <!-- Form to Deactivate Customer -->
                                                            <form action="/changecustomerstatus" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to deactivate this customer?');">
                                                                <input type="hidden" name="id" value="${customer.id}" />
                                                                <input type="hidden" name="status" value="1" />
                                                                <button type="submit" class="btn btn-link text-warning p-0" title="Deactivate" style="border: none;">
                                                                    <i class="align-middle" data-feather="user-x"></i>
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <c:if test="${customer.status == 0}">
                                                            <!-- Form to Activate Customer -->
                                                            <form action="/changecustomerstatus" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to activate this customer?');">
                                                                <input type="hidden" name="id" value="${customer.id}" />
                                                                <input type="hidden" name="status" value="0" />
                                                                <button type="submit" class="btn btn-link text-success p-0" title="Activate" style="border: none;">
                                                                    <i class="align-middle" data-feather="user-check"></i>
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>

                                        <!-- Pagination Controls -->
                                        <div id="paginationControls" class="pagination mt-4 d-flex justify-content-end align-items-center">
                                            <button id="prevButton" class="btn btn-secondary me-2" onclick="changePage(-1)">Previous</button>
                                            <div id="pageNumbers" class="d-flex me-2">
                                                <!-- Page numbers will be generated here -->
                                            </div>
                                            <button id="nextButton" class="btn btn-secondary" onclick="changePage(1)">Next</button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Message for empty staff list -->
                                        <div class="alert alert-info text-center">
                                            No customer members found.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <jsp:include page="../common/footer.jsp"></jsp:include>
    </div>
</div>
<script>
    // Function to show a confirmation delete
    function confirmDelete() {
        return confirm("Are you sure you want to lock this customer?");
    }
    function setStatus(status) {
        document.getElementById('currentStatus').value = status;
        document.forms[0].submit(); // Gửi form
    }
</script>

<script>
    window.onload = function() {
        // Lấy giá trị trạng thái hiện tại từ input ẩn
        const currentStatus = document.getElementById('currentStatus').value;

        // Lấy tất cả các phần tử 'button' trong nhóm nút
        const buttons = document.querySelectorAll('.btn-group .btn');

        // Lặp qua từng nút để kiểm tra trạng thái và áp dụng lớp active
        buttons.forEach(button => {
            // Lấy giá trị trạng thái từ thuộc tính onclick của nút
            const statusValue = button.getAttribute('onclick').match(/setStatus\('(\w+)'\)/)[1];

            if (statusValue === currentStatus) {
                // Thêm lớp btn-primary cho nút đang được chọn
                button.classList.remove('btn-outline-primary');
                button.classList.add('btn-primary');
            } else {
                // Các nút khác giữ lớp btn-outline-primary
                button.classList.remove('btn-primary');
                button.classList.add('btn-outline-primary');
            }
        });
    };


</script>
<!-- Feather Icons -->
<script src="https://unpkg.com/feather-icons"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Feather Icons
    feather.replace();
</script>
<script src="../../assets/js/user/sidebar.js"></script>
<script src="../../assets/js/user/paging.js"></script>
<script src="../../assets/js/user/sortuser.js"></script>
<script src="../../assets/js/app.js"></script>
</body>
</html>