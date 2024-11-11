<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 10/6/2024
  Time: 7:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="header.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Orders List | E-Shopper</title>
  <script src="../assets/js/jquery.js"></script>
  <script src="../assets/js/bootstrap.min.js"></script>
  <script src="../assets/js/jquery.scrollUp.min.js"></script>
  <script src="../assets/js/jquery.prettyPhoto.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      padding: 20px;
    }
    .container {
      max-width: 1000px;
      margin: auto;
      background: #fff;
      padding: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    h2 {
      color: #333;
      border-bottom: 2px solid #eaeaea;
      padding-bottom: 10px;
    }
    .order-table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }
    .order-table th, .order-table td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: left;
    }
    .order-table th {
      background-color: #f4f4f4;
    }
    .pagination {
      margin-top: 20px;
      display: flex;
      justify-content: center;
    }
    .pagination a {
      margin: 0 5px;
      padding: 8px 12px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 4px;
    }
    .pagination a:hover {
      background-color: #0056b3;
    }
    .filters {
      margin: 20px 0;
      display: flex;
      justify-content: space-between;
    }
    .filters div {
      flex-basis: 48%;
    }
    .filters label {
      margin-right: 10px;
    }
    .filters input[type="text"], .filters input[type="date"], .filters select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .sidebar {
      margin-top: 30px;
    }
    .sidebar h4 {
      border-bottom: 2px solid #ddd;
      padding-bottom: 10px;
      margin-bottom: 20px;
    }
    .sidebar .search-box, .sidebar .category, .sidebar .latest-products {
      margin-bottom: 20px;
    }
    .sidebar input[type="text"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .sidebar ul {
      list-style-type: none;
      padding: 0;
    }
    .sidebar ul li {
      padding: 5px 0;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Orders List</h2>

  <div class="filters">
    <div>
      <label for="filterDate">Filter by Date:</label>
      <input type="date" id="filterDate" name="filterDate">
    </div>
    <div>
      <label for="filterStatus">Filter by Status:</label>
      <select id="filterStatus" name="filterStatus">
        <option value="all">All</option>
        <option value="submitted">Submitted</option>
        <option value="shipped">Shipped</option>
        <option value="delivered">Delivered</option>
      </select>
    </div>
  </div>

  <table class="order-table">
    <thead>
    <tr>
      <th>Order ID</th>
      <th>Order Date</th>
      <th>Customer Name</th>
      <th>First Product</th>
      <th>Other Products</th>
      <th>Total Price</th>
      <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td><a href="OrderDetails.jsp?orderId=123">123</a></td>
      <td>2024-10-05</td>
      <td>John Doe</td>
      <td>Product A</td>
      <td>2 more items</td>
      <td>$150</td>
      <td>Submitted</td>
    </tr>

    </tbody>
  </table>

  <div class="pagination">
    <a href="#">«</a>
    <a href="#">1</a>
    <a href="#">2</a>
    <a href="#">3</a>
    <a href="#">»</a>
  </div>

  <div class="sidebar">
    <div class="search-box">
      <h4>Search Orders</h4>
      <input type="text" name="searchOrder" placeholder="Search by ID or name...">
    </div>
    <div class="category">
      <h4>Product Categories</h4>
      <ul>
        <li>Electronics</li>
        <li>Clothing</li>
        <li>Home & Kitchen</li>
      </ul>
    </div>
    <div class="latest-products">
      <h4>Latest Products</h4>
      <ul>
        <li>Product 1</li>
        <li>Product 2</li>
        <li>Product 3</li>
      </ul>
    </div>
  </div>
</div>
</body>
</html>
