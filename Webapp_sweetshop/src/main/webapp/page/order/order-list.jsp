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
  <link rel="canonical" href="order-list.jsp" />
  <title>Order List</title>
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
                <form class="d-flex align-items-center w-100" action="/getorder" method="post">
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
                      <!-- 'All' Button -->
                      <button type="button" onclick="setStatus('all')"
                              class="btn ${status == null || status == 'all' ? 'btn-primary' : 'btn-outline-primary'}">All</button>

                      <!-- 'Pending' Button (1) -->
                      <button type="button" onclick="setStatus('1')"
                              class="btn ${status == '1' ? 'btn-primary' : 'btn-outline-primary'}">Placed</button>

                      <!-- 'In Progress' Button (2) -->
                      <button type="button" onclick="setStatus('2')"
                              class="btn ${status == '2' ? 'btn-primary' : 'btn-outline-primary'}">In Progress</button>

                      <!-- 'Shipping' Button (3) -->
                      <button type="button" onclick="setStatus('3')"
                              class="btn ${status == '3' ? 'btn-primary' : 'btn-outline-primary'}">Shipping</button>

                      <!-- 'Completed' Button (4) -->
                      <button type="button" onclick="setStatus('4')"
                              class="btn ${status == '4' ? 'btn-primary' : 'btn-outline-primary'}">Completed</button>

                      <!-- 'Cancelled' Button (0) -->
                      <button type="button" onclick="setStatus('0')"
                              class="btn ${status == '0' ? 'btn-primary' : 'btn-outline-primary'}">Cancelled</button>
                    </div>

                    <div class="dropdown me-3">
                      <button class="btn btn-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort
                      </button>
                      <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                        <li><a class="dropdown-item" href="#">Consignee Name Ascending</a></li>
                        <li><a class="dropdown-item" href="#">Consignee Name Descending</a></li>
                        <li><a class="dropdown-item" href="#">Phone Ascending</a></li>
                        <li><a class="dropdown-item" href="#">Phone Descending</a></li>
                        <li><a class="dropdown-item" href="#">Delivery Date (Earliest)</a></li>
                        <li><a class="dropdown-item" href="#">Date of Birthh (Latest)</a></li>
                      </ul>
                    </div>

                    <!-- Add New Staff Button -->
                    <a class="btn btn-success me-3" href="/addorder">Add New Order</a>
                  </div>
                </form>
              </div>

              <div class="card-body">
                <!-- Check if staffs is empty -->
                <c:choose>
                  <c:when test="${not empty requestScope.orders}">
                    <table id="userTable" class="table table-striped" style="width:100%">
                      <thead>
                      <tr>
                        <th>ID</th>
                        <th>Consignee</th>
                        <th>Delivery Time</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Action</th>
                      </tr>
                      </thead>
                      <tbody id="staffBody">
                      <c:forEach var="order" items="${requestScope.orders}" varStatus="loopStatus">
                        <tr class="staffRow">
                          <td>${order.id}</td>
                          <td>${order.consignee}</td>
                          <td>${order.deliveryTime}</td>
                          <td>${order.phone}</td>
                          <td>
                            <!-- Badge cho trạng thái đơn hàng -->
                            <span class="badge
                              ${order.status == 1 ? 'bg-info' :
                                order.status == 2 ? 'bg-warning' :
                                order.status == 3 ? 'bg-primary' :
                                order.status == 4 ? 'bg-success' :
                                'bg-danger'}">
                                ${order.status == 0 ? 'Cancelled' :
                                        order.status == 1 ? 'Placed' :
                                                order.status == 2 ? 'Processing' :
                                                        order.status == 3 ? 'Shipping' :
                                                                'Completed'}
                            </span>
                          </td>
                          <td>
                            <!-- Form Update Order -->
                            <form action="/editorder" method="post" style="display: inline-block; margin-right: 8px;">
                              <input type="hidden" name="id" value="${order.id}" />
                              <button type="submit" class="btn btn-link text-primary p-0" title="Edit" style="border: none;">
                                <i class="align-middle" data-feather="edit"></i>
                              </button>
                            </form>
                            <!-- Nút thay đổi trạng thái đơn hàng -->
                            <c:if test="${order.status != 4 && order.status != 0}">
                              <form action="/changeorderstatus" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to update this order status?');">
                                <input type="hidden" name="id" value="${order.id}" />
                                <input type="hidden" name="status" value="${order.status + 1}" /> <!-- Trạng thái tiếp theo -->
                                <button type="submit" class="btn ${order.status == 1 ? 'btn-warning' : order.status == 2 ? 'btn-info' : 'btn-success'} p-0" title="Change Status" style="border: none;">
                                  <!-- Hiển thị biểu tượng và tên trạng thái hiện tại -->
                                  <c:choose>
                                    <c:when test="${order.status == 1}">
                                      <i class="align-middle" data-feather="clock"></i> Pending
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                      <i class="align-middle" data-feather="tool"></i> Processing
                                    </c:when>
                                    <c:when test="${order.status == 3}">
                                      <i class="align-middle" data-feather="truck"></i> Shipping
                                    </c:when>
                                    <c:otherwise>
                                      <i class="align-middle" data-feather="check-circle"></i> Completed
                                    </c:otherwise>
                                  </c:choose>
                                </button>
                              </form>
                            </c:if>

                            <!-- Nút hủy đơn hàng -->
                            <c:if test="${order.status != 0 && order.status != 4}">
                              <form action="/changeorderstatus" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to cancel this order?');">
                                <input type="hidden" name="id" value="${order.id}" />
                                <input type="hidden" name="status" value="0" /> <!-- Trạng thái 0 là hủy -->
                                <button type="submit" class="btn btn-link text-danger p-0" title="Cancel" style="border: none;">
                                  <i class="align-middle" data-feather="x-circle"></i>
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