<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 10/5/2024
  Time: 2:06 PM
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
  <title>Cart Completion | E-Shopper</title>
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
      max-width: 900px;
      margin: auto;
      background: #fff;
      padding: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    h2, h3 {
      color: #333;
      border-bottom: 2px solid #eaeaea;
      padding-bottom: 10px;
    }
    .order-summary {
      margin-bottom: 30px;
    }
    .order-summary p {
      font-size: 1.1em;
      line-height: 1.6em;
    }
    .total-price {
      font-weight: bold;
      font-size: 1.2em;
      text-align: right;
      margin-top: 20px;
    }
    .thank-you {
      margin: 30px 0;
      padding: 20px;
      background-color: #f0f8ff;
      border-left: 5px solid #5cb85c;
      font-size: 1.2em;
    }
    form button {
      padding: 10px 20px;
      background-color: #5cb85c;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    form button:hover {
      background-color: #4cae4c;
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
  <h2>Order Completion</h2>
  <div class="order-summary">
    <p>Your order has been successfully submitted!</p>
    <p>Order ID: ${order.id}</p> <!-- Lấy Order ID từ biến trong controller -->
    <p>Total: ${order.totalPrice}$</p> <!-- Lấy tổng từ biến trong controller -->
    <p>Thank you for shopping with us!</p>
  </div>
  <div class="order-details">
    <h3>Order Details</h3>
    <table>
      <tr>
        <th>Product Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
      </tr>
      <c:forEach var="item" items="${order.items}">
        <tr>
          <td>${item.product.name}</td>
          <td>${item.productDetail.price}$</td>
          <td>${item.quantity}</td>
          <td>${item.productDetail.price * item.quantity}$</td>
        </tr>
      </c:forEach>
    </table>
  </div>
  <div class="thank-you">
    You will receive an email confirmation with order details and payment instructions shortly.
  </div>

  <form method="POST" action="OrdersList.jsp">
    <button type="submit">Go to Orders List</button>
  </form>

  <div class="sidebar">
    <div class="search-box">
      <h4>Search Products</h4>
      <input type="text" name="search" placeholder="Search products...">
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