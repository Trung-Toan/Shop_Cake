<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/1/2024
  Time: 10:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .table-container {
            margin: 20px 0;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .form-inline {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .form-inline input, .form-inline select, .form-inline button {
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .table {
            width: 100%;
            margin-bottom: 1rem;
            background-color: transparent;
        }

        .table th, .table td {
            padding: 0.75rem;
            vertical-align: top;
            border-top: 1px solid #dee2e6;
        }

        .table thead th {
            vertical-align: bottom;
            border-bottom: 2px solid #dee2e6;
            background-color: #f8f9fa;
        }

        .table tbody + tbody {
            border-top: 2px solid #dee2e6;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        .pagination button, .pagination input {
            margin: 0 5px;
        }

        /* Additional styles to match the first image */
        .form-inline input[type="text"] {
            border-radius: 20px;
            border: 1px solid #ccc;
            padding: 5px 10px;
        }

        .form-inline button, .form-inline select {
            border-radius: 20px;
            padding: 5px 10px;
        }

        .table-container table {
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        .table-container table thead th {
            background-color: #f5f5f5;
            border: none;
        }

        .table-container table tbody tr {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .table-container table tbody tr:hover {
            transform: translateY(-2px);
        }

        .table-container table tbody tr td {
            border: none;
        }

        .table-container .pagination input[type="text"] {
            border-radius: 20px;
            border: 1px solid #ccc;
            padding: 5px 10px;
            text-align: center;
        }

        .table-container .pagination button {
            border-radius: 20px;
            padding: 5px 10px;
        }

        .btn-link {
            color: #007bff;
            text-decoration: none;
            background-color: transparent;
            border: none;
            padding: 0;
        }
        /* Styles for the popup overlay */
        .popup {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: none; /* Hidden by default */
            justify-content: center;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
            z-index: 1000; /* Ensure it is on top of other content */
        }

        /* Styles for the popup content */
        .popup-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.25);
            text-align: center;
            max-width: 400px;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Styles for the image inside the popup */
        .popup-content img {
            max-width: 100px;
            margin-bottom: 20px;
        }

        /* Styles for the popup message */
        .popup-content #popupMessage {
            font-size: 16px;
            margin-bottom: 20px;
            display: block;
            font-weight:bold;
        }

        /* Styles for the popup buttons */
        .popup-buttons {
            display: flex;
            justify-content: space-around;
            width: 100%;
        }

        .popup-buttons button {
            background-color:#6600cc; /* Green color */
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .popup-buttons button:hover {
            background-color: #660099; /* Darker green color */
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">

<!-- header start -->
<%@include file="adheader.jsp" %>
<!-- header end -->
<!-- Left sidebar menu start -->
<%@include file="leftmenu.jsp" %>
<!-- Left sidebar menu end -->

<!--Main container start -->
<main class="ttr-wrapper">
    <div class="container-fluid">
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title">User List</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>User List</li>
            </ul>
        </div>

        <div class="row">
            <!-- User List Section -->
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <div class="table-container">
                        <form class="form-inline mb-3" method="get" action="${pageContext.request.contextPath}/AccountListController/show">
                            <div class="form-group mb-2">
                                <select class="form-control" name="searchBy"> <!-- searchBy -->
                                    <option value="Username" <c:if test="${param.searchBy == 'Username'}">selected</c:if>>Name</option>
                                    <option value="UserID" <c:if test="${param.searchBy == 'UserID'}">selected</c:if>>ID</option>
                                    <option value="email" <c:if test="${param.searchBy == 'email'}">selected</c:if>>Email</option>
                                </select>
                            </div>
                            <div class="form-group mx-sm-3 mb-2">
                                <!-- query -->
                                <input class="form-control" type="text" name="query" value="${param.query}" placeholder="Search for a user">
                                <input type="hidden" name="page" value="${currentPage}">
                            </div>
                            <a href="${pageContext.request.contextPath}/AccountListController/newuser" class="btn btn-primary mb-2 ml-2">Add new user</a>
                        </form>
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>
                                    <!-- sortBy , order -->
                                    ID
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=UserID&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=UserID&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Name
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=Username&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=Username&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Fullname
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=FullName&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=FullName&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Email
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=email&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=email&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Phone
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=Phone&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=Phone&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Role
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=SettingName&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=SettingName&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    ClubName
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=club.Type&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=club.Type&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>
                                    Status
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=user.status&order=asc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↑</a>
                                    <a href="${pageContext.request.contextPath}/AccountListController/show?sortBy=user.status&order=desc&searchBy=${param.searchBy}&query=${param.query}&page=${currentPage}"> ↓</a>
                                </th>
                                <th>Action1</th>
                                <th>Action2</th>
                            </tr>
                            </thead>
                            <c:forEach items="${userList}" var="user">
                                <tr>
                                    <td>${user.getUserId()}</td>
                                    <td>${user.getUsername()}</td>
                                    <td>${user.getFname()}</td>
                                    <td>${user.getEmail()}</td>
                                    <td>${user.getPhone()}</td>
                                    <td>${user.getSettingName()}</td>
                                    <td>${user.getClubname()}</td>
                                    <c:choose>
                                        <c:when test="${user.isStatus() == true}">
                                            <td>Active</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>Deactive</td>
                                        </c:otherwise>
                                    </c:choose>

                                    <td>
                                        <c:choose>
                                            <c:when test="${user.isStatus() == true}">
                                                <a href="#" class="btn btn-link" onclick="showPopup(deactivate,${user.getUserId()})">Deactive</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" class="btn btn-link" onclick="showPopup(activate,${user.getUserId()})">Activate</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <form action="${pageContext.request.contextPath}/AccountListController/showDetails" method="post">
                                            <button type="submit" class="btn btn-link">Edit</button>
                                            <input type="hidden" name="userid" value="${user.getUserId()}">
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
            <!-- User List Section END -->
        </div>
    </div>
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/AccountListController/show?page=${currentPage - 1}&searchBy=${param.searchBy}&query=${param.query}" class="btn btn-light">&lt; Previous</a>
        </c:if>
        <span>Page ${currentPage} of ${totalPages}</span>
        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/AccountListController/show?page=${currentPage + 1}&searchBy=${param.searchBy}&query=${param.query}" class="btn btn-light">Next &gt;</a>
        </c:if>
    </div>
    <div class="popup" id="confirmationPopup" >
        <div class="popup-content">
            <img src="${pageContext.request.contextPath}/assets/images/deactivate.png"/>
            <span id="popupMessage"></span>
            <div class="popup-buttons">
                <button onclick="confirmAction()">Yes</button>
                <button onclick="hidePopup()">No</button>
            </div>
        </div>
    </div>
    <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
</main>
<div class="ttr-overlay"></div>
</head>
<body>

</body>
</html>
